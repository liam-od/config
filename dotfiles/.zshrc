add_to_path() {
    case ":${PATH}:" in
        *:"$1":*) ;;
        *) export PATH="$1:$PATH" ;;
    esac
}

ghw() {
  local target browser
  if [[ "$PWD" == */workspace/enki/* ]]; then
    target=liam-enki browser=google-chrome-stable
  else
    target=liam-od browser=brave-browser
  fi
  local current=$(gh auth status --json activeAccount -q '.activeAccount' 2>/dev/null)
  [[ "$current" != "$target" ]] && gh auth switch -u "$target" 2>/dev/null
  GH_BROWSER=$browser gh "$@"
}

add_to_path "/opt/nvim"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.opencode/bin" # Not added to installs yet
add_to_path "/usr/local/go/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export SUDO_EDITOR=/opt/nvim/nvim

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"
eval "$(cj shell zsh)"

. ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

alias va="source .venv/bin/activate"
alias dva="deactivate"
alias ls='eza --icons -F -H --group-directories-first -git -1'
alias ltree="eza --tree --level=2  --icons --git"
alias cd="z"
alias vim="nvim"
alias gs="git status"
alias gd="git diff"
alias gl="git log"
alias goo="ghw browse"
alias gob="ghw browse -b \$(git branch --show-current)"
alias gop="ghw pr view --web"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="claude"
alias cw="CLAUDE_CONFIG_DIR=~/.claude-work claude"
alias hq='harlequin'
alias bfdb='harlequin -a postgres "postgresql://postgres:password@localhost:63333/postgres"'
alias cjt='/home/liam/workspace/wizards/conjure/conjure'

# Fuzzy-resume any Claude Code session, from any cwd, across both config dirs.
# `/resume` only lists sessions for the current directory and current
# CLAUDE_CONFIG_DIR; this searches everything and jumps to the right pair.
cr() {
  emulate -L zsh
  local list row ts f cwd title id cdir   # not `path`: that is zsh's $PATH array
  list=$(
    for base in ~/.claude ~/.claude-work; do
      find "$base/projects" -maxdepth 2 -name '*.jsonl' -printf '%T@\t%p\n' 2>/dev/null
    done | sort -rn | head -300 | while IFS=$'\t' read -r ts f; do
      cwd=$(grep -ho '"cwd":"[^"]*"' "$f" 2>/dev/null | head -1 | sed 's/.*":"//;s/"$//')
      title=$(grep -ho '"aiTitle":"[^"]*"' "$f" 2>/dev/null | tail -1 | sed 's/.*":"//;s/"$//')
      printf '%s\t%s\t%s\t%s\n' "$(date -d "@${ts%.*}" '+%m-%d %H:%M')" \
        "${title:-(untitled)}" "${cwd/#$HOME/~}" "$f"
    done
  )
  [[ -z $list ]] && { print -u2 "cr: no sessions found"; return 1; }
  row=$(printf '%s\n' "$list" | fzf --delimiter=$'\t' --with-nth=1,2,3 \
          --header='Resume a Claude session (any dir / any config dir)') || return
  [[ -z $row ]] && return
  f=$(printf '%s' "$row" | cut -f4)
  cwd=$(printf '%s' "$row" | cut -f3); cwd=${cwd/#\~/$HOME}
  id=${${f:t}:r}
  [[ $f == $HOME/.claude-work/* ]] && cdir=$HOME/.claude-work || cdir=$HOME/.claude
  cd "$cwd" && CLAUDE_CONFIG_DIR="$cdir" claude --resume "$id"
}

__wezterm_osc7() {
  local url="file://$HOST$PWD"
  if [[ -n "$TMUX" ]]; then
    printf '\ePtmux;\e\e]7;%s\a\e\\' "$url"
  else
    printf '\e]7;%s\a' "$url"
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd __wezterm_osc7
__wezterm_osc7

if [[ -z "$TMUX" ]]; then
  tmux attach 2>/dev/null || tmux new-session
fi
