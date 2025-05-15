eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Aliases
alias va="source .venv/bin/activate"
alias dva="deactivate"
alias ls='eza --icons -F -H --group-directories-first -git -1'
alias vim="nvim"

# Functions
lmk() {
    if [[ $1 == "-save" ]]; then
        shift
        latexmk -pdf -outdir=build "$@"
    else
        latexmk -pdf -synctex=1 -interaction=nonstopmode -pvc -outdir=build "$@"
    fi
}

# Sourcing
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Bindings
bindkey '^ ' autosuggest-accept

# Path stuff
. "$HOME/.local/bin/env"

# Direnv
eval "$(direnv hook zsh)"

# Nvim
export PATH="$PATH:/opt/nvim/"
