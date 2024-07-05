#!/bin/bash

######################
# important
######################
# before you run this, make sure you've set up ssh server on the machine, and add a public key to ~/.ssh/authorized_keys
# make sure passwordless ssh is working from a client machine, 
# otherwise running this script will cause you to lose all access to the machine because ssh with password will be banned!
######################

systemd_logind_restart_required=false
ssh_restart_required=false

add_to_sudoers() {
  /usr/sbin/adduser berners sudo
}

install_git() {
  apt install git -y
}

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

set_ignore_laptop_lid_switch() {
  add_line_if_missing HandleLidSwitch=ignore /etc/systemd/logind.conf systemd_logind_restart_required
  add_line_if_missing HandleLidSwitchExternalPower=ignore /etc/systemd/logind.conf systemd_logind_restart_required

  if [[ $systemd_logind_restart_required = "true" ]]; then
    echo "Restarting systemd-logind"
    systemctl restart systemd-logind

    if [[ $? -eq 0 ]]; then
      echo "Successful!"
    else
      echo "Failed"
      exit 1
    fi
  else
    echo "No systemd-logind restart required"
  fi
}

set_autosleep_off() {
  echo "Turning off auto sleep"
  systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
  if [[ $? -eq 0 ]]; then
    echo "Successful!"
  else
    echo "Failed!"
    exit 1
  fi

  # turned off auto sleep etc
  ## systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
  ## check status with
  ## systemctl status sleep.target suspend.target hibernate.target hybrid-sleep.target
}

configure_ssh() {
# https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/
# https://webdock.io/en/docs/how-guides/security-guides/ssh-security-configuration-settings

  add_line_if_missing "PasswordAuthentication no" /etc/ssh/sshd_config ssh_restart_required
  add_line_if_missing "PermitRootLogin no" /etc/ssh/sshd_config ssh_restart_required

  if [[ $ssh_restart_required = "true" ]]; then
    echo "Restarting ssh"
    systemctl restart systemd-logind

    if [[ $? -eq 0 ]]; then
      echo "Successful!"
    else
      echo "Failed"
      exit 1
    fi
  else
    echo "No systemd-logind restart required"
  fi
}

set_ignore_laptop_lid_switch
set_autosleep_off
configure_ssh
add_to_sudoers
install_git

echo "All good!"
