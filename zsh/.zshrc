for config (~/.zsh/*.zsh) source $config

stty -ixon

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
