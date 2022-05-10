#!/bin/bash
source $PWD/util.sh
source $PWD/install_packages.sh

function update_all() {
  next "update packages"
  sudo apt update
  sudo apt list --upgradable
  sudo apt upgrade -y
  sudo apt --purge autoremove
  check "Your system is up-to-date"
}

function install() {
  if ! command -v "$1" &> /dev/null ;then
    sudo apt-get install "$1" -y > /dev/null
  else 
    check "$1 is installed"
  fi
}

# Update system upfront
update_all

# Install selected packages from whiptail checklist
install_chosen_packages

# Dotfiles
read -p "Do you want to install all of the dotfiles? (y/n) " answer
if [ $answer != "${answer#[Yy]}" ]; then
  next "install dotfiles"
  ./install_dotfiles.sh
  check "dotfiles installed"
fi

check "Your system is successfully configured :)"
