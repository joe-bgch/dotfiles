# fasd
if command_exists fasd ; then
    eval "$(fasd --init auto)"
fi

# fzf
export FZF_TMUX=0
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# desk
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
