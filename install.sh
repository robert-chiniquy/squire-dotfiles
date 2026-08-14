#!/usr/bin/env bash
# squire-dotfiles installer.
#
# Squire clones this repo to ~/.dotfiles inside each Linux env at creation and
# runs this script. Keep it idempotent (safe to re-run) and Linux-only — no
# Homebrew, no macOS defaults, nothing that assumes a desktop.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Symlink a repo file into place, creating parent dirs. -f replaces a stale link.
link() {
  local from="$1" to="$2"
  mkdir -p "$(dirname "$to")"
  ln -sfn "$from" "$to"
}

link "$SRC/config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

echo "squire-dotfiles: linked zellij config"
