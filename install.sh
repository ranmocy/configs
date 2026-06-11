#!/bin/bash

set -e;

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
if [ -z ${XDG_CONFIG_HOME+x} ]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi

# Functions
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

link "$CONFIGS/htoprc" "$HOME/.htoprc"
finish "htop"

link "$CONFIGS/tmux.conf" "$HOME/.tmux.conf"
finish "Tmux"

link "$CONFIGS/vimrc" "$HOME/.vimrc"
finish "VIM"

code_root="$([[ $PLATFORM == 'Linux' ]] && echo "$XDG_CONFIG_HOME/code" || echo "$HOME/Library/Application Support/Code")"
echo "Detected VS Code root:$code_root"
link "$CONFIGS/Code/keybindings.json" "$code_root/User/keybindings.json"
link "$CONFIGS/Code/settings.json" "$code_root/User/settings.json"
link "$CONFIGS/Code/tasks.json" "$code_root/User/tasks.json"
link "$CONFIGS/Code/snippets" "$code_root/User/snippets"
finish "Code"

finish "Preferences"

# Linux
if [[ $PLATFORM == 'Linux' ]]; then
    # eza
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    # zoxide
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

    # delta
    wget https://github.com/dandavison/delta/releases/download/0.19.1/git-delta-musl_0.19.1_amd64.deb -O /tmp/git-delta-musl.deb
    sudo apt install /tmp/git-delta-musl.deb

    # bat
    sudo apt install bat
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/batcat ~/.local/bin/bat
fi

# Mac
if [[ $PLATFORM == 'Darwin' ]]; then
    # App shortcuts
    defaults write com.apple.Safari NSUserKeyEquivalents -dict-add 'Close Tab' '<string>@w</string></dict>'
    defaults write com.apple.universalaccess com.apple.custommenu.apps -array-add '<string>com.apple.Safari</string>'

    link "$CONFIGS/karabiner" "$HOME/.config/karabiner"
    finish "Karabiner-Element"

    link_default "Library/Developer/Xcode/UserData/FontAndColorThemes"
    link_default "Library/Developer/Xcode/UserData/KeyBindings"
    finish "Xcode"

    #link_default "Library/texmf"
    #finish "texmf"

    # Disable ReportCrash
    launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
    sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

fi

#source $CONFIGS/packages_install.sh
#finish "Packages"
