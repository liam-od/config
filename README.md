## WIP

First:
- `sudo apt install git`
- `git clone https://github.com/liam-od/config.git`

Move over ssh keys to .ssh/, then:
- `chmod 600 ~/.ssh/liam`
- `chmod 600 ~/.ssh/enki`

Script:
- `sudo apt update`
- `sudo apt install pipx`
- `pipx install ansible-core`
- `pipx ensurepath` Check if this makes changes to dotfiles.
- `source ~/.bashrc`
- `ansible-playbook playbook.yml`
- `git remote set-url origin git@github.com:liam-od/config.git`

`chsh -s $(which zsh)`
Login and out for the shell changes to take effect.

For WSL: `ansible-playbook playbook.yml -e "is_wsl=true"`

### Next

#### System Setup
- [] Install lazygit binary
- [X] Install flatpak (with flathub repo)
- [X] Install WezTerm via flatpak
- [X] Symlink `.wezterm.lua`

#### Neovim Config
- [ ] Finish mini.nvim setup
- [ ] Add lualine
- [ ] Add gitsigns (cool blame line)
- [ ] Add diffview
- [ ] Set up LSP
- [ ] Set up Copilot (free for student) / aider

brave + sync code.

proton vpn

librewolf

Install texlive stuff (+ thesis theme)

Obsidian and zotero setup

cursor
