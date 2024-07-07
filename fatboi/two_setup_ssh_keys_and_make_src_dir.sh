#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/coloured_echos.sh"

create_src_directory() {
  create_src_command="mkdir -p ~/src"
  echo_in_magenta "Running $create_src_command"
  eval "$create_src_command"

  if [[ $? -eq 0 ]]; then
    echo_in_green "$create_src_command succeeded"
  else
    echo_in_red "$create_src_command failed"
    exit 1
  fi
}

create_ssh_keys() {
  echo_in_magenta "SSH Keys - checking existing"
  if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo_in_green "SSH keys - ~/.ssh/id_rsa.pub already exists"
  else
    echo_in_magenta "SSH keys - creating at ~/.ssh/id_rsa"
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
  fi
}

put_github_keys_message() {
  echo "Now put the pubic key into github"
  echo "Running cat ~/.ssh/id_rsa.pub"
  echo -e "\n**************************\n"
  cat ~/.ssh/id_rsa.pub
  echo -e "\n**************************\n"

  echo "https://github.com/settings/keys/new"
  echo -e "\n**************************"
}

#TODO create SSH keys & add them to github

create_src_directory
create_ssh_keys
put_github_keys_message
