#! /bin/bash

function configure_bashrc {
  cat bashrc_host_additions >> ~/.bashrc
  source ~/.bashrc
}
