#! /bin/bash

# Manually setup sudo

#su
#apt install sudo
#usermod -aG sudo berners
#exit (exit super user that is)
#sudo install git -y
#cd ~
#ssh-keygen -t rsa -b 4096 -C "matthewbernerslee@gmail.com"
# copy public key (~/.ssh/id_rsa.pub) to github to allow cloning

# Cygwin **important**
# for cygwin colors to be correct Options -> Terminal -> Type -> xterm-256color. apply & save. restart cygwin

#TODO make all commands impenpotent

function configure_bashrc {
  source_bashrc_additions="source ~/src/dev_setup/bashrc_dev_machine_additions"
  if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then
    echo "$source_bashrc_additions" >> ~/.bashrc
  fi

  sed -i "s/PS1='\([^']*\)'/PS1=\"\1\"/g" ~/.bashrc

  if [ `grep -c "parse_git_branch()" ~/.bashrc` -eq 0 ];
  then
    printf -v prepend "%q" " git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'"

    sed -i "1s;^;}\n;" ~/.bashrc
    sed -i "1s;^;$prepend\n;" ~/.bashrc
    sed -i "1s;^;parse_git_branch() {\n;" ~/.bashrc
  fi

  if [ `grep -c "(parse_git_branch)" ~/.bashrc` -eq 0 ];
  then
    find_substring='w\\\[\\033\[00m\\\]\\\$'
    replace_substring='w\\\[\\033\[35m\\\]\\\$\(parse_git_branch\)\\\[\\033\[00m\\\]\\\$'
    sed -i "s/$find_substring/$replace_substring/g" ~/.bashrc
  fi

  sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
  sed -i 's/\[\\033\[01;32m\\\]\\u/\[\\033\[01;33m\\\]\\u/g' ~/.bashrc
}

function install_tmux {
  sudo apt-get install tmux -y
}

function install_vim {
  sudo apt update
  sudo apt install vim -y
}

function configure_vim {
  touch ~/.vimrc
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
  vim +'PlugInstall --sync' +qa

  sudo apt-get install ack -y
}

function install_elixir {
  if ! dpkg -l elixir
  then
    echo "deb https://packages.erlang-solutions.com/debian buster contrib" | sudo tee /etc/apt/sources.list.d/erlang-solutions.list
    wget https://packages.erlang-solutions.com/debian/erlang_solutions.asc
    sudo apt install gnupg2 -y
    sudo apt-key add erlang_solutions.asc
    rm erlang_solutions.asc
    sudo apt update
    sudo apt install esl-erlang -y
    sudo apt install elixir -y
  fi
}

function create_src_folder {
  mkdir -p ~/src
}

function install_git {
  pushd .
  sudo apt install git -y
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

function install_curl {
  sudo apt install curl -y
}

function install_beautifier_prerequisites {
  sudo apt install bc -y
}

function install_elm_watch {
  if [ ! -d "~/src/elm_watch" ]; then
    pushd .
    cd ~/src
    git clone git@github.com:mbernerslee/elm_watch.git
    popd
  fi
}

install_beautifier_prerequisites
. ./beautifier

run_action create_src_folder
run_action install_git
run_action configure_bashrc
run_action install_tmux
run_action install_vim
run_action install_curl
run_action configure_vim
run_action install_elixir
run_action install_phoenix_with_node_6
run_action install_postgress
run_action configure_postgress
run_action install_constant_testing
run_action install_elm
run_action install_elm_watch
sudo apt autoremove -y
