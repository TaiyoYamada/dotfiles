# dotfiles

Personal macOS development environment for Zsh, Git, Starship, WezTerm,
Karabiner-Elements, Neovim (LazyVim), VS Code, lazygit, gh, Claude Code,
and macOS defaults. Shell tooling includes fzf, zoxide, and git-delta.

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

Optional setup steps can also be run independently:

```sh
./vscode/install-extensions.sh
./macos/defaults.sh
```

Existing configuration files are moved to `~/.dotfiles-backup/<timestamp>`
before symbolic links are created.

After installation, edit `~/.gitconfig.local` with your Git identity. Put
machine-specific configuration and secrets in `~/.zshrc.local`; neither local
file is tracked by this repository.

VS Code settings intentionally exclude temporary paths, account data, and
project identifiers. The extension list is stored in `vscode/extensions.txt`.

Only `config.yml` is tracked for gh; `~/.config/gh/hosts.yml` holds
authentication tokens and stays out of the repository. Git uses delta as
its pager, so `git-delta` (installed via the Brewfile) is expected on PATH.

## Update packages

Edit `Brewfile`, then run:

```sh
brew bundle --file ~/.dotfiles/Brewfile
```

## Validation

Run the same checks used by GitHub Actions:

```sh
./check.sh
```
