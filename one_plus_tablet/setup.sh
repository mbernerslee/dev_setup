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

  #wget -P ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \

install_nerdfont() {
  #  curl -fLo ~/.termux/font.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf && termux-reload-settings
#  echo_in_magenta "nerdfont - checking"
#  if [ -f ~/.termux/font.ttf ]; then
#    echo_in_green "nerdfont - already installed"
#  else
#    echo_in_magenta "nerdfont - installing.."
#    wget -P ~/.termux https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
#    && cd ~/.termux/ \
#    && unzip JetBrainsMono.zip \
#    && rm JetBrainsMono.zip \
#    && fc-cache -fv

    mkdir -p ~/.termux
    cd ~/.termux && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf && mv JetBrainsMonoNerdFont-Regular.ttf font.ttf

    termux-reload-settings


    #patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf

#  fi
}

add_bashrc_additions() {
  bashrc_line="source $SCRIPT_DIR/../fatboi/bashrc_additions"
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

#mkdir -p ~/src
#pkg install tmux neovim git zoxide clang wget curl -y
#add_bashrc_additions
#configure_neovim
install_nerdfont
