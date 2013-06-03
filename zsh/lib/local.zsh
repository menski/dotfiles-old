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
    EIP=$(curl -s http://ipecho.net/plain)
    curl -s http://freegeoip.net/csv/$EIP | awk -F\" '{printf "%s %s, %s\n", $2, $12, $6}'
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
