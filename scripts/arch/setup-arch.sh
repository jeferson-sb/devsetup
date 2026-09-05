#!/bin/bash
source $PWD/scripts/util.sh

function update_all() {
  next "update packages"
  sudo pacman -Syuu --noconfirm
  check "Your system is up-to-date"
}

# Essentials
next "install base packages"
mapfile -t base_packages < <(read_package_list "$PWD/scripts/arch/base.packages")
sudo pacman -S --needed --noconfirm "${base_packages[@]}"
check "Base packages installed"

# System update
update_all

# Pre-requisites (python env)
python3 -m venv env
source env/bin/activate
pip3 install beaupy

# Install selected packages
python3 $PWD/scripts/install_packages.py

check "Your system is successfully configured :)"

deactivate
