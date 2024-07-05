#!/bin/bash

if [ ! -d "$HOME/src/dev_setup" ]; then
  git clone git@github.com:mbernerslee/dev_setup.git ~/src/dev_setup
fi

cd ~/src/dev_setup
