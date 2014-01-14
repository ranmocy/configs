#!/bin/bash

set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
CONFIGS="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
cd $CONFIGS

# update configs
git pull

# update submodules
git submodule foreach --recursive '(git checkout master || git checkout main) && git pull origin'

# update zshrc
echo "Checking zshrc.d..."
if [[ -d zshrc.d ]]; then
    echo "Updating zshrc deps..."
    cd zshrc.d
    for d in 'oh-my-zsh' 'z' 'zsh-syntax-highlighting'; do
        cd $d
        git checkout master && git pull origin master
        cd ..
    done
else
    echo "zshrc.d not exist!"
fi
