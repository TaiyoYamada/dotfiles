#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

bash -n install.sh bootstrap.sh check.sh vscode/install-extensions.sh macos/defaults.sh
zsh -n zsh/.zprofile zsh/.zshrc zsh/aliases.zsh
ruby -rjson -e 'JSON.parse(File.read(ARGV.fetch(0)))' config/karabiner/karabiner.json
ruby -rjson -e 'JSON.parse(File.read(ARGV.fetch(0)))' vscode/settings.json

if command -v luac >/dev/null 2>&1; then
  while IFS= read -r -d '' file; do
    luac -p "$file"
  done < <(find config/nvim config/wezterm -type f -name '*.lua' -print0)
fi

git diff --check
printf 'All checks passed.\n'
