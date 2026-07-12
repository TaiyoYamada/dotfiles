# dotfiles

Personal macOS development environment for Zsh, Git, Starship, WezTerm,
Karabiner-Elements, and Neovim (LazyVim).

## Setup

Install Homebrew, then clone and bootstrap the repository:

```sh
git clone git@github.com:TaiyoYamada/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

To install only the configuration files without Homebrew packages:

```sh
./install.sh
```

Existing configuration files are moved to `~/.dotfiles-backup/<timestamp>`
before symbolic links are created.

After installation, edit `~/.gitconfig.local` with your Git identity. Put
machine-specific configuration and secrets in `~/.zshrc.local`; neither local
file is tracked by this repository.

## Update packages

Edit `Brewfile`, then run:

```sh
brew bundle --file ~/.dotfiles/Brewfile
```
