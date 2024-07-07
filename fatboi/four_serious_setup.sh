#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/coloured_echos.sh"

add_line_if_missing() {
  grep -E "^$1$" $2 >/dev/null
  if [[ $? -eq 0 ]]; then
    echo "$1 - $2 - Already set"
  else
    echo "$1" >> $2
    eval $"$3"=true
    echo "$1 - $2 - Set"
  fi
}

install_neovim() {
  echo_in_magenta "neovim - checking if install required"
  which nvim >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "neovim - already installed"
    nvim --version
  else
    echo_in_magenta "neovim - installing.."
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod +x ./nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
  fi
}

install_ripgrep() {
  echo_in_magenta "ripgrep - checking if install required"
  which rg >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "ripgrep - already installed"
    rg --version
  else
    echo_in_magenta "ripgrep - installing.."
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
    rm ripgrep_14.1.0-1_amd64.deb
  fi
}

configure_neovim() {
  echo_in_magenta "neovim symlink - checking"
  if [ -d ~/src/dev_setup ]; then
    dest=$(realpath ~/src/dev_setup/nvim)
    link=$(readlink ~/.config/nvim 2>&1)
    if [ $? -eq 0 ]; then
      if [ "$link" = "$dest" ]; then
        echo_in_green "neovim symlink - already in place!"
      else
        echo_in_red "neovim symlink - broken!"
        exit 1
      fi
    else
      ln -sf ~/src/dev_setup/nvim ~/.config/nvim
      if [ $? -eq 0 ]; then
        echo_in_green "neovim symlink - created successfully!"
      else
        echo_in_red "neovim symlink - creation failed!"
        exit 1
      fi
    fi
  else
    echo_in_red "neovim symlink - ~/src/dev_setup does not exist, so bailing"
    exit 1
  fi
}

install_nerdfont() {
  echo_in_magenta "nerdfont - checking if install required"
  if [ -f ~/.local/share/fonts/JetBrainsMonoNerdFont-Medium.ttf ]; then
    echo_in_green "nerdfont - already installed"
  else
    echo_in_magenta "nerdfont - installing.."
    wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
    && cd ~/.local/share/fonts \
    && unzip JetBrainsMono.zip \
    && rm JetBrainsMono.zip \
    && fc-cache -fv
  fi
}

sudo_apt_install_packages() {
  packages="build-essential libreadline-dev unzip curl wget gcc tmux"
  echo_in_magenta "Running 'sudo apt install $packages -y'"
  eval "sudo apt install $packages -y"
}

sudo_apt_update() {
  echo_in_magenta "Running sudo apt update"
  sudo apt update
}

add_bashrc_additions() {
  bashrc_line="source $SCRIPT_DIR/bashrc_additions"
  echo_in_magenta "bashrc additions - checking if they're added already"
  if [ `grep -c "$bashrc_line" ~/.bashrc` -eq 0 ]; then
    echo_in_magenta "bashrc additions - adding them.."
    echo "$bashrc_line" >> ~/.bashrc
    if [[ $? -eq 0 ]]; then
      echo_in_green "bashrc additions - added successfully"
    else
      echo_in_ren "bashrc additions - failed"
      exit 1
    fi
  else
    echo_in_green "bashrc additions - they're already added"
  fi
}

configure_tmux() {
  #echo_in_magenta "Configuring tmux..."
  #if [ -d ~/src/dev_setup ]; then
  #  ln -sf ~/src/dev_setup/.tmux.conf ~/.tmux.conf
  #  echo_in_green "tmux configured"
  #else
  #  echo_in_red "~/src/dev_setup does not exist, so bailing"
  #  exit 1
  #fi
  echo_in_magenta "tmux config symlink - checking"
  if [ -d ~/src/dev_setup ]; then
    dest=$(realpath ~/src/dev_setup/.tmux.conf)
    link=$(readlink ~/.tmux.conf 2>&1)
    if [ $? -eq 0 ]; then
      if [ "$link" = "$dest" ]; then
        echo_in_green "tmux config symlink - already in place!"
      else
        echo_in_red "tmux config symlink - broken!"
        exit 1
      fi
    else
      ln -sf ~/src/dev_setup/.tmux.conf ~/.tmux.conf
      if [ $? -eq 0 ]; then
        echo_in_green "tmux config symlink - created successfully!"
      else
        echo_in_red "tmux config symlink - creation failed!"
        exit 1
      fi
    fi
  else
    echo_in_red "tmux config symlink - ~/src/dev_setup does not exist, so bailing"
    exit 1
  fi
}

sudo_apt_update
sudo_apt_install_packages
install_nerdfont
install_ripgrep
install_neovim
configure_neovim
configure_tmux
add_bashrc_additions
