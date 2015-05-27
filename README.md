# dotfiles

These are my personal dotfiles.

Recommended installation with GNU Stow:

First install stow

    sudo apt-get install stow
    sudo pacman -S stow
    brew install stow
    sudo port install stow

1. cd ~
2. git clone --recursive https://github.com/bagonyi/dotfiles.git
3. cd dotfiles
4. stow -v zsh

This will simply symlink files and directories from ~/dotfiles/zsh/* to ~

To remove the symlinks from ~:

    stow -Dv zsh

Antigen (zsh plugin manager) and Vundle (vim plugin manager) are added as submodules so you don't need to clone
them separately.

After stowing vim make sure to install plugins:

    stow -v vim
    vim +PluginInstall +qall
