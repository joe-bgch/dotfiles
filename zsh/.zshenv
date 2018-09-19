export EDITOR=vim
export VISUAL=vim

# Display last exit code on the right
export RPROMPT='[%?]'

WORDCHARS=${WORDCHARS//[=&.;]}

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

bindkey -e

zmodload zsh/complist
autoload -Uz compinit && compinit

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '\e' send-break

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
