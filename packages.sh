#!/bin/bash

DIR=$(dirname $0)

source $DIR/util.sh

sudo -v

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

function install_git() {
  next "install git"
  install git
  check_installation git
}

function install_zsh() {
  next "install zsh, zinit and p10k"
  install zsh curl
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  check_installation zsh
}

function install_vim() {
  next "install vim"
  install vim
  check_installation vim
}

function install_nvm() {
  next "install nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  export NVM_DIR="$HOME/.nvm" 
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  check_installation nvm
}

function install_rvm() {
  next "install rvm"
  install software-properties-common
  sudo apt-add-repository -y ppa:rael-gc/rvm
  sudo apt update && install rvm
  warn "reboot or logout to finish the installation of rvm"
}

function install_node() {
  next "install node (lts)"
  nvm install node --lts
  check_installation node
}

function install_yarn() {
  next "install yarn v1"
  nvm use node
  npm install -g yarn
  check_installation yarn
}

function install_pip3() {
  next "install pip3"
  install python3-pip python-software-properties
  check_installation pip3
}

function install_docker() {
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
}

function install_dockercompose() {
  next "install docker-compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  check_installation docker-compose
}

function install_asdf() {
  next "install asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
  echo ". $HOME/.asdf/asdf.sh" | sudo tee -a ~/.zshrc
} 
