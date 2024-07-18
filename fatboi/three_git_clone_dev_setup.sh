#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/coloured_echos.sh"

echo_in_magenta "dev_setup github repo - checking"
if [ -d "$HOME/src/dev_setup" ]; then
  echo_in_green "dev_setup github repo - ~/src/dev_setup already exists"
else
  echo_in_magenta "dev_setup github repo - git cloning dev_setup"
  git clone git@github.com:mbernerslee/dev_setup.git ~/src/dev_setup
fi

cd ~/src/dev_setup
