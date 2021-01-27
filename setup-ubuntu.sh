#!/bin/bash

DIR=$(dirname $0)
DISTRO="ubuntu-20.04"

SOFTWARES=(
  code
)

source $DIR/util.sh

sudo -v 

# update software
next "update packages"
sudo apt update \
sudo apt list --upgradable \
sudo apt upgrade -y \
sudo apt --purge autoremove
check "${DISTRO} is up-to-date"

# shell
next "install zsh and zinit"
install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
check "zsh installed"

# version managers

# nvm
next "install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
check "nvm installed"

# rvm
next "install rvm"
install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt update && install rvm
check "rvm installed"

# docker
next "install docker and docker-compose"
sudo apt-get remove docker docker-engine docker.io containerd runc
install docker.io
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

check "docker & docker-compose installed"

# pip
next "install pip3"
install \
  python3-pip \
  python-software-properties \
  > /dev/null
check "pip installed"

# create dotfiles
next "install dotfiles"
./install-dotfiles.sh
check "dotfiles installed"