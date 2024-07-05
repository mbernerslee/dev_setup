#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"
MAGENTA="\033[35m"

echo_in_magenta() {
  echo -e "${MAGENTA}$1${NOCOLOR}"
}

echo_in_green() {
  echo -e "${GREEN}$1${NOCOLOR}"
}

echo_in_red() {
  echo -e "${RED}$1${NOCOLOR}"
}

install_neovim() {
  which nvim >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "neovim already installed"
    nvim --version
  else
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod +x ./nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
  fi
}

install_ripgrep() {
  which rg >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "rg already installed"
    rg --version
  else
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
    rm ripgrep_14.1.0-1_amd64.deb
  fi
}

configure_neovim() {
  if [ -d ~/src/dev_setup ]; then
    echo_in_magenta "Checking ~/src/dev_setup/nvim ~/.config/nvim symlink..."
    dest=$(realpath ~/src/dev_setup/nvim)
    link=$(readlink ~/.config/nvim 2>&1)
    if [ $? -eq 0 ]; then
      if [ "$link" = "$dest" ]; then
        echo_in_green "already in place!"
      else
        echo_in_red "broken!"
        exit 1
      fi
    else
      ln -sf ~/src/dev_setup/nvim ~/.config/nvim
      if [ $? -eq 0 ]; then
        echo_in_green "created successfully!"
      else
        echo_in_red "creation attempt failed!"
        exit 1
      fi
    fi
  else
    echo_in_red "~/src/dev_setup does not exist, so bailing"
    exit 1
  fi
}

install_lua() {
  sudo apt install lua5.4
}

#install_lua_rocks() {
# curl -LO https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
# tar -xf luarocks-3.11.1.tar.gz
# cd luarocks-3.11.1
# ./configure --with-lua-include=/usr/local/include
# #make
#}

#sudo apt update
sudo apt install build-essential libreadline-dev unzip curl wget gcc -y
install_lua
#install_lua_rocks
install_ripgrep
install_neovim
#configure_neovim
