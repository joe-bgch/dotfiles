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
function fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# ftag - checkout git tag
function ftag {
  local tags tag
  tags=$(git tag) &&
  tag=$(echo "$tags" | fzf-tmux -d 15 +m) &&
  git checkout $(echo "$tag")
}

function fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l60 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
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

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

# Fix SSH agent in reattached tmux session shells
# https://coderwall.com/p/_s_xda/fix-ssh-agent-in-reattached-tmux-session-shells
fix-ssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}

# https://github.com/mafintosh/tmpdir-tab
function tmpdir {
    [[ "$TMPDIR_TAB" == "" ]] && export TMPDIR_TAB="$(mkdir -p /tmp/tmpdir && mktemp -d /tmp/tmpdir/XXXXXX)"

    if [ -t 1 ]; then
        cd "$TMPDIR_TAB"
    else
        echo "$TMPDIR_TAB"
    fi
}

function _tmpdir_on_exit {
    if [ "$TMPDIR_TAB" != "" ] && [ -d "$TMPDIR_TAB" ]; then
        rm -rf "$TMPDIR_TAB"
        rmdir /tmp/tmpdir &>/dev/null || true
    fi
}

trap _tmpdir_on_exit EXIT

# find .git repositories recursively and pipe it into fzf
function repos {
    local dir=$(find . -name .git -type d | sed -e "s/\/.git//" | fzf)

    if [[ -d ${dir} ]]
    then
        cd ${dir}
    fi
}

# Wrapper around mvn
# Colorizes the output using sed
# Keeps the exit code of mvn and returns it to allow chaining of commands
mvn-in-colors() {

  # Formatting constants
  local color_red=$(tput bold)$(tput setaf 1)
  local color_green=$(tput bold)$(tput setaf 2)
  local color_yellow=$(tput bold)$(tput setaf 3)
  local color_white=$(tput bold)$(tput setaf 7)
  local color_reset=$(tput sgr0)

  # Make sure formatting is reset
  echo -ne ${color_reset}

  # TMP file to store the exit code of the mvn command
  tmp_file=$(mktemp)

  # Filter mvn output using sed
  (command mvn $@ ; echo $? > $tmp_file) | sed \
    -e "s/\(.*-\{55\}\+$\|.*\[INFO\] Scanning for projects.*\|.*\[INFO\] Building.*\|^Running .*\|^ T E S T S$\|^Results.*\)/${color_white}\1${color_reset}/g" \
    -e "s/\(.*\[INFO\] BUILD SUCCESS$\|^Tests run:.*Failures: 0.*Errors: 0.*Skipped: 0.*\)/${color_green}\1${color_reset}/g" \
    -e "s/\(.*\[WARNING].*\|^NOTE: Maven is executing in offline mode\.\|^Tests run:.*Failures: 0, Errors: 0, Skipped: [^0].*\)/${color_yellow}\1${color_reset}/g" \
    -e "s/\(.*\[INFO\] BUILD FAILURE\|.* <<< FAILURE!$\|.* <<< ERROR!$\|^Tests in error:.*\|^Tests run:.*Failures: [^0].*\|^Tests run:.*Errors: [^0].*\)/${color_red}\1${color_reset}/g"

  # Make sure formatting is reset
  echo -ne ${color_reset}

  # Return the exit code of the mvn command
  read mvn_exit_code < $tmp_file
  \rm -f $tmp_file

  return $mvn_exit_code
}

catcmd () {
    cat $(which $1)
}

review () {
    feature_branch=$(git rev-parse --abbrev-ref HEAD)

    # check if we are already on a review-* branch, if so, do nothing.
    [[ ${feature_branch} =~ ^review- ]] && echo "Already on a review branch. Exiting." && return

    git checkout master
    git checkout -b review-${feature_branch}
    git merge --squash ${feature_branch}
}

reviewdone () {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    branch=$(echo ${current_branch} | sed 's/^review-//')

    # check if we are on a review-* branch, if not, do nothing.
    [[ ! ${current_branch} =~ ^review- ]] && echo "Not on a review branch. Exiting." && return

    git reset --hard
    git checkout ${branch}
    git branch -D ${current_branch}
}
