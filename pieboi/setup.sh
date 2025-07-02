#!/bin/bash

# Manual steps
# create ~/.vimrc with "imap jj <Esc>"
# run "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa"
# scp keys into ~/.ssh/keys folder from other machine

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/../fatboi/coloured_echos.sh"

add_line_if_missing() {
  grep -E "^$1$" $2 >/dev/null
  if [[ $? -eq 0 ]]; then
    echo "$1 - $2 - Already set"
  else
    echo "$1" >> $2
    echo "$1 - $2 - Set"
  fi
}

symlink_minimal_vimrc() {
  echo_in_magenta "checking vimrc symlink"

  path=~/.vimrc

  dest=$(realpath ~/src/dev_setup/.minimal_vimrc)
  link=$(readlink $path 2>&1)

  if [ $? -eq 0 ] && [ "$link" = "$dest" ]; then
    echo_in_green "vimrc symlink - already in place!"
  else
    echo_in_magenta "vimrc symlink - setting up..."
    sudo ln -sf $dest $path

    if [ $? -eq 0 ]; then
      echo_in_green "vimrc symlink - setup complete!"
    else
      echo_in_red "vimrc symlink - setup failed"
      exit 1
    fi
  fi
}

function install_minimal_vimrc_dependencies {
  pushd .
  mkdir -p ~/.vim/colors
  cd ~/.vim/colors
  if [ ! -f solarized.vim ]; then
    wget https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
  fi
  if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  popd

  sudo apt-get install ack -y
  vim +'PlugInstall --sync' +qa
}

sudo apt update
sudo apt install vim tree wakeonlan git tmux -y
mkdir -p ~/src
mkdir -p ~/.ssh/keys
touch ~/.ssh/config
touch ~/.ssh/authorized_keys

add_line_if_missing "source $SCRIPT_DIR/../base_bashrc_additions" ~/.bashrc
install_minimal_vimrc_dependencies
symlink_minimal_vimrc
