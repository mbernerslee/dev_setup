#! /bin/bash

if [ ! -f "/etc/apt/sources.list.d/google.list" ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
fi

if [ ! -f "/etc/apt/sources.list.d/virtualbox.list" ]; then
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list.d/virtualbox.list'
fi


if [ ! -f "/etc/apt/sources.list.d/sublime-text.list" ]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi


if [ ! -f "/etc/apt/sources.list.d/spotify.list" ]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
fi
 
function configure_bashrc {
  source_bashrc_additions="source ~/src/dev_setup/bashrc_host_additions"
  if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then 
    echo "$source_bashrc_additions" >> ~/.bashrc
  fi
}

sudo apt-get update
sudo apt-get install google-chrome-stable virtualbox-5.2 sublime-text spotify-client git -y
sudo apt-get install openssh-server -y
configure_bashrc
