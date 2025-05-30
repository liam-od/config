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

`chsh -s $(which zsh)`
Login and out for the shell changes to take effect.

We can now run `wezterm` to use our new terminal

For WSL: `ansible-playbook playbook.yml -e "is_wsl=true"`

### TODO

#### System Setup
- [X] Install lazygit binary
- [X] Install WezTerm
- [X] Symlink `.wezterm.lua`
- [X] Change cursor speed
- [ ] Latex support (texlive, thesis theme)
- [ ] Obsidian and Zotero

#### Neovim Config
- [ ] Finish mini.nvim setup
    - [ ] Tabline
    - [ ] Trailspace
    - [ ] Map
    - [ ] Files
    - [ ] Bracketed
- [ ] Bufferline (or Tabline)
- [ ] Persistence (or another session manager)
- [ ] Add lualine
- [ ] Add gitsigns (cool blame line)
- [ ] Add diffview
- [ ] Set up LSP
- [ ] Set up Copilot (free for student) / aider
- [ ] Obsidian and Zotero

#### Nice to haves

- [ ] Terminal completion
- [ ] Refactor playbook with roles
- [ ] Brave + sync code
- [ ] Proton VPN
- [ ] Librewolf
- [ ] Cursor IDE
