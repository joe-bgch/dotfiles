export ZPLUG_HOME=/usr/local/opt/zplug
source ${ZPLUG_HOME}/init.zsh

if [ -f ${ZPLUG_HOME}/init.zsh ]; then
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "themes/ys", from:oh-my-zsh

    zplug load
else
    echo "zplug does not seem to be installed. Run 'brew install zplug'"
fi
