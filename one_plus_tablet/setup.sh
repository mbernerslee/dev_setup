#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/../fatboi/coloured_echos.sh"

add_line_if_missing() {
  grep -E "^$1$" $2 >/dev/null
  if [[ $? -eq 0 ]]; then
    echo "$1 - $2 - Already set"
  else
    echo "$1" >> $2
    echo "$1 - $2 - Set"
  fi
}

install_nerdfont() {
  if [[ -f ~/.termux/font.ttf ]]; then
    echo_in_green "Nerdfont already installed"
  else
    echo_in_magenta "Dowloading & Installing nerd font..."
    mkdir -p ~/.termux
    cd ~/.termux && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf && mv JetBrainsMonoNerdFont-Regular.ttf font.ttf

    termux-reload-settings
  fi
}

add_bashrc_additions() {
  bashrc_line="source $SCRIPT_DIR/bashrc_additions"
  add_line_if_missing "$bashrc_line" ~/.bashrc
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
      mkdir ~/.config
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

configure_termux() {
  echo_in_magenta "termux symlink - checking"
  if [ -d ~/src/dev_setup ]; then
    dest=$(realpath ~/src/dev_setup/one_plus_tablet/termux.properties)
    link=$(readlink ~/.termux/termux.properties 2>&1)
    if [ $? -eq 0 ]; then
      if [ "$link" = "$dest" ]; then
        echo_in_green "termux symlink - already in place!"
      else
        echo_in_red "termux symlink - broken!"
        exit 1
      fi
    else
      mkdir ~/.config
      ln -sf ~/src/dev_setup/one_plus_tablet/termux.properties ~/.termux/termux.properties
      if [ $? -eq 0 ]; then
        echo_in_green "termux symlink - created successfully!"
      else
        echo_in_red "termux symlink - creation failed!"
        exit 1
      fi
    fi
  else
    exit 1
  fi
}

install_mob() {
  mkdir -p ~/.local/bin
  echo_in_magenta "mob - checking"
  if [ -d ~/src/mob ]; then
    echo_in_green "mob - already in place!"
  else
    echo_in_magenta "mob - git cloning..."
    git clone git@github.com:mbernerslee/mob.git ~/src/mob
    if [ $? -eq 0 ]; then
      echo_in_magenta "mob - installing..."
      cd ~/src/mob
      ./install
      if [ $? -eq 0 ]; then
        echo_in_green "mob - installed successfully!"
      else
        echo_in_red "mob - install failed"
      fi
    else
      echo_in_red "mob - failed"
    fi
  fi
}

mkdir -p ~/src
pkg install tmux neovim git zoxide clang wget curl ncurses-utils which fzf -y
add_bashrc_additions
configure_neovim
install_nerdfont
configure_termux
install_mob
