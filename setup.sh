#!/bin/bash

set -e

ME=false
WSL=false

for arg in "$@"; do
  case $arg in
    --me)  ME=true ;;
    --wsl) WSL=true ;;
  esac
done

sudo apt update && sudo apt install -y pipx
pipx install ansible-core
export PATH="$PATH:$HOME/.local/bin"

CMD="ansible-playbook playbook.yml"

if $ME; then
  CMD="$CMD --ask-vault-pass"
  if $WSL; then
    CMD="$CMD --skip-tags fonts,system"
  fi
else
  if $WSL; then
    CMD="$CMD --skip-tags git,fonts,system"
  else
    CMD="$CMD --skip-tags git"
  fi
fi

eval "$CMD"
