source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle docker
antigen bundle boot2docker
antigen bundle httpie
antigen bundle macports
antigen bundle pip
antigen bundle dirhistory
antigen bundle micha/resty
antigen bundle jamesob/desk shell_plugins/zsh
antigen bundle Tarrasch/zsh-autoenv

antigen theme ys

antigen apply
