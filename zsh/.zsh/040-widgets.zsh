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
