#cmd=echo
#command -v cowsay >/dev/null 2>&1 && cmd='cowsay'
#[[ -f ~/.tips ]] && tips=("${(f)$(< ~/.tips)}") && echo -e $tips[$(shuf -i 1-$(cat ~/.tips | wc -l) -n 1)] | $cmd
