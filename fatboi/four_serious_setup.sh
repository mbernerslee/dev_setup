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
  echo_in_magenta "neovim - checking"
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
  echo_in_magenta "ripgrep - checking"
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
  echo_in_magenta "nerdfont - checking"
  if [ -f ~/.local/share/fonts/JetBrainsMonoNerdFont-Medium.ttf ]; then
    echo_in_green "nerdfont - already installed"
  else
    echo_in_magenta "nerdfont - installing.."
    wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
    && cd ~/.local/share/fonts \
    && unzip JetBrainsMono.zip \
    #&& rm JetBrainsMono.zip \
    #&& fc-cache -fv
  fi
}

sudo_apt_install_packages() {
  # https://elixirforum.com/t/wsl-mix-deps-get-the-application-crypto-could-not-be-found/57916/7
  # libssl-dev needed for erlang?
  packages="build-essential libreadline-dev unzip curl wget gcc tmux fzf tree libssl-dev"
  echo_in_magenta "Running 'sudo apt install $packages -y'"
  eval "sudo apt install $packages -y"
}

sudo_apt_update() {
  echo_in_magenta "Running sudo apt update"
  sudo apt update
}

add_bashrc_additions() {
  bashrc_line="source $SCRIPT_DIR/bashrc_additions"
  echo_in_magenta "bashrc additions - checking"
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

install_zoxide() {
  echo_in_magenta "zoxide - checking"
  which zoxide >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "zoxide - already installed"
    zoxide --version
  else
    echo_in_magenta "zoxide - installing.."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
}

install_asdf() {
  echo_in_magenta "asdf - checking"
  which asdf >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "asdf - already installed"
    asdf --version
  else
    echo_in_magenta "asdf - installing.."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  fi
}

install_asdf_plugins() {
  echo_in_magenta "asdf plugins - checking"

  need_plugins=false

  plugins=$(asdf plugin list)
  [[ ! -n $(echo $plugins | grep "erlang") ]] && need_plugins=true
  [[ ! -n $(echo $plugins | grep "elixir") ]] && need_plugins=true

  if [[ "$need_plugins" = "false" ]]; then
    echo_in_green "asdf plugins - already installed"
  else
    echo_in_magenta "asdf plugins - installing.."
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
    if [[ $? -eq 0 ]]; then
      echo_in_green "asdf plugins - install successful"
    else
      echo_in_red "asdf plugins - install failed"
      exit 1
    fi
  fi
}

configure_asdf() {
  echo_in_magenta "asdf tool-versions symlink - checking"
  if [ -d ~/src/dev_setup ]; then
    dest=$(realpath ~/src/dev_setup/fatboi/.tool-versions)
    link=$(readlink ~/.tool-versions 2>&1)
    if [ $? -eq 0 ]; then
      if [ "$link" = "$dest" ]; then
        echo_in_green "asdf tool-versions symlink - already in place!"
      else
        echo_in_red "asdf tool-versions symlink - broken!"
        exit 1
      fi
    else
      ln -sf ~/src/dev_setup/fatboi/.tool-versions ~/.tool-versions
      if [ $? -eq 0 ]; then
        echo_in_green "asdf tool-versions symlink - created successfully!"
      else
        echo_in_red "asdf tool-versions symlink - creation failed!"
        exit 1
      fi
    fi
  else
    echo_in_red "asdf tool-versions symlink - ~/src/dev_setup does not exist, so bailing"
    exit 1
  fi
}

install_asdf_packages() {
  echo_in_magenta "Running asdf install"
  asdf install
}

install_mob() {
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

install_polyglot_watcher() {
  echo_in_magenta "polyglot_watcher_v2 - checking"
  which polyglot_watcher_v2 >/dev/null
  if [[ $? -eq 0 ]]; then
    echo_in_green "polyglot_watcher_v2 - already in place!"
  else
    echo_in_magenta "polyglot_watcher_v2 - git cloning..."
    git clone git@github.com:mbernerslee/polyglot_watcher_v2.git ~/src/polyglot_watcher_v2
    if [ $? -eq 0 ]; then
      echo_in_magenta "polyglot_watcher_v2 - installing..."
      cd ~/src/polyglot_watcher_v2
      ./install
      if [ $? -eq 0 ]; then
        echo_in_green "polyglot_watcher_v2 - installed successfully!"
      else
        echo_in_red "polyglot_watcher_v2 - install failed"
      fi
    else
      echo_in_red "polyglot_watcher_v2 - failed"
    fi
  fi
}

# https://dev.to/ahmedmusallam/how-to-autocomplete-ssh-hosts-1hob
setup_ssh_bash_autocomplete() {
  echo_in_magenta "ssh autocomplete - checking"

  path=/etc/bash_completion.d/ssh

  dest=$(realpath ~/src/dev_setup/fatboi/ssh_bash_autocomplete)
  link=$(readlink $path 2>&1)

  if [ $? -eq 0 ] && [ "$link" = "$dest" ]; then
    echo_in_green "ssh autocomplete - already in place!"
  else
    echo_in_magenta "ssh autocomplete - setting up..."
    sudo ln -sf $dest $path

    if [ $? -eq 0 ]; then
      echo_in_green "ssh autocomplete - setup complete!"
    else
      echo_in_red "ssh autocomplete - setup failed"
    fi
  fi
}

sudo_apt_update
sudo_apt_install_packages
install_nerdfont
install_ripgrep
install_neovim
install_zoxide
install_asdf
install_asdf_plugins
configure_asdf
install_asdf_packages
configure_neovim
configure_tmux
add_bashrc_additions
install_mob
install_polyglot_watcher
etup_ssh_bash_autocomplete
