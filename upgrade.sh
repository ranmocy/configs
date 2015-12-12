#!/bin/bash

CONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $CONFIGS
#git pull --recurse-submodules
git submodule foreach --recursive 'git checkout master && git pull origin master'
