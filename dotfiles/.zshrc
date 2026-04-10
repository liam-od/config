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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

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
alias go="ghw browse"
alias gob="ghw browse -b \$(git branch --show-current)"
alias gop="ghw pr view --web"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="claude"
alias cw="CLAUDE_CONFIG_DIR=~/.claude-work claude"
alias bfdb='harlequin -a postgres "postgresql://postgres:password@localhost:63333/postgres"'

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
