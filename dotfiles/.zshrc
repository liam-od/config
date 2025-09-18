add_to_path() {
    case ":${PATH}:" in
        *:"$1":*) ;;
        *) export PATH="$1:$PATH" ;;
    esac
}

add_to_path "/opt/nvim"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.local/texlive/2025/bin/x86_64-linux"

if [[ -d "$HOME/.local/texlive/2025/texmf-dist/doc/man" ]]; then
    export MANPATH="$HOME/.local/texlive/2025/texmf-dist/doc/man:${MANPATH:-}"
fi

if [[ -d "$HOME/.local/texlive/2025/texmf-dist/doc/info" ]]; then
    export INFOPATH="$HOME/.local/texlive/2025/texmf-dist/doc/info:${INFOPATH:-}"
fi

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
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

lmk() {
    if [[ $1 == "-save" ]]; then
        shift
        latexmk -pdf -outdir=build "$@"
    else
        latexmk -pdf -synctex=1 -interaction=nonstopmode -pvc -outdir=build "$@"
    fi
}
