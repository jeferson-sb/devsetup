#!/bin/bash

DIR=$(dirname $0)
DISTRO="ubuntu-20.04"

source $DIR/install_packages.sh

# Update system
update_all

# Install selected packages from whiptail checklist
./install_packages.sh

# Dotfiles
read -p "Do you want to install all of the dotfiles? (y/n) " answer
if [ $answer != "${answer#[Yy]}" ]; then
  next "install dotfiles"
  ./install_dotfiles.sh
  check "dotfiles installed"
fi

check "$DISTRO is configured :)"