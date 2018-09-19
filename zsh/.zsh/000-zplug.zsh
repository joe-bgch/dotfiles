export ZPLUG_HOME=/usr/local/opt/zplug
source ${ZPLUG_HOME}/init.zsh

if [ -f ${ZPLUG_HOME}/init.zsh ]; then
    zplug "zsh-users/zsh-syntax-highlighting", from:github
    zplug "zsh-users/zsh-completions", from:github
    zplug "zsh-users/zsh-history-substring-search", from:github

    zplug "themes/ys", from:oh-my-zsh

    if ! zplug check --verbose; then
        printf "Install new zplug plugins? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    zplug load

    if zplug check zsh-users/zsh-history-substring-search; then
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
    fi
else
    echo "zplug does not seem to be installed. Run 'brew install zplug'"
fi
