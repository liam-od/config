## WIP

First:
- `sudo apt install git`
- `git clone https://github.com/liam-od/config.git`

Move over ssh keys to .ssh/, then:
- `chmod 600 ~/.ssh/liam`
- `chmod 600 ~/.ssh/enki`

Move over `.env` file

Script:
- `sudo apt update`
- `sudo apt install pipx`
- `pipx install ansible-core`
- `pipx ensurepath` Check if this makes changes to dotfiles.
- `source ~/.bashrc`
- `ansible-playbook playbook.yml`
- `git remote set-url origin git@github.com:liam-od/config.git`
- `npm install -g tree-sitter-cli`
- `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh`

`chsh -s $(which zsh)`
Login and out for the shell changes to take effect.

We can now run `wezterm` to use our new terminal

For WSL: `ansible-playbook playbook.yml -e "is_wsl=true"`

### TODO

#### Next
- [X] Install and configure zoxide
- [X] Tabs
- [X] Picker open files in splits or tabs
- [X] Lualine
- [X] Git (gitsigns and diffview)
- [ ] Popup terminal support (with REPL)
- [X] LSP
- [ ] Copilot (copilot cli, copilot chat, aider support?)
- [ ] Tmux (with session management, persistence? SessionX?)

#### Ansible
- [X] Install lazygit binary
- [X] Install WezTerm
- [X] Symlink `.wezterm.lua`
- [X] Change cursor speed
- [ ] Latex support (texlive, thesis theme)
- [ ] Obsidian and Zotero (with nvim stuff)

#### Plugins to try
- [ ] MINI.MAP
- [ ] MINI.FILES
- [ ] MINI.BRACKETED
- [ ] MINI.SNIPPETS
- [ ] MINI.TABLINE
- [ ] Bufferline.nvim

#### Nice to haves
- [ ] Terminal completion (i.e Fig)
- [ ] Refactor playbook with roles
- [ ] Brave + sync code
- [ ] Proton VPN
- [ ] Librewolf
