#! /bin/bash

. ./beautifier

function install_chrome {
  dpkg -l | grep "google-chrome-stable"
  if [[ $? == 0 ]]; then
    echo "chrome already installed"
  else
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
  fi
}

function install_spotify {
  dpkg -l | grep "spotify-client"
  if [[ $? == 0 ]]; then
    echo "spotify already installed"
  else
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt-get install spotify-client -y
  fi
}

function install_zoom {
  dpkg -l | grep "zoom"
  if [[ $? == 0 ]]; then
    echo "zoom already installed"
  else
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install ./zoom_amd64.deb -y
    rm zoom_amd64.deb
  fi
}

function install_dconf_editor {
  sudo apt install dconf-editor -y
}

function install_slack {
  dpkg -l | grep "slack-desktop"
  if [[ $? == 0 ]]; then
    echo "slack already installed"
  else
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb
    sudo apt install ./slack-desktop-4.4.3-amd64.deb
    rm slack-desktop-4.4.3-amd64.deb
  fi
}

function install_discord {
  dpkg -l | grep "discord"
  if [[ $? == 0 ]]; then
    echo "discord is already installed"
  else
    wget https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb
    sudo apt install ./discord-0.0.10.deb -y
    rm discord-0.0.10.deb
  fi
}
function install_steam {
  dpkg -l | grep "steam-devices"
  if [[ $? == 0 ]]; then
    echo "steam is already installed"
  else
    echo "deb http://deb.debian.org/debian/ buster main contrib non-free" | sudo tee -a /etc/apt/sources.list
    sudo apt update
    sudo apt install steam -y
  fi
}

function configure_gnome {
  #https://askubuntu.com/questions/597395/how-to-set-custom-keyboard-shortcuts-from-terminal
  GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`
  #gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/
  #gsettings get org.gnome.Terminal.ProfilesList default
  #TODO set keyboard layout to UK
  #TODO make Ctrl = zoom in on a terminal (or everywhere?)

  gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy never
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ audible-bell false
  gsettings set org.gnome.desktop.wm.keybindings switch-applications []
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
  dconf write /org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/use-theme-colors false

  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'

  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>t'
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
}

sudo echo "a prompt for sudo" >/dev/null
run_action install_chrome
run_action install_spotify
run_action install_zoom
run_action install_dconf_editor
run_action configure_gnome
run_action install_slack
run_action install_discord
run_action install_steam
