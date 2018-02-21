if [ -f /usr/local/share/antigen/antigen.zsh ]; then
    source /usr/local/share/antigen/antigen.zsh

    antigen use oh-my-zsh

    antigen bundle zsh-users/zsh-syntax-highlighting

    antigen theme ys

    antigen apply
else
    echo "antigen does not seem to be installed. Run 'brew install --HEAD antigen'"
fi
