#/bin/bash

set -e;

function confirm() {
  read -r -p "Installing $1? [y/N] " response
  response=`perl -e "print lc('$response');"`    # tolower
  if [[ $response =~ ^(yes|y)$ ]]; then
    return 0
  else
    return 1
  fi
}

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

if [[ confirm "media" ]]; then
  brew cask install \
  spotify \
  vlc \
  # bilibili \
  ;
fi

if [[ confirm "dev" ]]; then
  brew cask install \
  karabiner-elements \
  android-studio \
  webstorm \
  ;
fi

if [[ confirm "optional" ]]; then
  # calibre \
  # transmission \
  # chrome-remote-desktop-host \
  # telegram \
  # openemu \
  # skim \
  # ScummVM \
fi

brew cask install adobe-creative-cloud
open '/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app'

brew cask install sogouinput
open '/usr/local/Caskroom/sogouinput/48a,1535352534/sogou_mac_48a.app'

if [[ confirm "1Password" ]]; then
  # https://app-updates.agilebits.com/
  curl -O https://c.1password.com/dist/1P/mac4/1Password-6.8.9.pkg
  open 1Password-6.8.9.pkg
  rm 1Password-6.8.9.pkg
fi

# Sketch.app
# Mathematica.app
# Parallels Desktop.app
