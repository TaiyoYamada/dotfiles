#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
BACKUP_CREATED=false
CURRENT_GIT_NAME="$(git config --global --get user.name 2>/dev/null || true)"
CURRENT_GIT_EMAIL="$(git config --global --get user.email 2>/dev/null || true)"

backup_and_link() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    printf 'Already linked: %s\n' "$target"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ "$BACKUP_CREATED" == false ]]; then
      mkdir -p "$BACKUP_DIR"
      BACKUP_CREATED=true
    fi
    local relative_target="${target#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$relative_target")"
    mv "$target" "$BACKUP_DIR/$relative_target"
    printf 'Backed up: %s\n' "$target"
  fi

  ln -s "$source" "$target"
  printf 'Linked: %s -> %s\n' "$target" "$source"
}

backup_and_link "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"
backup_and_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$DOTFILES_DIR/config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
backup_and_link "$DOTFILES_DIR/config/wezterm/keybinds.lua" "$HOME/.config/wezterm/keybinds.lua"
backup_and_link "$DOTFILES_DIR/config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
backup_and_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
backup_and_link "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  if [[ -n "$CURRENT_GIT_NAME" || -n "$CURRENT_GIT_EMAIL" ]]; then
    touch "$HOME/.gitconfig.local"
    [[ -n "$CURRENT_GIT_NAME" ]] && git config --file "$HOME/.gitconfig.local" user.name "$CURRENT_GIT_NAME"
    [[ -n "$CURRENT_GIT_EMAIL" ]] && git config --file "$HOME/.gitconfig.local" user.email "$CURRENT_GIT_EMAIL"
    printf 'Preserved Git identity in: %s\n' "$HOME/.gitconfig.local"
  else
    cp "$DOTFILES_DIR/templates/.gitconfig.local.example" "$HOME/.gitconfig.local"
    printf 'Created: %s (edit your Git identity)\n' "$HOME/.gitconfig.local"
  fi
fi

if [[ ! -f "$HOME/.zshrc.local" ]]; then
  cp "$DOTFILES_DIR/templates/.zshrc.local.example" "$HOME/.zshrc.local"
  printf 'Created: %s\n' "$HOME/.zshrc.local"
fi

if [[ "$BACKUP_CREATED" == true ]]; then
  printf '\nBackup saved to %s\n' "$BACKUP_DIR"
fi

printf '\nDotfiles installed. Start a new shell to apply the Zsh configuration.\n'
