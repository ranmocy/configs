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
  if [[ confirm "essentials" ]]; then
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt install \
      build-essential \
      tmux \
    ;
  fi

  if [[ confirm "SublimeText" ]]; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt install sublime-text
  fi

  exit 0
fi

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if [[ confirm "essentials" ]]; then
  # May need grant Full Disk Access to iterm2
  # Need install sublime text package manager
  # Sign in to google-chrome
  brew cask install \
  iterm2 \
  sublime-text \
  google-chrome \
  alfred \
  bettertouchtool \
  dropbox \
  google-backup-and-sync \
  appcleaner \
  the-unarchiver \
  ;
fi

if [[ confirm "sougou" ]]; then
  brew cask install sogouinput
  open '/usr/local/Caskroom/sogouinput/48a,1535352534/sogou_mac_48a.app'
fi

if [[ confirm "media" ]]; then
  brew cask install \
  spotify \
  vlc \
  # bilibili \
  ;
fi

if [[ confirm "Adobe CC" ]]; then
  brew cask install adobe-creative-cloud
  open '/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app'
fi

if [[ confirm "dev" ]]; then
  brew cask install \
  karabiner-elements \
  android-studio \
  webstorm \
  ;
fi

if [[ confirm "optional" ]]; then
  brew cask install \
  calibre \
  transmission \
  # chrome-remote-desktop-host \
  # telegram \
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
