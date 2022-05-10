#!/bin/bash
source $PWD/util.sh
source $PWD/install_packages.sh

function update_all() {
  next "update packages"
  sudo pacman -Syuu
  check "Your system is up-to-date"
}

function install() {
  if ! command -v "$1" &> /dev/null ;then
    sudo pacman -S "$1" > /dev/null
  else 
    check "$1 is installed"
  fi
}

# System update
update_all

install_chosen_packages

check "Your system is successfully configured :)"
