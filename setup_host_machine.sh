#! /bin/bash

function configure_bashrc {
  cat bashrc_host_additions >> ~/.bashrc
  source ~/.bashrc
}

sudo apt-get update
sudo apt-get install openssh-server -y
