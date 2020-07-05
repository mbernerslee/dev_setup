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

function configure_gnome {
  GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`
  gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/

  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ default-show-menubar true
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy never
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications []

  #gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings

  gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name
  gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command
  gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding

  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ name 'Terminal'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ command 'gnome-terminal'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ binding '<Super>t'
  gsettings unset org.gnome.settings-daemon.plugins.media-keys custom-keybindings

#  custom_keybindings=('Terminal' 'gnome-terminal' '<Super>t' 'Terminal2' 'gnome-terminal' '<Super>n')
#  new_custom_keybindings_list=()
#  i=0
#  j=0
#  while [ $i -lt ${#custom_keybindings[@]} ]
#  do
#    echo $i
#    echo $j
#  echo ${new_custom_keybindings_list[@]}
#  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ name ${custom_keybindings[$i]}
#  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ command ${custom_keybindings[$i+1]}
#  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/ binding ${custom_keybindings[$i+2]}
#  new_custom_keybindings_list=( "${new_custom_keybindings_list[@]}" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$j/")
#  i=$(( $i + 3 ))
#  j=$(( $j + 1 ))
#  done
#
#  echo $new_custom_keybindings_list

  #gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name
  #gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command
  #gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding

  #gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy
  #gsettings range org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy
  #gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy never
}

function custom_keybindings {
  ('Terminal', 'gnome-terminal', '<Super>t')
}

sudo echo "a prompt for sudo" >/dev/null
run_action install_chrome
run_action install_spotify
run_action install_zoom
run_action configure_gnome
