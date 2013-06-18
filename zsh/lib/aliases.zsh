# modified
alias grep='grep --color=auto'

# cd
alias ..='cd ..'
alias ...='cd ../..'

# ls
alias ls='ls --color=never -F'
alias la='ls -A'
alias lla='ls -Al'
alias lm='la | less'
alias l='ls -lh'
alias ll='ls -l'
alias lx='ll -BXh'  # sort by extension
alias lxx='ll -BX'
alias lz='ll -rSh'  # sort by size
alias lzz='ll -rS'
alias lt='ll -rth'  # sort by date
alias ltt='ll -rt'

# bashrc
alias reload='source ~/.zshrc'
alias modify='vim ~/.zshrc'

if [ -n "$DISPLAY" ]; then
    # apps
    alias open='xdg-open'
    alias o='open'
    alias et='easytag'
    alias provides='cnf-lookup -c'
    alias eip='curl http://ipecho.net/plain && echo'
    alias srename='filebot --format "{n} - {s00e00} - {t}" -rename -non-strict'
    alias rwall='feh --bg-scale "$(find /home/menski/Dropbox/Apps/Desktoppr/ -type f | grep -v .dropbox | shuf -n1)"'
    alias cwall='for i in ~/Dropbox/Apps/Desktoppr/*; do feh --bg-scale $i; basename $i; read; done'
fi

# shortcuts
alias mnt='udevil mount'
alias umnt='udevil umount'
alias mnas='udevil mount -o sec=ntlmv2 smb://192.168.0.1/volume1 /media/nas'
alias unas='udevil umount smb://192.168.0.1/volume1'
alias mbackup='udevil mount -o sec=ntlmv2 smb://192.168.0.1/volume9 /media/backup'
alias ubackup='udevil umount smb://192.168.0.1/volume9'
alias psgrep='ps aux | grep -v grep | grep -i'
alias myps='ps ux -umenski'
alias e='vim'
alias se='sudo vim'
alias x='exit'
alias pa='pacaur'
alias up='yaourt -Syu'
alias upa='yaourt -Syua'
alias upan='yaourt -Syua --noconfirm'
alias km='mpid=$(pgrep mutt); if [ $? -eq 0 ]; then kill $mpid; fi'
alias cpg='advcp -g'
alias mvg='advmv -g'

# safety features
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'  # 'rm -i' prompts for every file
alias ln='ln -iv'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg'
fi

# todo.sh
if command -v todo.sh > /dev/null; then
    alias t='todo.sh'
fi
