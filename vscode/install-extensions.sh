#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if command -v code >/dev/null 2>&1; then
  CODE_BIN="$(command -v code)"
elif [[ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
  CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
else
  printf 'Visual Studio Code is not installed; skipping extensions.\n' >&2
  exit 0
fi

while IFS= read -r extension; do
  [[ -z "$extension" || "$extension" == \#* ]] && continue
  "$CODE_BIN" --install-extension "$extension"
done < "$DOTFILES_DIR/vscode/extensions.txt"
