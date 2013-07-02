### ENVIROMENT
export PYTHONSTARTUP=$HOME/.pystartup
export PYTHONDOCS=/usr/share/doc/python/html/
export BROWSER='chromium'
export EDITOR='vim'
export PAGER='less'
export NODE_PATH=/usr/lib/jsctags:$NODE_PATH

### python virtualenv
if [ -e /usr/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

### FUNCTIONS

function take {
    mkdir -vp "$@"
    cd "$@"
}

function whereami {
  local apifile="$HOME/.ipinfodb"
  if [ -f $apifile ]; then
    curl -s --connect-timeout 1 --retry 5 "http://api.ipinfodb.com/v3/ip-city/?format=raw&key=$(cat $apifile)" | awk -F\; '
      $1=="OK" {
        $0 = tolower($0)
        printf "IP: %s\nCountry: %s (%s)\nCity: %s (%s)\nPosition: %s %s\n", $3, $5, toupper($4), $7, $6, $9, $10
      }
    ' | sed 's/\<./\u&/g'
  else
    echo "Unable to find $apifile. Please enter your api key:"
    local apikey
    read apikey
    if [ -n "$apikey" ]; then
      echo $apikey > $apifile
      chmod 600 $apifile
      whereami
    else
      echo "Please create $apifile to proceed"
      echo "  echo 'API-KEY' > $apifile && chmod 600 $apifile"
      return 1
    fi
  fi
}

function git_info {
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo "git repo overview"
        echo -e "-----------------\n\n"

        # print all remotes and thier details
        for remote in $(git remote show); do
            echo $remote:
            git remote show $remote
            echo
        done

        # print status of working repo
        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "working directory is clean"
        fi

        # print at least 5 last log entries
        echo -e "\nlog:"
        git log -5 --oneline
    fi
}

function git_stats {
# awesome work from https://github.com/esc/git-stats
# including some modifications

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo "Number of commits per author:"
        git --no-pager shortlog -sn --all
        AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
        LOGOPTS=""
        if [ "$1" == '-w' ]; then
            LOGOPTS="$LOGOPTS -w"
            shift
        fi
        if [ "$1" == '-M' ]; then
            LOGOPTS="$LOGOPTS -M"
            shift
        fi
        if [ "$1" == '-C' ]; then
            LOGOPTS="$LOGOPTS -C --find-copies-harder"
            shift
        fi
        for a in $AUTHORS
        do
            echo '-------------------'
            echo "Statistics for: $a"
            echo -n "Number of files changed: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
            echo -n "Number of lines added: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
            echo -n "Number of lines deleted: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
            echo -n "Number of merges: "
            git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
        done
    fi
}

### TMUX

# Disable for ssh connections
if [ -z "$SSH_CONNECTION" ]; then
    # tmux main session
    if ! tmux has-session -t main 2> /dev/null; then
        tmux new-session -s main -n shell -d
    fi
fi
