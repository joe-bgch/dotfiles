export ZSH=$HOME/.oh-my-zsh

if [ -d "$ZSH" ]; then
    ZSH_THEME="ys"

    # Uncomment the following line to display red dots whilst waiting for completion.
    # COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # HIST_STAMPS="mm/dd/yyyy"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    plugins=(git autojump zsh-syntax-highlighting docker)

    source ${ZSH}/oh-my-zsh.sh
fi
