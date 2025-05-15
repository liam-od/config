eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add /opt/nvim to PATH if it isn't added yet
case ":${PATH}:" in
    *:"/opt/nvim":*)
        ;;
    *)
        export PATH="${PATH:+$PATH:}/opt/nvim"
        ;;
esac

# Add $HOME/.local/bin to PATH if it isn't added yet
case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        export PATH="$HOME/.local/bin:$PATH"
        ;;
esac

. ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias va="source .venv/bin/activate"
alias dva="deactivate"
alias ls='eza --icons -F -H --group-directories-first -git -1'
alias vim="nvim"
alias gs="git status"
alias gd="git diff"

lmk() {
    if [[ $1 == "-save" ]]; then
        shift
        latexmk -pdf -outdir=build "$@"
    else
        latexmk -pdf -synctex=1 -interaction=nonstopmode -pvc -outdir=build "$@"
    fi
}

bindkey '^ ' autosuggest-accept
