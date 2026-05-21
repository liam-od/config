# CLAUDE.md

## Aliases

### Path

- `nvim config` = `~/config/dotfiles/.config/nvim/`
- `nvim plugins` = `~/config/dotfiles/.config/nvim/lua/plugins/`
- `dotfiles` = `~/config/dotfiles/`
- `thesis` = `~/workspace/thesis/18977995-masters-thesis/`
- `client` = `~/workspace/enki/bytefuse/bytefuse-client/`
- `services` = `~/workspace/enki/bytefuse/bytefuse-services/`

### Shell

The following aliases are active in this shell

- `ls` → `eza --icons -F -H --group-directories-first -git -1`
- `cd` → `z` (zoxide)

## Git Configuration

You have two GitHub accounts with separate SSH keys and git configs:

**Personal Account (liam-od)**
- GitHub username: `liam-od`
- Email: `liamgregoryod@gmail.com`
- SSH host: `github.com` (uses `~/.ssh/liam` key)
- Organizations owned: `wizards-ai`
- Default config in `~/.gitconfig`

**Work Account (liam-enki)**
- GitHub username: `liam-enki`
- Email: `liam@enki.sh`
- SSH host: `github.com-enki` (uses `~/.ssh/enki` key, aliased to github.com)
- Repos: Any repo under `~/workspace/enki/`
- Config applied via conditional include in `~/.gitconfig`

**How it works**: When you're in `~/workspace/enki/` repos, git automatically uses the
enki account credentials and SSH key. This is handled by `.gitconfig` includeIf directives
and URL rewriting (`git@github.com` → `git@github.com-enki`).

**For gh CLI**: When running `gh` commands, it will use the currently authenticated account
based on your git config. Specify the account context when needed with flags or by ensuring
you're in the correct directory context.
