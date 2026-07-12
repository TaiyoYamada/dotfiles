# Keep PATH entries unique while allowing path=(...) additions below.
typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$HOME/.mint/bin"
  "$HOME/.npm-global/bin"
  "$path[@]"
)

export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}"
[[ -d "$PNPM_HOME" ]] && path=("$PNPM_HOME" "$path[@]")

if [[ -d "$HOME/.antigravity/antigravity/bin" ]]; then
  path=("$HOME/.antigravity/antigravity/bin" "$path[@]")
fi

if [[ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]]; then
  export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
  path=("$JAVA_HOME/bin" "$path[@]")
fi

source "$HOME/.config/zsh/aliases.zsh"

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Machine-specific settings and secrets belong here, outside Git.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
