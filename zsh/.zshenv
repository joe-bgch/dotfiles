export EDITOR=vim
export VISUAL=vim

# Display last exit code on the right
export RPROMPT='[%?]'

WORDCHARS=${WORDCHARS//[=&.;]}

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
