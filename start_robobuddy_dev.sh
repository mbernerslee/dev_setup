#! /bin/bash

vboxmanage startvm robobuddy --type headless
done=0
echo "Waiting for robobuddy to awaken"
while [ $done -ne 1 ]; do
  ping -c 1 robobuddy &>/dev/null
  if [ $? -eq 0 ]; then
    let done=1
    printf "robobuddy is alive!\n"
  else
    printf "%c" "."
  fi
done
sleep 1
ssh berners@robobuddy
#VBoxManage controlvm robobuddy acpipowerbutton
