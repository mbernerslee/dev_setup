#!/bin/bash

######################
# important
######################
# before you run this, make sure you've set up ssh server on the machine, and add a public key to ~/.ssh/authorized_keys
# make sure passwordless ssh is working from a client machine,
# otherwise running this script will cause you to lose all access to the machine because ssh with password will be banned!
######################

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/coloured_echos.sh"

systemd_logind_restart_required=false
ssh_restart_required=false

add_to_sudoers() {
  add_to_sudoers_command="/usr/sbin/adduser berners sudo"
  echo_in_magenta "Running $add_to_sudoers_command"
  eval $add_to_sudoers_command

  if [[ $? -eq 0 ]]; then
    echo_in_green "$add_to_sudoers_command successful"
  else
    echo_in_ren "$add_to_sudoers_command failed"
  fi
}

install_git() {
  install_git_command="apt install git -y"
  echo_in_magenta "Running $install_git_command"
  eval $install_git_command

  if [[ $? -eq 0 ]]; then
    echo_in_green "$install_git_command succeeded"
  else
    echo_in_red "$install_git_command failed"
    exit 1
  fi
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
  echo_in_magenta "laplop lid action - checking if config change required"
  add_line_if_missing HandleLidSwitch=ignore /etc/systemd/logind.conf systemd_logind_restart_required
  add_line_if_missing HandleLidSwitchExternalPower=ignore /etc/systemd/logind.conf systemd_logind_restart_required

  if [[ $systemd_logind_restart_required = "true" ]]; then
    echo_in_magenta "laplop lid action - Restarting systemd-logind"
    systemctl restart systemd-logind

    if [[ $? -eq 0 ]]; then
      echo_in_green "laplop lid action - systemd-logind restart successful"
    else
      echo_in_ren "laplop lid action - systemd-logind restart failed"
    fi
  else
    echo_in_green "laplop lid action - already set ok"
  fi
}

set_autosleep_off() {
  echo_in_magenta "auto sleep - Turning off auto sleep"
  systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
  if [[ $? -eq 0 ]]; then
    echo_in_green "auto sleep - Turned off successfully"
  else
    echo_in_red "auto sleep - Turn off failed"
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

  echo_in_magenta "SSH config - checking if configured"

  add_line_if_missing "PasswordAuthentication no" /etc/ssh/sshd_config ssh_restart_required
  add_line_if_missing "PermitRootLogin no" /etc/ssh/sshd_config ssh_restart_required

  if [[ $ssh_restart_required = "true" ]]; then
    echo_in_magenta "SSH config - changes made, restarting SSH.."
    systemctl restart systemd-logind

    if [[ $? -eq 0 ]]; then
      echo_in_green "SSH config - SSH restart successful"
    else
      echo_in_green "SSH config - SSH restart failed"
      exit 1
    fi
  else
    echo_in_green "SSH config - already configured"
  fi
}

set_ignore_laptop_lid_switch
set_autosleep_off
configure_ssh
add_to_sudoers
install_git

echo_in_green "All good!"
