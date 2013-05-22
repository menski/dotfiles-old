autoload -U colors && colors

_BLACK="%{$fg_no_bold[black]%}"
_GREEN="%{$fg_no_bold[green]%}"
_BLUE="%{$fg_no_bold[blue]%}"
_CYAN="%{$fg_no_bold[cyan]%}"
_RED="%{$fg_no_bold[red]%}"
_YELLOW="%{$fg_no_bold[yellow]%}"
_MAGENTA="%{$fg_no_bold[magenta]%}"
_WHITE="%{$fg_no_bold[white]%}"

_B_BLACK="%{$fg_bold[black]%}"
_B_GREEN="%{$fg_bold[green]%}"
_B_BLUE="%{$fg_bold[blue]%}"
_B_CYAN="%{$fg_bold[cyan]%}"
_B_RED="%{$fg_bold[red]%}"
_B_YELLOW="%{$fg_bold[yellow]%}"
_B_MAGENTA="%{$fg_bold[magenta]%}"
_B_WHITE="%{$fg_bold[white]%}"

_RESET="%{$reset_color%}"

function _prompt_error {
    local ec=$?
    if [ $ec -ne 0 ]; then
        echo -e "${_B_RED}${ec}${_RESET} "
    fi
}

function _prompt_user {
    if [ $USER != "$(logname 2> /dev/null)" ]; then
        echo -e "${_WHITE}%n${_CYAN}@${_RESET}"
    fi
}

function _prompt_dir {
    local maxlen=25
    local trunc_sym=""
    local dir=${PWD/#$HOME/\~}
    while [ ${#dir} -gt $maxlen ]; do
       trunc_sym="../"
       index=$(expr index "$dir" /)
       if [ $index -eq 0 ]; then
           break
       fi
       dir=${dir:$index}
    done
    echo -e "${_WHITE}$trunc_sym$dir${_RESET}"
}

function _prompt_git {
    local gitdir="$([ $(git ls-files . 2>/dev/null | wc -l) -gt 0 ] && git rev-parse --git-dir 2>/dev/null)"
    [[ $? -ne 0 || ! $gitdir =~ (.*\/)?\.git.* ]] && return

    local branch="$(git symbolic-ref HEAD 2>/dev/null)"
    if [[ $? -ne 0 || -z "$branch" ]] ; then
        # In detached head state, use commit instead
        branch="$(git rev-parse --short HEAD 2>/dev/null)"
    fi
    [[ $? -ne 0 || -z "$branch" ]] && return
    branch="${branch#refs/heads/}"

    local git_status="$(git status 2> /dev/null)"
    local remote_pattern="# Your branch is (.*) of"
    local diverge_pattern="# Your branch and (.*) have diverged"
    local untracked_pattern="# Untracked files:"
    local not_staged_pattern="Changes not staged for commit"
    local not_staged_pattern_old="Changed but not updated"
    local uncommited_pattern="Changes to be committed"
    local remote=""
    local state=""

    # add an else if or two here if you want to get more specific
    # show if we're ahead or behind HEAD
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="${_GREEN}>"
        else
            remote="${_YELLOW}<"
        fi
    # diverged branch
    elif [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="${_RED}x"
    fi
    # uncommited files
    if [[ ${git_status} =~ ${uncommited_pattern} ]]; then
        state+="${_GREEN}+"
    fi
    # files not staged for commit
    if [[ ${git_status} =~ ${not_staged_pattern} ]] ||\
       [[ ${git_status} =~ ${not_staged_pattern_old} ]]; then
        state+="${_YELLOW}+"
    fi
    # untracked files
    if [[ ${git_status} =~ ${untracked_pattern} ]]; then
        state+="${_RED}+"
    fi

    echo -ne "${_MAGENTA}[${_CYAN}${branch}${remote}"
    if [ -n "${state}" ]; then
        echo -ne " ${state}"
    fi
    echo -e "${_MAGENTA}]${_RESET} "
}

function _prompt_symbol {
    if [ $EUID -eq 0 ]; then
        echo -en "${_B_RED}"
    else
        echo -en "${_GREEN}"
    fi
    echo -e "\$${_RESET}"
}

function _set_prompt {
    PS1="$(_prompt_error)"
    PS1+="$(_prompt_user)"
    PS1+="$(_prompt_dir) "
    PS1+="$(_prompt_git)"
    PS1+="$(_prompt_symbol) "
}

function precmd {
    _set_prompt
}
