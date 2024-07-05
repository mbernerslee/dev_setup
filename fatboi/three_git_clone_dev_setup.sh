#!/bin/bash

if [ -d "$HOME/src/dev_setup" ]; then
  echo "~/src/dev_setup already exists"
else
  echo "git cloning dev_setup"
  git clone git@github.com:mbernerslee/dev_setup.git ~/src/dev_setup
fi

cd ~/src/dev_setup
