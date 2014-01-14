#!/bin/bash

set -e;

PLATFORM=`uname`

function confirm() {
  read -r -p "Installing $1? [y/N] " response
  response=`perl -e "print lc('$response');"`    # tolower
  if [[ $response =~ ^(yes|y)$ ]]; then
    return 0
  else
    return 1
  fi
}

if [[ $PLATFORM == 'Linux' ]]; then
  if confirm "essentials"; then
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt install \
      build-essential \
      tmux \
    ;
  fi

  # if [[ confirm "SublimeText" ]]; then
  #   wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  #   echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  #   sudo apt-get update
  #   sudo apt install sublime-text
  # fi

  exit 0
fi

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if confirm "essentials"; then
  # May need grant Full Disk Access to iterm2
  # Sign in to google-chrome
  brew install --cask \
  iterm2 \
  visual-studio-code \
  google-chrome \
  alfred \
  bettertouchtool \
  dropbox \
  google-drive \
  appcleaner \
  the-unarchiver \
  ;
fi

if confirm "sougou"; then
  brew install --cask sogouinput
  open '/usr/local/Caskroom/sogouinput/48a,1535352534/sogou_mac_48a.app'
fi

if confirm "media"; then
  brew install --cask \
  # vlc \
  # spotify \
  iina \
  ;
fi

# if confirm "Adobe CC"; then
#  brew install --cask adobe-creative-cloud ;
#  open '/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app'
# fi

if confirm "dev"; then
  brew install --cask \
  karabiner-elements \
  # android-studio \
  webstorm \
  ;
fi

if confirm "optional"; then
  brew install --cask \
  calibre \
  transmission \
  # chrome-remote-desktop-host \
  telegram \
  # openemu \
  # skim \
  # ScummVM \
  ;
fi

# if [[ confirm "1Password" ]]; then
#   # https://app-updates.agilebits.com/
#   curl -O https://c.1password.com/dist/1P/mac4/1Password-6.8.9.pkg
#   open 1Password-6.8.9.pkg
#   rm 1Password-6.8.9.pkg
# fi

# Sketch.app
# Mathematica.app
# Parallels Desktop.app
