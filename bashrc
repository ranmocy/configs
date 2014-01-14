# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

## Auto login to the first valid machine of CS classrooms
# when you login to the stargate machine.
# Author: Ranmocy Sheng
# License: FYHPL(http://ranmocy.info/piece/FYHPL/)
#
# Usage:
#   wget wget https://gist.github.com/ranmocy/6290077/raw/1370ba7b3731f2f4b1a0b76515dd65e148bf2cd3/USFCA_CS_auto_ssh_to_valid_host.bash ~/USFCA_CS_auto_ssh_to_valid_host.bash
#   echo "bash ~/USFCA_CS_auto_ssh_to_valid_host.bash" >> ~/.bashrc
#

# if this is the stargate
if [[ `hostname` == 'stargate.cs.usfca.edu' ]]; then
    echo "Searching for the first valid machine of USF CS..."

    # Get the hosts name in background.
    rusers -a > /tmp/hosts &
    # killit after 500ms, since it can't stop by itself.
    PID=$! && sleep 0.5 && kill -INT $PID

    # Take out the hosts list | remove invalid line | take the first | fix the end of the name
    TARGET=$(cat /tmp/hosts | grep '\.ed $' | head -1 | sed 's/\.ed\s$/.edu/')

    echo "$TARGET is the first valid target machine, now connect to it."
    exec ssh $TARGET
fi


export ROOT=$HOME/root

# Redifine the path of lib
# So that I can install my software to my HOME
export CFLAGS=-I$ROOT/include
export LDFLAGS=-L$ROOT/lib

export LD_LIBRARY_PATH=$ROOT/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$ROOT/lib/pkgconfig

#export PATH=$ROOT/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
#    tmux attach || tmux
#fi

alias ls='ls -G'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -al'
alias g='git'

# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 8)\][\[$(tput setaf 4)\]\u\[$(tput setaf 8)\]@\[$(tput setaf 2)\]\h:\[$(tput setaf 3)\]\W\[$(tput setaf 8)\]]\[$(tput setaf 6)\]\(～￣▽￣)～ \[$(tput sgr0)\]"

[[ "$PS1" ]] && hash fortune >/dev/null 2>&1 && fortune

