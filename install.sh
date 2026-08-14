#!/usr/bin/env bash
# squire-dotfiles installer.
#
# Squire clones this repo to ~/.dotfiles inside each Linux env at creation and
# runs this script. Keep it idempotent (safe to re-run) and Linux-only — no
# Homebrew, no macOS defaults, nothing that assumes a desktop.
set -euo pipefail
shopt -s dotglob nullglob

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Symlink a repo file into place, creating parent dirs. -f replaces a stale link.
link() {
  local from="$1" to="$2"
  mkdir -p "$(dirname "$to")"
  # Replace a pre-existing real file/dir (not one of our own symlinks) so the
  # link lands cleanly instead of nesting inside an existing directory.
  if [[ -e "$to" && ! -L "$to" ]]; then rm -rf "$to"; fi
  ln -sfn "$from" "$to"
}

# Install a core set of CLI tools via nix when missing — no-op where the image
# already ships them or nix is unavailable. Format: <binary>:<nixpkgs-attr>.
install_tools() {
  command -v nix >/dev/null 2>&1 || { echo "squire-dotfiles: nix absent, skipping tool install"; return 0; }
  local want="zsh:zsh rg:ripgrep bat:bat fzf:fzf starship:starship zellij:zellij nvim:neovim"
  local missing=() pair
  for pair in $want; do
    command -v "${pair%%:*}" >/dev/null 2>&1 || missing+=("nixpkgs#${pair##*:}")
  done
  if (( ${#missing[@]} )); then
    echo "squire-dotfiles: nix installing ${missing[*]}"
    nix profile install --extra-experimental-features 'nix-command flakes' "${missing[@]}" \
      || echo "squire-dotfiles: some tools failed to install (continuing)"
  else
    echo "squire-dotfiles: core tools already present"
  fi
}

install_tools

count=0

for entry in "$SRC"/home/*; do
  [[ -e "$entry" ]] || continue
  link "$entry" "$HOME/$(basename "$entry")"
  count=$((count + 1))
done

for entry in "$SRC"/config/*; do
  [[ -e "$entry" ]] || continue
  link "$entry" "$HOME/.config/$(basename "$entry")"
  count=$((count + 1))
done

echo "squire-dotfiles: linked $count entries from home/ and config/"
