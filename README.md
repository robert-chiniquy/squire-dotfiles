# squire-dotfiles

Lightweight, Linux-only personalization for Squire ephemeral dev environments.
Squire clones this repo to `~/.dotfiles` on every env creation and runs
`install.sh`.

Deliberately minimal — this is **not** a full desktop dotfiles repo. It carries
only what a remote Linux dev env needs, so it clones fast and never runs
macOS-specific setup.

## What it installs

- **zellij** — `config/zellij/config.kdl` links to `~/.config/zellij/config.kdl`
  (vaporwave theme, custom keybinds, compact default layout)

## Wiring it into Squire

```
squire dotfiles set --repo <https git url for this repo>
squire dotfiles get   # confirm
```

New envs pick it up automatically. The current one won't change —
personalization runs once, at env creation.

## Adding more later

Drop a config under `config/<tool>/` and add one `link` line to `install.sh`.
Keep additions Linux-safe and lightweight; the script runs on every env
creation. Skills placed at `skills/<name>/SKILL.md` are auto-loaded into every
env.
