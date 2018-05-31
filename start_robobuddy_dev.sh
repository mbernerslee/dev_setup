#! /bin/bash

vboxmanage startvm robobuddy --type headless
done=0
echo "Waiting for robobuddy to reply to pings"
while [ $done -ne 1 ]; do
  ping -c 1 robobuddy &>/dev/null
  if [ $? -eq 0 ]; then
    let done=1
    printf "robobuddy replied!"
  else
    printf "%c" "."
  fi
done
sleep 5
ssh berners@robobuddy -X -t 'cd ~/src/platform_v2; tmux; bash'
#VBoxManage controlvm robobuddy acpipowerbutton
