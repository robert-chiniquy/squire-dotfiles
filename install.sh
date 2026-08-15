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
  have() { command -v "$1" >/dev/null 2>&1; }
  local want="zsh:zsh rg:ripgrep bat:bat fzf:fzf starship:starship zellij:zellij nvim:neovim"

  # 1. nix where the image provides it — covers every tool at current versions.
  #    Bounded so a stuck download can't hang env boot; falls through to apt.
  if have nix; then
    local missing=() pair
    for pair in $want; do have "${pair%%:*}" || missing+=("nixpkgs#${pair##*:}"); done
    if (( ${#missing[@]} )); then
      echo "squire-dotfiles: nix installing ${missing[*]}"
      timeout 300 nix profile install --extra-experimental-features 'nix-command flakes' "${missing[@]}" \
        || echo "squire-dotfiles: nix install failed/timed out — trying apt"
    fi
  fi

  # 2. apt fallback for what nix didn't provide (Debian images). apt has no
  #    starship/zellij, so those stay config-only where nix is absent.
  if have apt-get && ! { have zsh && have fzf && have nvim; }; then
    echo "squire-dotfiles: apt fallback (zsh, fzf, neovim, ripgrep, bat)"
    sudo apt-get update -qq >/dev/null 2>&1 || true
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq zsh fzf neovim ripgrep bat >/dev/null 2>&1 || true
    have bat || { command -v batcat >/dev/null 2>&1 && sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat; }
  fi

  # 3. Make zsh the login shell once it exists (config is only useful as $SHELL).
  if have zsh; then
    local zsh_path; zsh_path="$(command -v zsh)"
    grep -qxF "$zsh_path" /etc/shells 2>/dev/null || echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null 2>&1 || true
    if [ "$(getent passwd "$(id -un)" 2>/dev/null | cut -d: -f7)" != "$zsh_path" ]; then
      sudo chsh -s "$zsh_path" "$(id -un)" >/dev/null 2>&1 && echo "squire-dotfiles: default shell -> zsh" || true
    fi
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
