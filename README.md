## Platform support

The automated installation is tested on Ubuntu 24.04 or later running the GNOME desktop environment.

Unsupported system? At least the dotfiles probably work.

## Setup

Clone the repository, then edit `dotfiles/.config/mise/config.toml` to choose your tools and versions (keep `ansible-core`). Prepare the local files described below, then run:

```bash
./setup
```

`setup` installs mise if missing, symlinks its global configuration without overwriting an existing config, installs the required Ansible collections, runs `mise install`, and runs the Ansible playbook. Requires `curl` and CA certificates for the mise download; prompts for your sudo password. Git preserves the script's executable permission—no `.sh` extension is needed.

When setup finishes, log out and back in to activate Zsh as the login shell and apply Docker group membership. Then launch WezTerm and you are ready to go.

Extra arguments go directly to Ansible, for example `./setup --skip-tags git`. The mise config symlink is owned by `setup`, not an Ansible role.

### Keyboard

GNOME keyboard defaults are defined in `roles/gnome/defaults/main.yml`:

```yaml
keyboard_xkb_options:
  - caps:escape
keyboard_repeat_interval: 8
keyboard_repeat_delay: 180
```

Change `caps:escape` to another XKB option, such as `caps:swapescape`, or use an empty list (`[]`) to leave Caps Lock without a custom mapping. The configured list replaces the user's existing GNOME XKB options.

## Config

Before running the playbook, create your local Git identity file:

```bash
cp host_vars/localhost.yml.example host_vars/localhost.yml
```

Then set your name and email in `host_vars/localhost.yml`. This file is ignored by Git.

Create your personal SSH configuration from the example:

```bash
cp dotfiles/.ssh/config.example dotfiles/.ssh/config
```

Edit it with your hosts and identities. Ansible symlinks it to `~/.ssh/config`, and the source file is ignored by Git.

### Restore private files with Bitwarden

Store `localhost.yml` and `config` as attachments on a uniquely named Secure Note, such as `Config`. Log in once per machine, then unlock the vault in each terminal session:

```bash
bw login
export BW_SESSION="$(bw unlock --raw)"
bw sync
```

From the repository root, restore both files with:

```bash
./scripts/restore-config "<item_name>"
```

The script requires one exact item match and one of each expected attachment, then installs both files with mode `0600`.

Restore a Bitwarden SSH Key item to `~/.ssh/<key_name>` and its public key to the matching `.pub` file:

```bash
./scripts/restore-keys "<key_name>"
```

The script prints the restored key's fingerprint. Closing the terminal clears `BW_SESSION`; use `bw lock` to invalidate it immediately.
