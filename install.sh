#!/bin/bash

set -e

# Colors
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

# Env
CONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLATFORM=`uname`
function success() {
  echo "${green}$1${reset}"
}
function warn() {
  echo "${yellow}$1${reset}"
}
function finish() {
  success "Finish setup $1."
}
function link() {
  local source=$1
  local target=$2
  local parent="$( dirname "$target" )"
  if [[ $source = */ ]]; then
    warn 'Your source has tailing "/"! May hurt linking process!'
    exit 1
  fi
  if [[ $target = */ ]]; then
    warn 'Your target has tailing "/"! May hurt linking process!'
    exit 1
  fi
  # check if parent exists
  if [ ! -e "$parent" ]; then
    warn "$parent does not exist, mkdir_p"
    mkdir -p "$parent"
  fi
  # check not a symbolic link and it's a directory
  if [ ! -L "$target" ] && [ -d "$target" ]; then
    read -r -p "$target is a directory. Remove_rf? [y/N] " response
    response=`perl -e "print lc('$response');"`    # tolower
    if [[ $response =~ ^(yes|y)$ ]]; then
      warn "Remove $target"
      rm -rf "$target"
    fi
  fi
  echo "Linking $source to $target..."
  ln -sfn "$source" "$target"
}
function link_default() {
  local path=$1
  link "$CONFIGS/$1" "$HOME/$1"
}


git submodule update --init --recursive
link_default "bin"
finish "bin"

link "$CONFIGS/gitconfig" "$HOME/.gitconfig"
link "$CONFIGS/gitexclude" "$HOME/.gitexclude"
finish "Git"

link "$CONFIGS/bashrc" "$HOME/.bashrc"
finish "Bash"

link "$CONFIGS/zshrc.d" "$HOME/.zshrc.d"
link "$HOME/.zshrc.d/zshrc.zsh" "$HOME/.zshrc"
finish "zsh"

link "$CONFIGS/fish_config" "$HOME/.config/fish"
finish "fish"

link "$CONFIGS/emacs_config" "$HOME/.emacs.d"
finish "Emacs"

link "$CONFIGS/gemrc" "$HOME/.gemrc"
link "$CONFIGS/irbrc" "$HOME/.irbrc"
finish "Ruby"

link "$CONFIGS/pythonstartup" "$HOME/.pythonstartup"
finish "Python"

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

sublime_root="$([[ $PLATFORM == 'Linux' ]] && echo "$XDG_CONFIG_HOME/sublime-text-3" || echo "$HOME/Library/Application Support/Sublime Text 3")"
link "$CONFIGS/sublime_text_3_config" "$sublime_root/Packages/User"
finish "Sublime Text"

jetbrain_root="$([[ $PLATFORM == 'Linux' ]] && echo "$XDG_CONFIG_HOME/JetBrains" || echo "$HOME/Library/Preferences")"
webstorm_target=`find $jetbrain_root -name 'WebStorm*' | tail -1`
if [[ !  -z  $webstorm_target  ]]; then
  link "$CONFIGS/Library/Preferences/WebStorm/colors" "$webstorm_target/colors"
  link "$CONFIGS/Library/Preferences/WebStorm/keymaps" "$webstorm_target/keymaps"
else
  echo "No WebStorm found!"
fi
studio_target=`find $jetbrain_root -name 'AndroidStudio*' | tail -1`
if [[ !  -z  $studio_target  ]]; then
  link "$CONFIGS/AndroidStudio/config/colors" "$studio_target/colors"
  link "$CONFIGS/AndroidStudio/config/keymaps" "$studio_target/keymaps"
else
  echo "No AndroidStudio found!"
fi
intellij_target=`find $jetbrain_root -name 'IdeaIC*' | tail -1`
if [[ !  -z  $intellij_target  ]]; then
  link "$CONFIGS/AndroidStudio/config/colors" "$intellij_target/colors"
  link "$CONFIGS/AndroidStudio/config/keymaps" "$intellij_target/keymaps"
else
  echo "No IdeaIC found!"
fi
finish "Preferences"

# Linux
if [[ $PLATFORM == 'Linux' ]]; then
    link "$CONFIGS/awesome_config" "$XDG_CONFIG_HOME/awesome"
    finish "Awesome 3"

    link "$CONFIGS/Xdefaults" "$HOME/.Xdefaults"
    link "$CONFIGS/xinitrc" "$HOME/.xinitrc"
    link "$CONFIGS/xprofile" "$HOME/.xprofile"
    # link "$CONFIGS/xmodmap" "$HOME/.xmodmap"
    finish "X"
fi

# Mac
if [[ $PLATFORM == 'Darwin' ]]; then
    link_default "Library/Application Support/BetterTouchTool/bttdata2"
    finish "BetterTouchTool"

    link "$CONFIGS/karabiner" "$HOME/.config/karabiner"
    finish "Karabiner-Element"

    link "$CONFIGS/hammerspoon" "$HOME/.hammerspoon"
    finish "Hammerspoon"

    link_default "Library/Developer/Xcode/UserData/FontAndColorThemes"
    link_default "Library/Developer/Xcode/UserData/KeyBindings"
    finish "Xcode"

    link_default "Library/KeyBindings/DefaultKeyBinding.dict"
    finish "DefaultKeyBinding"

    link_default "Library/texmf"
    finish "texmf"
fi
