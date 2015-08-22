source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle docker
antigen bundle boot2docker
antigen bundle httpie
antigen bundle macports
antigen bundle pip

antigen theme ys

antigen apply
