# fasd
if command_exists fasd ; then
    eval "$(fasd --init auto)"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# desk
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
