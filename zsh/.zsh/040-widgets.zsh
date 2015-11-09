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

# Alt+R to source .zshrc & .zshenv
_source_zsh_config () {
    [ -f $HOME/.zshrc ] && echo 'Sourcing ~/.zshrc' && source $HOME/.zshrc
    [ -f $HOME/.zshenv ] && echo 'Sourcing ~/.zshenv' && source $HOME/.zshenv
    zle && zle accept-line
}

zle -N source-zsh-config _source_zsh_config
bindkey "^[r" source-zsh-config

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
    cd $(fasd -dlR | fzf)
    zle && zle accept-line
}

zle -N fzf-change-to-recent-dir _fzf-change-to-recent-dir
bindkey '^[o' fzf-change-to-recent-dir

# Alt+E to edit recent file
_fzf-edit-recent-file () {
    file=$(fasd -fl | fzf)
    if [[ -f ${file} ]]
    then
        echo ${file} | xargs bash -c '</dev/tty vim "$@"' ignoreme
    fi

    zle && zle accept-line
}

zle -N fzf-edit-recent-file _fzf-edit-recent-file
bindkey '^[e' fzf-edit-recent-file

# Alt+. to print environment and pipe it into fzf
_fzf-print-environment () {
    printenv | sort -fr | fzf

    zle && zle accept-line
}

zle -N fzf-print-environment _fzf-print-environment
bindkey '^[.' fzf-print-environment
