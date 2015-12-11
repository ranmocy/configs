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
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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

# Homebrew
homebrew() {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install ag coreutils git youtube-dl zsh
    # If you have administrator privileges, you must fix an Apple miss
    # configuration in Mac OS X 10.7 Lion by renaming /etc/zshenv to
    # /etc/zprofile, or Zsh will have the wrong PATH when executed
    # non-interactively by scripts.
    sudo cp /etc/zshenv /etc/zprofile
}

# Tmux
tmux() {
    link "$DIR/tmux.conf" "$HOME/.tmux.conf"
}

# RVM
rvm() {
    # gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    # curl -sSL https://get.rvm.io | bash -s stable

    if [ -d ~/.rvm ]; then
    echo "${red}You already have ~/.rvm.${reset}"
    confirm "Remove it?"
    fi && rm -rf ~/.rvm && curl -L https://get.rvm.io | bash -s stable &&\
    source ~/.rvm/scripts/rvm
    # && sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db

    ln -sfv $oh_my_configs_home/gemrc ~/.gemrc
    ln -sfv $oh_my_configs_home/irbrc ~/.irbrc
}

# Rbenv
install_rbenv() {
    # Todo:
    homebrew install rbenv rbenv-bundler rbenv-gemset
    curl https://raw.github.com/gist/1688857/2-1.9.3-p327-patched.sh > /tmp/1.9.3-p327-perf
    sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' /tmp/1.9.3-p327-perf
    rbenv install /tmp/1.9.3-p327-perf
    rbenv global 1.9.3-p327-perf

    ln -sfv $oh_my_configs_home/gemrc ~/.gemrc
    ln -sfv $oh_my_configs_home/irbrc ~/.irbrc
}

# Ruby
install_ruby_with_falcon_patch() {
    brew update && brew install autoconf automake
    rvm get head && rvm install 1.9.3-p327 --patch falcon &&\
    rvm use ruby-1.9.3-p327 --default
}

# Install servers
install_server() {
    brew install elasticsearch mongodb redis node qt
    # Elastic Search
    ln -sfv /usr/local/opt/elasticsearch/homebrew.mxcl.elasticsearch.plist ~/Library/LaunchAgents/ &&\
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist &&\
    launchctl start homebrew.mxcl.elasticsearch
    # MongoDB
    ln -sfv /usr/local/opt/mongodb/homebrew.mxcl.mongodb.plist ~/Library/LaunchAgents &&\
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist &&\
    launchctl start homebrew.mxcl.mongodb
    # Redis-server
    ln -sfv /usr/local/opt/redis/homebrew.mxcl.redis.plist ~/Library/LaunchAgents/ &&\
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist &&\
    launchctl start homebrew.mxcl.redis
    # Git-daemon
    ln -sfv $oh_my_configs_home/LaunchAgents/com.gitcafe.gitdaemon.plist ~/Library/LaunchAgents/ &&\
    launchctl load ~/Library/LaunchAgents/com.gitcafe.gitdaemon.plist &&\
    launchctl start com.gitcafe.gitdaemon &&\
    launchctl load ~/Library/LaunchAgents/com.gitcafe.ssh-agent.plist &&\
    launchctl start com.gitcafe.ssh-agent
}



## Setup Section ##
# System configs
setup_system_configs() {
    # TODO: Why I have to use hard link with these two files?
    sudo ln -f $oh_my_configs_home/etc/hosts /etc/hosts
    sudo ln -f $oh_my_configs_home/etc/paths /etc/paths
    ln -sfv $oh_my_configs_home/bin ~/bin
    ln -sfv $oh_my_configs_home/ssh ~/.ssh
}
# Sublime Text 2
setup_sublime() {
    if [ -d ~/Library/Application\ Support/Sublime\ Text\ 2 ]; then
    echo "${red}You already have Sublime Text 2 configurations.${reset}"
    confirm "Overwrite it?"
    fi &&\
    ln -sfFv $oh_my_configs_home/Sublime\ Text\ 2/ ~/Library/Application\ Support/Sublime\ Text\ 2
}

# ZSH
setup_zsh() {
    echo "${blue}Cloning Oh My Zsh...${reset}"
    git clone https://github.com/ranmocy/oh-my-zsh.git ~/.oh-my-zsh

    echo "${blue}Using the Oh My Zsh template file and adding it to ~/.zshrc${reset}"
    ln -sfFv $oh_my_configs_home/zshrc.d/ ~/.zshrc.d
    ln -sfv ~/.zshrc.d/zshrc.zsh ~/.zshrc

    echo "${green}"'         __                                     __   '"${reset}"
    echo "${green}"'  ____  / /_     ____ ___  __  __   ____  _____/ /_  '"${reset}"
    echo "${green}"' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '"${reset}"
    echo "${green}"'/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '"${reset}"
    echo "${green}"'\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '"${reset}"
    echo "${green}"'                        /____/                       '"${reset}"
    echo "${green}"'                                 By Ranmocy          '"${reset}"
}

# GoAgent
setup_goagent() {
    # install gevent
    brew install libevent &&\
    tar xvzpf $oh_my_packages_home/gevent-1.0rc2.tar.gz -C /tmp &&\
    cd /tmp/gevent-1.0rc2 && sudo python setup.py install

    ln -sfv $oh_my_configs_home/LaunchAgents/org.goagent.goagent.plist ~/Library/LaunchAgents/ &&\
    launchctl load ~/Library/LaunchAgents/org.goagent.goagent.plist &&\
    launchctl start org.goagent.goagent
}

# User Dictionary
setup_dictionary() {
    ln -sfFv $oh_my_library_home/Dictionaries/ ~/Library/Dictionaries
}

# User Fonts
setup_fonts() {
    ln -sfFv $oh_my_library_home/Fonts/ ~/Library/Fonts
}



## Prompts Section ##
echo "${yellow}Require Command Line Tools.${reset}"
echo "${yellow}You can download it from Apple Developer: http://developer.apple.com/downloads${reset}"

rm -rf $oh_my_configs_home && ln -sfv $sync_path $oh_my_configs_home

confirm "Setup system configs?" && setup_system_configs
confirm "Install Homebrew?" && homebrew
confirm "Install RVM?" && rvm
confirm "Install Ruby 1.9.3-p327 with falcon?" && install_ruby_with_falcon_patch
confirm "Setup Sublime Text2?" && setup_sublime
confirm "Setup ZSH?" && setup_zsh
confirm "Setup Dictionaries?" && setup_dictionary
confirm "Setup Fonts?" && setup_fonts
confirm "Install Development Servers?" && install_server
confirm "Setup GoAgent?" && setup_goagent

echo "${green}"'    _______       _      __   '"${reset}"
echo "${green}"'   / ____(_)___  (_)____/ /_  '"${reset}"
echo "${green}"'  / /_  / / __ \/ / ___/ __ \ '"${reset}"
echo "${green}"' / __/ / / / / / (__  ) / / / '"${reset}"
echo "${green}"'/_/   /_/_/ /_/_/____/_/ /_/  '"${reset}"
echo "${green}"'               By Ranmocy     '"${reset}"
