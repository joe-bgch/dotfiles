export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/opt/local/bin:/opt/local/sbin:/opt/local/lib/php/pear/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME/bin:$HOME/.cabal/bin"

export EDITOR=vim
export VISUAL=vim

# Display last exit code on the right
export RPROMPT='[%?]'

WORDCHARS=${WORDCHARS//[=&.;]}

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
