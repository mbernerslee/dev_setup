#! /bin/bash

function configure_bashrc {
  source_bashrc_additions="source ~/src/dev_setup/bashrc_host_additions"
  if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then 
    echo "$source_bashrc_additions" >> ~/.bashrc
  fi
}

sudo apt-get update
sudo apt-get install openssh-server -y
configure_bashrc
