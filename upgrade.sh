#!/bin/bash

set -e

CONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $CONFIGS

# update configs
git pull

# update submodules
git submodule foreach --recursive 'git checkout master && git pull origin master'

# update zshrc
if [[ -d zshrc.d ]]; then
    echo "Updating zshrc deps..."
    cd zshrc.d
    for d in 'oh-my-zsh' 'z' 'zsh-syntax-highlighting'; do
        cd $d
        git checkout master && git pull origin master
        cd ..
    done
fi
