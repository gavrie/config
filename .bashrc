# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    #PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    ;;
*)
    PS1='\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PROMPT_COMMAND='echo -ne "\033]0;${TABNAME+${TABNAME}: }${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    #eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
    alias grep='grep --color=auto'
    alias ls='ls -G'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi
if [ -f /opt/local/etc/bash_completion ]; then
      . /opt/local/etc/bash_completion
fi


source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto"

# completions
complete -f -X '!*.db' sqlite3

PATH=$PATH:~/bin
export EDITOR='mvim --remote-wait-silent'
alias e='mvim --remote-silent'

pman()
{
    man -t $1 | open -f -a /Applications/Preview.app
}

alias ldd='printf "Sending command to \'\''otool -L\'\'' --\n" && otool -L'

alias find_sysconf="~/source/qa/investigate/find_sysconf.py"
alias fh="find_sysconf host"
alias fs="find_sysconf system"

alias t="cd ~/source/qa/tlib"
alias less="less -fR"


SYSTEM=qa13a
alias runner_succeed="runner -s $SYSTEM -o plugins.event_rules.enabled=no source/experiments/tests/succeed.py"
alias interact="runner -s $SYSTEM -o plugins.event_rules.enabled=no source/qa/tlib/tests/interactive.py"
alias runner_hosts="runner -s $SYSTEM -o plugins.event_rules.enabled=no source/qa/tlib/tests/examples/hosts.py:HostExample"
#alias copy_log="scp pro103:/qa/tlib/logs/by_user/gavriep/last_test/suite/cli_log.db source/qa/tlib/tmp/cli_log_id.db"
alias copy_db="scp pro103:/qa/tlib/logs/by_user/gavriep/last_test/suite/cli_log.db ~/source/qa/tlib/tmp/"
alias p4merge=/Applications/p4merge.app/Contents/MacOS/p4merge
export PYTHONPATH=~/source/qa/tlib/deps:/Users/gavriep/source/pydev/pysrc
#alias pip=pip-2.7
alias json='python -m json.tool'
alias sqlite_version="python -c 'import sqlite3; print sqlite3.version, sqlite3.sqlite_version'"

q()
{
    time sqlite3 tmp/cli_log.db "$1"
}
eqp()
{
    time sqlite3 tmp/cli_log.db "explain query plan $1"
}

# sshfs gavriep@pro103:/a/home /mnt/host/a/home 
# sshfs gavriep@pro103:/qa /mnt/host/qa

export PYTHONSTARTUP=~/.pythonrc.py
