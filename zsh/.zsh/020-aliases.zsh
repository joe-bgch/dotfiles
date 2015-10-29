alias sudo='sudo '
alias ..='cd ..'
alias ...='cd ../../'
alias ll='ls -alhp --group-directories-first'
alias l='ll'
alias dog='pygmentize -g'
alias publicip='curl ifconfig.me'
alias cls='_cls'
[[ -f /usr/share/mc/bin/mc-wrapper.sh ]] && alias mc='. /usr/share/mc/bin/mc-wrapper.sh'
[[ -f /opt/local/libexec/mc/mc-wrapper.sh ]] && alias mc='. /opt/local/libexec/mc/mc-wrapper.sh'
alias v='f -e vim'
alias c='fasd_cd -d'
alias tmux='tmux -2'
alias lsr='ls -d -1 $PWD/**/*'
alias j=z
alias grep='grep --ignore-case --color'
