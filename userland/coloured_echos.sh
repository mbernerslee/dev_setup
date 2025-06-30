#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"
MAGENTA="\033[35m"

echo_in_magenta() {
  echo -e "${MAGENTA}$1${NOCOLOR}"
}

echo_in_green() {
  echo -e "${GREEN}$1${NOCOLOR}"
}

echo_in_red() {
  echo -e "${RED}$1${NOCOLOR}"
}
