#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
#git pull --recurse-submodules
git submodule foreach 'git checkout master && git pull origin master'
