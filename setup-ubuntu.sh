#!/bin/bash

DIR=$(dirname $0)
DISTRO="ubuntu-20.04"

source $DIR/util.sh

sudo -v 

# update software
next "update packages"
sudo apt update
sudo apt list --upgradable
sudo apt upgrade -y
sudo apt --purge autoremove
check "${DISTRO} is up-to-date"

# git
next "install git"
install git
check_installation git

# shell
next "install vim, zsh and zinit"
install vim zsh curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
check_installation zsh

# create dotfiles
next "install dotfiles"
./install-dotfiles.sh
check "dotfiles installed"

# version managers

# nvm
next "install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$HOME/.nvm" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
check_installation nvm

# rvm
next "install rvm"
install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt update && install rvm
warn "reboot or logout to finish the installation of rvm"

next "install node"
nvm install node --lts
check_installation node

# docker
read -p "Do you want to install docker? (y/n) " answer
if [ $answer != "${answer#[Yy]}" ]; then
  next "install docker"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  install apt-transport-https ca-certificates gnupg-agent software-properties-common 
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt-get update
  apt-cache policy docker-ce
  install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker "$USER"
  check_installation docker
fi

# docker-compose
next "install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
check_installation docker-compose

# pip
next "install pip3"
install python3-pip python-software-properties
check_installation pip3

# yarn
next "install yarn v1"
nvm use node
npm install -g yarn
check_installation yarn