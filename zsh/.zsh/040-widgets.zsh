# Ctrl+L to cls
function _cls {
    # contrary to clear this clears to the bottom of the screen
    printf '\n%.0s' {1..80}
    zle && zle accept-line
}

zle -N cls _cls
bindkey '^l' cls

# Alt+S to prepend "sudo " to line
function _insert_sudo {
    zle && zle beginning-of-line
    zle && zle -U "sudo "
}

zle -N insert-sudo _insert_sudo
bindkey "^[s" insert-sudo

# Alt+R to source .zshrc
_source_zshrc () {
    echo 'Sourcing ~/.zshrc'
    source $HOME/.zshrc
    zle && zle accept-line
}

zle -N source-zshrc _source_zshrc
bindkey "^[r" source-zshrc

# Ctrl+Z to fg
_fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z _fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Ctrl+Q to kill processes
_fzf-kill () {
    zle -I;
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9};
}

zle -N fzf-kill _fzf-kill
bindkey '^Q' fzf-kill

# Alt+O to change to recent dir
_fzf-change-to-recent-dir () {
    cd $(fasd -dl | fzf)
    zle && zle accept-line
}

zle -N fzf-change-to-recent-dir _fzf-change-to-recent-dir
bindkey '^[o' fzf-change-to-recent-dir
