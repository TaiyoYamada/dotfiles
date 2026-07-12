#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  printf 'Homebrew is required. Install it from https://brew.sh and run this script again.\n' >&2
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brew bundle --file "$DOTFILES_DIR/Brewfile"
"$DOTFILES_DIR/install.sh"
"$DOTFILES_DIR/vscode/install-extensions.sh"
"$DOTFILES_DIR/macos/defaults.sh"
