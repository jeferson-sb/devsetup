#!/bin/bash

source $PWD/packages.sh

function install_chosen_packages() {
  CHOICES=$(whiptail --title "Softwares" --checklist \
  "Please select which packages you want to install:" 20 78 12 \
  "git" "" ON \
  "vim" "" ON \
  "command-utils" "Commandline alternatives like bat, exa, tldr" ON \
  "asdf" "Manage multiple runtime versions" OFF \
  "asdf(pacman)" "Manage multiple runtime versions" OFF \
  "nvm" "Node Version Manager" ON \
  "rvm" "Ruby Version Manager" OFF \
  "node" "" ON \
  "yarn" "" OFF \
  "pip3" "" OFF \
  "docker+docker-compose (Ubuntu/Debian)" "" OFF \
  "docker+docker-compose (Arch)" "" OFF \
  "zsh" "This will install zsh, oh-my-zsh, p10k & zinit" OFF \
  3>&1 1>&2 2>&3)

  for CHOICE in ${CHOICES[@]}; do
    [[ $CHOICE =~ "git" ]] && install_git
    [[ $CHOICE =~ "vim" ]] && install_neovim && install_lunarvim
    [[ $CHOICE =~ "command-utils" ]] && install_commandline_utils
    [[ $CHOICE =~ "asdf" ]] && install_asdf_git
    [[ $CHOICE =~ "asdf(pacman)" ]] && install_asdf_pacman
    [[ $CHOICE =~ "nvm" ]] && install_nvm
    [[ $CHOICE =~ "rvm" ]] && install_rvm
    [[ $CHOICE =~ "node" ]] && install_node
    [[ $CHOICE =~ "yarn" ]] && install_yarn
    [[ $CHOICE =~ "pip3" ]] && install_pip3
    [[ $CHOICE =~ "docker+docker-compose (Ubuntu/Debian)" ]] && install_docker_apt && install_dockercompose_curl
    [[ $CHOICE =~ "docker+docker-compose (Arch)" ]] && install_docker_others
    [[ $CHOICE =~ "zsh" ]] && install_zsh
  done
}
