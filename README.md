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

### WSL:

- Install Hack Nerd Font on windows
- Copy .wezterm.lua to $USERPROFILE
- Keyboard speed limited in windows, need some thirdparty tool, AutoHotKey or similar.

### TODO

#### Next
- [ ] Tmux setup
- [ ] Aider support
- [ ] Create desktop file for wezterm with ansible
- [ ] Latex support (texlive, thesis theme)
- [ ] Obsidian and Zotero (with nvim stuff)

#### Nice to haves
- [ ] Configure history syncing with atuin register
- [ ] Brave + sync code
- [ ] Proton VPN
- [ ] Librewolf
