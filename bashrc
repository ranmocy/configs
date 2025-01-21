# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

alias ls='ls -G'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -al'
alias g='git'
alias t='tmux'
alias ta='tmux attach'

if [ -x "$HOME/work/bin/kmap" ]; then
    $HOME/work/bin/kmap
fi

if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
    tmux attach || tmux || zsh
fi

# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 8)\][\[$(tput setaf 4)\]\u\[$(tput setaf 8)\]@\[$(tput setaf 2)\]\h:\[$(tput setaf 3)\]\W\[$(tput setaf 8)\]]\[$(tput setaf 6)\]\(～￣▽￣)～ \[$(tput sgr0)\]"

[[ "$PS1" ]] && hash fortune >/dev/null 2>&1 && fortune
