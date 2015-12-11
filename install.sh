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
function select_platform() {
  local result=$1 # default
  if [[ $PLATFORM == 'Linux' ]]; then
    result=$1
  elif [[ $PLATFORM == 'Darwin' ]]; then
    result=$2
  fi
  echo $result
}
function confirm () {
  # call with a prompt string or use a default
  read -r -p "${1:-Are you sure?}[y/n/all] " response
  case $response in
    [yY][eE][sS]|[yY])
      true
      ;;
    all)
      export do_all=true
      true
      ;;
    *)
      $do_all || false
      ;;
  esac
}


# Init
git submodule update --init --recursive

# Git
link "$CONFIGS/gitconfig" "$HOME/.gitconfig"
link "$CONFIGS/gitexclude" "$HOME/.gitexclude"
echo "Finish setup Git."

# zshrc
link "$CONFIGS/zshrc.d" "$HOME/.zshrc.d"
link "$HOME/.zshrc.d/zshrc.zsh" "$HOME/.zshrc"
echo "Finish setup zsh."

# fish
link "$CONFIGS/fish" "$HOME/.config/fish"
echo "Finish setup fish."

# SublimeText
link \
"$CONFIGS/sublime_text_3_config" \
"$(select_platform \
   "$HOME/.config/sublime-text-3/Packages/User" \
   "$HOME/Library/Application Support/Sublime Text 3/Packages/User")"
echo "Finish setup Sublime Text."

# Ruby
link "$$CONFIGS/gemrc" "$HOME/.gemrc"
link "$$CONFIGS/irbrc" "$HOME/.irbrc"

# Linux
if [[ $PLATFORM == 'Linux' ]]; then
    # Awesome 3
    link "$CONFIGS/awesome_config/" "$HOME/.config/awesome/rc.lua"
fi

# Mac
if [[ $PLATFORM == 'Darwin' ]]; then
    link "$CONFIGS/BetterTouchTool/" "$HOME/Library/Application Support/"
    link "$CONFIGS/Karabiner/" "$HOME/Library/Application Support/"
fi

# Misc
link "$CONFIGS/bin"        "$HOME/bin"
link "$CONFIGS/ackrc"      "$HOME/.ackrc"
link "$CONFIGS/bashrc"     "$HOME/.bashrc"
link "$CONFIGS/emacs.d"    "$HOME/.emacs.d"
link "$CONFIGS/gemrc"      "$HOME/.gemrc"
link "$CONFIGS/gitconfig"  "$HOME/.gitconfig"
link "$CONFIGS/gitexclude" "$HOME/.gitexclude"
link "$CONFIGS/htoprc"     "$HOME/.htoprc"
link "$CONFIGS/irbrc"      "$HOME/.irbrc"
link "$CONFIGS/screenrc"   "$HOME/.screenrc"
link "$CONFIGS/tmux.conf"  "$HOME/.tmux.conf"
link "$CONFIGS/vimrc"      "$HOME/.vimrc"
