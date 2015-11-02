# https://github.com/xvoland/Extract
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        mkdir ${NAME} && cd ${NAME}
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
    fi
}

function work_log {
  for i in *; do [ -d "$i/.git" ] && (cd $i; git log --date=short --pretty=format:"%ad $i %s" --author="$(git config --get user.email)") 2> /dev/null; done | sort | tac
}

# fbr - checkout git branch
# http://junegunn.kr/2015/03/fzf-tmux/
function fbr {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf-tmux -d 15 +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# ftag - checkout git tag
function ftag {
  local tags tag
  tags=$(git tag) &&
  tag=$(echo "$tags" | fzf-tmux -d 15 +m) &&
  git checkout $(echo "$tag")
}

# http://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th
mkcd () {
  case "$1" in
    */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}

command_exists () {
  type "$1" &> /dev/null ;
}

phpinfo () {
  TMPDIR=/tmp/phpinfo-$[ 10000 + $[ RANDOM % 99999 ]]
  TMPFILE=$TMPDIR/index.php
  PORT=4444
  mkdir $TMPDIR
  echo '<?php phpinfo();' >> $TMPFILE
  php -S localhost:$PORT -t $TMPDIR &
  PHPPID=$!
  URL=http://localhost:$PORT

  if command_exists xdg-open
  then
    xdg-open $URL
  else
    open $URL
  fi

  sleep 5
  kill $PHPPID
  rm -rf $TMPDIR
}

servephp () {
  PORT=4444
  PREFIX=''

  if [ $# -eq 1 ]
  then
    PORT=$1

    if [ $PORT -le 1024 ]
    then
      PREFIX='sudo'
    fi
  fi

  HOST=localhost
  URL=http://$HOST:$PORT

  if command_exists xdg-open
  then
    ( sleep 1 ; xdg-open $URL ) &
  else
    ( sleep 1 ; open $URL ) &
  fi

  echo "Executing$PREFIX php -S $HOST:$PORT"

  $PREFIX php -S $HOST:$PORT
}

venv_activate () {
  DIR=venv

  if [ $# -eq 1 ]
  then
    DIR=$1
  fi

  source $DIR/bin/activate
}

# http://chneukirchen.org/blog/category/zsh.html
#
# bd: move up the directory stack either a numeric amount or to a
# directory with the required prefix.
#
# With this helper function, you
# can do a lot more actually: Say you are in ~/src/zsh/Src/Builtins
# and want to go to ~/src/zsh. Just say up zsh. Or even just up z.
#
# And as a bonus, if you capture the output of up, it will print the
# directory you want, and not change to it. So you can do:
#
# mv foo.c $(up zsh)
bd () {
  local op=print
  [[ -t 1 ]] && op=cd # The test [[ -t 1 ]] checks whether stdout is a terminal
  case "$1" in
    '') bd 1;;
    -*|+*) $op ~$1;;
    <->) $op $(printf '../%.0s' {1..$1});;
    *) local -a seg; seg=(${(s:/:)PWD%/*})
       local n=${(j:/:)seg[1,(I)$1*]}
       if [[ -n $n ]]; then
         $op /$n
       else
         print -u2 bd: could not find prefix $1 in $PWD
         return 1
       fi
  esac
}
