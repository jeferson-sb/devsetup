#!/bin/bash
source $PWD/scripts/util.sh

function update_all() {
  next "update packages"
  sudo pacman -Syuu
  check "Your system is up-to-date"
}

# Essentials
sudo pacman -S --needed base-devel rust libffi libyaml openssl zlib

# System update
update_all

# Install selected packages
python3 $PWD/scripts/install_packages.py

check "Your system is successfully configured :)"
