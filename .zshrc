# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gavrie"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode python macos zsh-syntax-highlighting docker poetry)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source ~/.profile
export LC_ALL=en_US.UTF-8

setopt interactivecomments
unsetopt extendedglob
unsetopt correct_all

# Make ^R search history even in vi-mode
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history

PYTHONSTARTUP=~/.pythonrc.py
if [ -e $PYTHONSTARTUP ]
then
    export PYTHONSTARTUP
fi

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

export GOPATH=~/source/go

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ $(uname -s) = 'Darwin' ]
then
    # Mac-specific stuff
    export EDITOR=vim #'mynvr --remote-wait-silent'
    #export PATH="/opt/local/bin:$PATH"
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

    alias e=vim #'mynvr --remote-silent'
    alias ldd='printf "Sending command to \'\''otool -L\'\'' --\n" && otool -L'

    # alias p4merge='/Applications/p4merge.app/Contents/MacOS/p4merge'
    alias ls='ls -G'

    # Font smoothing with subpixel antialiasing
    ##alias smooth="defaults -currentHost write -globalDomain AppleFontSmoothing -int 2"
    #alias smooth="defaults -currentHost delete -globalDomain AppleFontSmoothing"
    #alias unsmooth="defaults -currentHost write -globalDomain AppleFontSmoothing -int 0"

    # brew autocomplete
    fpath=($HOME/.zsh/func $fpath)
    typeset -U fpath

    # Kube-PS1 prompt
    #source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
    #PS1='$(kube_ps1)'$PS1
else
    # Non-mac stuff
    export EDITOR='vim'
    alias e='vim'
    alias ls='ls --color=auto'
    if [ -e /etc/bash_completion.d/virtualenvwrapper ]
    then
        export WORKON_HOME=~/.virtualenvs
        source /etc/bash_completion.d/virtualenvwrapper
    fi
    # Prevent slow git dirtiness parsing on hosts
    parse_git_dirty() {
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    }

    # Workaround for broken `getent passwd` on Ubuntu hosts
    zstyle ':completion:*' users off
fi

export VISUAL=$EDITOR
export PATH=~/bin:$PATH
export LESS="-fRXF"

alias grep='grep --color=auto'

# alias gs='git status --ignore-submodules'
alias gs='git status'
alias gsu='git submodule update --init --recursive'

alias json='python -m json.tool'

# rbenv
if type rbenv > /dev/null
then
    PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

#export PATH="/usr/local/opt/llvm/bin:$PATH"
export LLVM_CONFIG_PATH=/usr/local/opt/llvm/bin/llvm-config

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# poetry
export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
