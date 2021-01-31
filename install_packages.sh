#!/bin/bash

DIR=$(dirname $0)

source $DIR/packages.sh

CHOICES=$(whiptail --title "Softwares" --checklist \
"Please select which packages you want to install:" 20 78 12 \
"git" "" ON \
"vim" "" ON \
"asdf" "Manage multiple runtime versions" ON \
"nvm" "Node Version Manager" ON \
"rvm" "Ruby Version Manager" OFF \
"node" "" ON \
"yarn" "" ON \
"pip3" "" OFF \
"docker" "" OFF \
"docker-compose" "" OFF \
"zsh" "This will install zsh, oh-my-zsh, p10k & zinit" ON \
3>&1 1>&2 2>&3)

for CHOICE in ${CHOICES[@]}; do
  [[ $CHOICE =~ "git" ]] && install_git
  [[ $CHOICE =~ "vim" ]] && install_vim
  [[ $CHOICE =~ "asdf" ]] && install_asdf
  [[ $CHOICE =~ "nvm" ]] && install_nvm
  [[ $CHOICE =~ "rvm" ]] && install_rvm
  [[ $CHOICE =~ "node" ]] && install_node
  [[ $CHOICE =~ "yarn" ]] && install_yarn
  [[ $CHOICE =~ "pip3" ]] && install_pip3
  [[ $CHOICE =~ "docker" ]] && install_docker
  [[ $CHOICE =~ "docker-compose" ]] && install_dockercompose
  [[ $CHOICE =~ "zsh" ]] && install_zsh
done
