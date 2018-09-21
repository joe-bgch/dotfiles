export EDITOR=vim
export VISUAL=vim

# Display last exit code on the right
export RPROMPT='[%?]'

WORDCHARS=${WORDCHARS//[=&.;]}

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

zmodload zsh/complist
autoload -Uz compinit
compinit

# Emacs style keybindings
bindkey -e

# Shift + Tab to move backwards in menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Escape key to close menu
bindkey -M menuselect '\e' send-break

# Make delete key (Fn + backspace) work
bindkey "\e[3~" delete-char

# Show menu on tab tab
zstyle ':completion:*' menu select

# Autocomplete any part of a filename
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Do not try to execute lines starting with #
setopt interactivecomments

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
