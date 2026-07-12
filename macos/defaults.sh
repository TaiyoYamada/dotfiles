#!/usr/bin/env bash
set -euo pipefail

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Dock
defaults write com.apple.dock autohide -bool true

# Keyboard: lower values mean a faster repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

printf 'macOS defaults applied. Some settings may require logging out.\n'
