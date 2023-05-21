#!/bin/bash
source $PWD/scripts/util.sh

function update_all() {
  next "update packages"
  sudo apt update
  sudo apt list --upgradable
  sudo apt upgrade -y
  sudo apt --purge autoremove
  check "Your system is up-to-date"
}

# Update system upfront
update_all

# Install selected packages
python3 $PWD/install_packages.py

check "Your system is successfully configured :)"
