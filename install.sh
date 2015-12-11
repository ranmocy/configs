#!/bin/bash

# Colors
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
reset='\033[0m'

# Env
CONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLATFORM=`uname`
function link() {
  local source=$1
  local target=$2
  local parent="$( dirname $target )"
  # check if parent exists
  if [ ! -e $parent ]; then
    echo "$parent does not exist, mkdir_p"
    mkdir -p $parent
  fi
  # check not a symbolic link and it's a directory
  if [ ! -L $target ] && [ -d $target ]; then
    read -r -p "$target is a directory. Remove_rf? [y/N] " response
    response=${response,,}    # tolower
    if [[ $response =~ ^(yes|y)$ ]]; then
      rm -rf "$target"
    fi
  fi
  echo "Linking $source to $target..."
  ln -sfn "$source" "$target"
}
function success() {
  echo "${green}$1${reset}"
}
function finish() {
  success "Finish setup $1."
}


git submodule update --init --recursive
link "$CONFIGS/bin" "$HOME/bin"
finish "Init"

link "$CONFIGS/gitconfig" "$HOME/.gitconfig"
link "$CONFIGS/gitexclude" "$HOME/.gitexclude"
finish "Git"

link "$CONFIGS/bashrc" "$HOME/.bashrc"
finish "Bash"

link "$CONFIGS/zshrc.d" "$HOME/.zshrc.d"
link "$HOME/.zshrc.d/zshrc.zsh" "$HOME/.zshrc"
finish "zsh"

link "$CONFIGS/fish_config/" "$HOME/.config/fish"
finish "fish"

link "$CONFIGS/emacs.d" "$HOME/.emacs.d"
finish "Emacs"

link "$CONFIGS/gemrc" "$HOME/.gemrc"
link "$CONFIGS/irbrc" "$HOME/.irbrc"
finish "Ruby"

link "$CONFIGS/ackrc" "$HOME/.ackrc"
finish "Ack"

link "$CONFIGS/htoprc" "$HOME/.htoprc"
finish "htop"

link "$CONFIGS/screenrc" "$HOME/.screenrc"
finish "Screen"

link "$CONFIGS/tmux.conf" "$HOME/.tmux.conf"
finish "Tmux"

link "$CONFIGS/vimrc" "$HOME/.vimrc"
finish "VIM"

# Linux
if [[ $PLATFORM == 'Linux' ]]; then
    link "$CONFIGS/sublime_text_3_config" "$HOME/.config/sublime-text-3/Packages/User"
    finish "Sublime Text"

    link "$CONFIGS/awesome_config/" "$HOME/.config/awesome/rc.lua"
    finish "Awesome 3"

    # link "$CONFIGS/Xdefaults" "$HOME/.Xdefaults"
    # link "$CONFIGS/xinitrc" "$HOME/.xinitrc"
    # link "$CONFIGS/xmodmap" "$HOME/.xmodmap"
    # finish "X"
fi

# Mac
if [[ $PLATFORM == 'Darwin' ]]; then
    link "$CONFIGS/sublime_text_3_config" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    finish "Sublime Text"

    link "$CONFIGS/Karabiner/" "$HOME/Library/Application Support/"
    finish "Karabiner"
fi
