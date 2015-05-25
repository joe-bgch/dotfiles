# dotfiles

Recommended install with GNU Stow:

sudo apt-get install stow
sudo pacman -S stow
brew install stow
sudo port install stow

1. cd ~
2. git clone https://github.com/bagonyi/dotfiles.git
3. cd dotfiles
4. stow -v zsh tmux

To uninstall:

stow -Dv zsh tmux
