# squire-dotfiles

Lightweight, Linux-only personalization for Squire ephemeral dev environments.
Squire clones this repo to `~/.dotfiles` on every env creation and runs
`install.sh`.

Deliberately minimal — this is **not** a full desktop dotfiles repo. It carries
only what a remote Linux dev env needs, so it clones fast and never runs
macOS-specific setup.

## What it installs

Everything under `home/` links to `~/<name>`; everything under `config/`
links to `~/.config/<name>`. Entries marked (tool) only do anything useful if
that tool is also present in the env — the symlink itself is harmless either
way.

- **git + delta** — `home/.gitconfig`, `home/.gitignore_global` -> `~/.gitconfig`, `~/.gitignore_global` (tool: delta)
- **zsh** — `home/.zshrc`, `home/.zshenv` -> `~/.zshrc`, `~/.zshenv`
- **bash** — `home/.bash_login` -> `~/.bash_login`
- **readline** — `home/.inputrc` -> `~/.inputrc`
- **vim** — `home/.vimrc`, `home/.vim/` -> `~/.vimrc`, `~/.vim/`
- **neovim** — `config/nvim/` -> `~/.config/nvim/` (tool: neovim)
- **tmux** — `home/.tmux.conf` -> `~/.tmux.conf` (copy-mode yank falls back to `wl-copy`/`xclip`, tool: tmux)
- **ripgrep** — `home/.ripgreprc` -> `~/.ripgreprc` (tool: ripgrep)
- **bat** — `config/bat/` -> `~/.config/bat/` (tool: bat)
- **glow** — `config/glow/` -> `~/.config/glow/` (tool: glow)
- **atuin** — `config/atuin/` -> `~/.config/atuin/` (tool: atuin)
- **erdtree** — `config/erdtree/` -> `~/.config/erdtree/` (tool: erdtree)
- **yazi** — `config/yazi/` -> `~/.config/yazi/` (tool: yazi)
- **nushell** — `config/nushell/` -> `~/.config/nushell/` (tool: nushell)
- **starship** — `config/starship.toml` -> `~/.config/starship.toml` (tool: starship)
- **zellij** — `config/zellij/config.kdl` -> `~/.config/zellij/config.kdl`
  (vaporwave theme, custom keybinds, compact default layout; tool: zellij)

## Wiring it into Squire

```
squire dotfiles set --repo <https git url for this repo>
squire dotfiles get   # confirm
```

New envs pick it up automatically. The current one won't change —
personalization runs once, at env creation.

## Adding more later

`install.sh` links every entry under `home/` and `config/` automatically —
just drop a file or directory in the right one, no edit to `install.sh`
needed. Keep additions Linux-safe and lightweight; the script runs on every
env creation. Skills placed at `skills/<name>/SKILL.md` are auto-loaded into
every env.
