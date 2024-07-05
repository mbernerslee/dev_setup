#!/bin/bash

create_src_directory() {
  mkdir -p ~/src
}

create_ssh_keys() {
  if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo "SSH keys ~/.ssh/id_rsa.pub already exists"
  else
    echo "creating SSH keys at ~/.ssh/id_rsa"
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
