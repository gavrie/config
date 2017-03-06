# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Changed on GitHub

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

#if [ "$CONQUE" ]
#then
#    export TERM="xterm-color"
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color|xterm-256color|screen)
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
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
screen*)
#    PROMPT_COMMAND='echo -ne "\033k033\0134"'
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
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
    alias grep='grep --color=auto'
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

# Git
if [ -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash ]
then
    source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash
elif [ -f ~/bin/git-completion.bash ]
then
    source ~/bin/git-completion.bash
fi
#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto"
#export GIT_PS1_SHOWSTASHSTATE=1

# completions
complete -f -X '!*.db' sqlite3

PATH=/usr/local/bin:$PATH:~/bin

if [ $(uname -s) = 'Darwin' ]
then
    # Mac-specific stuff
    export EDITOR='mvim --remote-wait-silent'
    alias e='mvim --remote-silent'
    alias ldd='printf "Sending command to \'\''otool -L\'\'' --\n" && otool -L'

    alias p4merge=/Applications/p4merge.app/Contents/MacOS/p4merge
    alias ls='ls -G'
else
    # Non-mac stuff
    export EDITOR='vim'
    alias e='vim'
    alias ls='ls --color=auto'
fi

export VISUAL=$EDITOR

alias find_sysconf="~/source/qa/investigate/find_sysconf.py"
alias fh="find_sysconf host"
alias fs="find_sysconf system"

alias t="cd ~/source/qa/tlib"

export LESS="-fR"

alias gs="git status"
alias gsu="git submodule update --init --recursive"

# own/disown
alias own='~/source/qa/investigate/owners.py add -u $USER -s'
alias disown='~/source/qa/investigate/owners.py remove -u $USER -s'

#alias runner_succeed="runner -s $SYSTEM -o plugins.event_rules.enabled=no source/experiments/tests/succeed.py"
#alias interact="runner -s $SYSTEM -o plugins.event_rules.enabled=no tests/interactive.py"
#alias runner="~/bin/runner -s $SYSTEM -o plugins.event_rules.enabled=no"
#alias runner_hosts="runner -s $SYSTEM -o plugins.event_rules.enabled=no source/qa/tlib/tests/examples/hosts.py:HostExample"
#alias copy_log="scp pro103:/qa/tlib/logs/by_user/gavriep/last_test/suite/cli_log.db source/qa/tlib/tmp/cli_log_id.db"
#alias copy_db="scp pro103:/qa/tlib/logs/by_user/gavriep/last_test/suite/cli_log.db ~/source/qa/tlib/tmp/"

# On laptop:
export PYTHONPATH=~/source/qa/tlib/deps
# On host:
#export PYTHONPATH=/local/gavriep/p11.0/leia/common/pypackages

#alias pip=pip-2.7
alias json='python -m json.tool'
export PYTHONSTARTUP=~/.pythonrc.py

# Resize the Terminal window
# To get current size:
# tput lines
# tput cols

# positive integer test (including zero)
function positive_int() { return $(test "$@" -eq "$@" > /dev/null 2>&1 && test "$@" -ge 0 > /dev/null 2>&1); }

# resize the Terminal window
function sizetw() { 
   if [[ $# -eq 2 ]] && $(positive_int "$1") && $(positive_int "$2"); then 
      printf "\e[8;${1};${2};t"
      return 0
   fi
   return 1
}

## Use VI mode for editing
set -o vi
## ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history
## ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete
## ^l clear screen
bind -m vi-insert "\C-l":clear-screen
