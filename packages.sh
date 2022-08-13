#!/bin/bash

sudo -v

function install_git() {
  next "install git"
  install git
  check_installation git
}

function install_zsh() {
  next "install zsh, zinit and p10k"
  install zsh curl
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  check_installation zsh
}

function install_vim() {
  next "install vim"
  install vim
  check_installation vim
}

function install_neovim() {
  next "install neovim"
  install neovim
  check_installation nvim
}

function install_lunarvim() {
  next "install lunar vim"
  warn "prerequisites: you need to have neovim >= 0.7"
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
  check_installation lvim
}

function install_nvm() {
  next "install nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
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
  nvm install --lts
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

function install_commandline_utils() {
  next "install curl, exa, bat, tldr"
  install curl exa bat tlrd
  for command in curl exa bat tlrd; do check_installation $command; done
}

function install_docker_apt() {
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

function install_dockercompose_curl() {
  next "install docker-compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  check_installation docker-compose
}

function install_docker_others() {
  next "install docker and docker-compose"
  install docker docker-compose
  sudo systemctl start docker.service
  sudo systemctl enable docker.service
  sudo groupadd docker
  sudo usermod -aG docker $(whoami)
  check_installation docker
  check_installation docker-compose
}

function install_asdf_git() {
  next "install asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
  echo ". $HOME/.asdf/asdf.sh" | sudo tee -a ~/.zshrc
} 

function install_asdf_pacman() {
  next "install asdf"
  git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
  echo ". /opt/asdf-vm/asdf.sh" | sudo tee -a ~/.zshrc
}
