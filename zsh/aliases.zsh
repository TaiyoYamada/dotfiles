alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias gs='git status --short --branch'
alias gl='git log --oneline --decorate --graph -15'
alias ll='ls -lah'

command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# JavaScript package scripts
alias nd='npm run dev'
alias nb='npm run build'
alias nt='npm test'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'
alias yd='yarn dev'
alias yb='yarn build'
alias yt='yarn test'
alias bd='bun run dev'
alias bb='bun run build'
alias bt='bun test'

_detect_js_package_manager() {
  if [[ -f bun.lock || -f bun.lockb ]]; then
    print -r -- bun
  elif [[ -f pnpm-lock.yaml ]]; then
    print -r -- pnpm
  elif [[ -f yarn.lock ]]; then
    print -r -- yarn
  elif [[ -f package-lock.json ]]; then
    print -r -- npm
  else
    return 1
  fi
}

_run_js_script() {
  local script="$1"
  local package_manager

  if ! package_manager="$(_detect_js_package_manager)"; then
    print -u2 -- "No supported JavaScript lockfile found in $PWD"
    return 1
  fi

  case "$package_manager" in
    bun) command bun run "$script" ;;
    pnpm) command pnpm "$script" ;;
    yarn) command yarn "$script" ;;
    npm) command npm run "$script" ;;
  esac
}

dev() {
  _run_js_script dev
}

build() {
  _run_js_script build
}
