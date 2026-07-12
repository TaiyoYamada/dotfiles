# Keep PATH entries unique while allowing path=(...) additions below.
typeset -U path PATH

for bin_dir in "$HOME/.npm-global/bin" "$HOME/.mint/bin" "$HOME/.local/bin"; do
  [[ -d "$bin_dir" ]] && path=("$bin_dir" "$path[@]")
done
unset bin_dir

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
