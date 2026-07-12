alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias gs='git status --short --branch'
alias gl='git log --oneline --decorate --graph -15'
alias ll='ls -lah'

command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# Dotfiles and files
alias dots='cd ~/.dotfiles'
alias dotcheck='~/.dotfiles/check.sh'
alias la='ls -la'
alias lt='tree -L 2'
alias c.='code .'
alias v='nvim'

# Git and GitHub
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gsw='git switch'
alias gr='git restore'
alias prs='gh pr status'
alias prv='gh pr view --web'
alias prc='gh pr create --web'
alias issues='gh issue list'

# Development tools
alias dc='docker compose'
alias tf='terraform'
alias tff='terraform fmt -recursive'
alias tfp='terraform plan'
alias py='uv run python'

mkcd() {
  if (( $# != 1 )); then
    print -u2 -- 'Usage: mkcd <directory>'
    return 2
  fi

  mkdir -p -- "$1" && cd -- "$1"
}

repo() {
  gh repo view --web
}

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
