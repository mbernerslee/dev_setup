#! /bin/bash

# Manually setup sudo

# Manually change username@machine_name colour. see
# https://askubuntu.com/questions/123268/changing-colors-for-user-host-directory-information-in-terminal-command-prompt

#TODO make name@machine color change scripted

function configure_bashrc {
  source_bashrc_additions="source ~/src/dev_setup/bashrc_dev_machine_additions"
  if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then
    echo "$source_bashrc_additions" >> ~/.bashrc
  fi
  color_prompt="#force_color_prompt=yes"
  ps1=
  if [ `grep -c "$color_prompt" ~/.bashrc` -eq 0 ] && [ `grep -c "$color_prompt" ~/.bashrc` -eq 0 ]; then
    echo "hi"
  fi
}

function install_tmux {
  sudo apt-get install tmux -y
}

function install_vim {
  sudo apt update
  sudo apt install vim
}

function configure_vim {
  touch ~/.vimrc
  pushd .
  mkdir -p ~/.vim/colors
  cd ~/.vim/colors
  if [ ! -f solarized.vim ]; then
    wget https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
  fi
  popd

  sudo apt-get install ack -y
}

function install_elixir {
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
  sudo apt-get update
  sudo apt-get install esl-erlang -y
  sudo apt-get install elixir -y
  rm erlang-solutions_1.0_all.deb
}

function create_src_folder {
  if [ ! -d "~/src" ]; then
    mkdir ~/src
  fi
}

function install_git {
  pushd .
  sudo apt-get install git -y
  if [ ! -d "~/src/dev_setup" ]; then
    cd ~/src
    git clone git@github.com:mbernerslee/dev_setup.git
  fi
  popd
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

function install_constant_testing {
  if [ ! -d "~/src/constant_testing" ]; then
    pushd .
    cd ~/src
    git clone git@github.com:danturn/constant_testing.git
    popd
  fi
}

# Here to docuement what I setup I used to have
function configure_neovim {
  mkdir ~/.config
  mkdir ~/.config/nvim
  touch ~/.config/nvim/init.vim
  cat init.vim >> ~/.config.init.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sudo apt-get install silversearcher-ag
  wget https://github.com/jhawthorn/fzy/releases/download/0.9/fzy_0.9-1_amd64.deb
  sudo dpkg -i fzy_0.9-1_amd64.deb
  rm fzy_0.9-1_amd64.deb
  sudo apt-get update
  sudo apt-get install python3-pip -y
  pip3 install neovim
  nvim +'PlugInstall --sync' +qa
}

function install_elm {
  wget "https://github.com/elm/compiler/releases/download/0.19.0/binaries-for-linux.tar.gz"
  tar xzf binaries-for-linux.tar.gz
  sudo mv elm /usr/local/bin/
  rm binaries-for-linux.tar.gz
}

create_src_folder
install_git
configure_bashrc
install_tmux
install_vim
configure_vim
install_elixir
install_phoenix_with_node_6
install_postgress
configure_postgress
install_constant_testing
install_elm
sudo apt autoremove -y
