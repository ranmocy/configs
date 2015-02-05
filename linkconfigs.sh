#!/bin/sh

# path of config
sync_path=~/Dropbox/Configs
oh_my_configs_home=~/.oh-my-configs
oh_my_packages_home=~/Dropbox/Packages
oh_my_library_home=~/Dropbox/Library

ln -snf $sync_path $oh_my_configs_home

ln -sf $oh_my_configs_home/ackrc ~/.ackrc
ln -sf $oh_my_configs_home/bashrc ~/.bashrc
ln -sf $oh_my_configs_home/bin ~/bin
ln -sf $oh_my_configs_home/emacs.d ~/.emacs.d
ln -sf $oh_my_configs_home/gemrc ~/.gemrc
ln -sf $oh_my_configs_home/gitconfig ~/.gitconfig
ln -sf $oh_my_configs_home/gitexclude ~/.gitexclude
ln -sf $oh_my_configs_home/htoprc ~/.htoprc
ln -sf $oh_my_configs_home/irbrc ~/.irbrc
ln -sf $oh_my_configs_home/screenrc ~/.screenrc
ln -sf $oh_my_configs_home/tmux.conf ~/.tmux.conf
ln -sf $oh_my_configs_home/vimrc ~/.vimrc

ln -snf $oh_my_configs_home/zshrc.d ~/.zshrc.d
ln -sf ~/.zshrc.d/zshrc.zsh ~/.zshrc
mkdir -p ~/.config/
ln -snf $oh_my_configs_home/fish ~/.config/fish

ln -snf $oh_my_library_home/Application\ Support/BetterTouchTool/ ~/Library/Application\ Support/
ln -snf $oh_my_library_home/Application\ Support/Karabiner/ ~/Library/Application\ Support/

# Sublime Text 3
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/
ln -snf $oh_my_configs_home/Sublime\ Text\ 3/Installed\ Packages/ ~/Library/Application\ Support/Sublime\ Text\ 3/
ln -snf $oh_my_configs_home/Sublime\ Text\ 3/Packages/ ~/Library/Application\ Support/Sublime\ Text\ 3/

# RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
