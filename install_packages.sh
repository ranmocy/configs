#/bin/bash

set -e;

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install \
iterm2 \
sublime-text \
alfred \
karabiner-elements \
bettertouchtool \
android-studio \
webstorm \
dropbox \
google-backup-and-sync \
transmission \
appcleaner \
spotify \
calibre \
vlc \
the-unarchiver \
telegram \
chrome-remote-desktop-host \
bilibili \
openemu \
skim \
# ScummVM \
;

brew cask install adobe-creative-cloud
open '/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app'

brew cask install sogouinput
open '/usr/local/Caskroom/sogouinput/48a,1535352534/sogou_mac_48a.app'

# https://app-updates.agilebits.com/
curl -O https://c.1password.com/dist/1P/mac4/1Password-6.8.9.pkg
open 1Password-6.8.9.pkg

# Sketch.app
# Mathematica.app
# Parallels Desktop.app
