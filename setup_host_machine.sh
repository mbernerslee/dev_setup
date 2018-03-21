#! /bin/bash

function clone_dev_setup {
 if [ ! -d "~/src" ]; then
   mkdir ~/src
 fi
 cd ~/src
 git clone https://github.com/mbernerslee/dev_setup.git
 cd -
}

function configure_bashrc {
 source_bashrc_additions="source ~/src/dev_setup/bashrc_host_additions"
 if [ `grep -c "$source_bashrc_additions" ~/.bashrc` -eq 0 ]; then 
   echo "$source_bashrc_additions" >> ~/.bashrc
 fi
}

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

sudo apt-get update
sudo apt-get install google-chrome-stable virtualbox-5.2 sublime-text spotify-client git -y
sudo apt-get install openssh-server -y
clone_dev_setup
configure_bashrc

name='robobuddy'
os='debian_64'
sizeDisk=102400
isoDir='~/isos/'
createPath='~/virtualbox/'
isoPath=$isoDir/debian-9.4.0-amd64-netinst.iso
if [ ! -f $isoPath ]; then
  wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.4.0-amd64-netinst.iso -P $isoDir -nc    
fi

if ! VBoxManage list -l hostonlyifs | grep vboxnet0
then
  VBoxManage hostonlyif create
fi

VBoxManage createhd --filename $createPath$name'/'$name.vdi --size $sizeDisk
VBoxManage createvm --basefolder $createPath --name $name --ostype $os --register
VBoxManage storagectl $name --name "IDE Controller" --add ide
VBoxManage storageattach $name --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $isoPath
VBoxManage storagectl $name --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $name --storagectl "SATA Controller" --port 0  --device 0 --type hdd --medium $createPath$name'/'$name.vdi
VBoxManage modifyvm $name --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $name --memory 4096 --vram 32
VBoxManage modifyvm $name --nic1 bridged --bridgeadapter1 wlp4s0 
#VBoxManage modifyvm $name --nic2 hostonly --hostonlyadapter1 vboxnet0
#VBoxHeadless -s $name

# Manually set up host only adapter in virtualbox

# Manually set up password-less ssh