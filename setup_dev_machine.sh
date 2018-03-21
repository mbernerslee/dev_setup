#! /bin/bash

# Manually setup sudo

# Manually change username@machine_name colour. see 
# https://askubuntu.com/questions/123268/changing-colors-for-user-host-directory-information-in-terminal-command-prompt

#TODO make name@machine color change scripted

function configure_bashrc {
  source_bashrc_additions="source ~/src/dev_setup/dev_machine_bashrc_additions"
  if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then 
    echo "$source_bashrc_additions" >> ~/.bashrc
  fi
  #color_prompt="#force_color_prompt=yes"
  #ps1=
  #if [ `grep -c "$color_prompt" ~/.bashrc` -eq 0 ] && [ `grep -c "$color_prompt" ~/.bashrc` -eq 0 ]; then
  #  echo "hi"
  #fi
}

function install_neovim {
  sudo apt-get install neovim -y
  sudo apt-get install python-neovim -y
  sudo apt-get install python3-neovim -y
  sudo apt-get install xclip -y
}

function install_tmux {
  sudo apt-get install tmux -y
}

function install_elixir {
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
  sudo apt-get update
  sudo apt-get install esl-erlang -y
  sudo apt-get install elixir -y
  rm erlang-solutions_1.0_all.deb
}

function install_git {
  if [ ! -d "~/src" ]; then
    mkdir ~/src
  fi
  cd ~/src
  sudo apt-get install git -y
  git clone https://github.com/mbernerslee/dev_setup.git
}

function install_phoenix_with_node_6 {
  mix local.hex --force
  mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
  sudo apt-get update
  sudo apt-get install inotify-tools -y
  sudo apt-get install curl -y
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
  sudo apt-get install -y nodejs
}

function install_postgress {
  sudo apt-get install postgresql postgresql-client -y
}

function configure_postgress {
  sudo service postgresql start
  sudo -u postgres psql -c "alter user postgres with password 'postgres';"
}

function configure_neovim {
  #mkdir ~/.config
  #mkdir ~/.config/nvim
  #touch ~/.config/nvim/init.vim
  #cat init.vim >> ~/.config.init.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sudo apt-get install silversearcher-ag
  wget https://github.com/jhawthorn/fzy/releases/download/0.9/fzy_0.9-1_amd64.deb
  sudo dpkg -i fzy_0.9-1_amd64.deb
  rm fzy_0.9-1_amd64.deb
  sudo apt-get update
  sudo apt-get install python3-pip -y
  pip3 install neovim
}

function install_hub {
  if [ -f ~/bin/hub ]; then echo -e "\e[32mhub installed \e[0m" && return; fi
  pushd .
  cd /tmp
  wget https://github.com/github/hub/releases/download/v2.2.1/hub-linux-amd64-2.2.1.tar.gz -O hub.tar.gz
  tar xvf hub.tar.gz  
  rm hub.tar.gz
  if [ ! -d ~/bin ]; then mkdir ~/bin; fi
  mv hub-linux-amd64-2.2.1/hub ~/bin
  rm hub-linux-amd64-2.2.1 -rf 
  popd
}

install_git
configure_bashrc
install_neovim
install_tmux
install_elixir
install_phoenix_with_node_6
install_postgress
configure_postgress
configure_neovim
install_hub
