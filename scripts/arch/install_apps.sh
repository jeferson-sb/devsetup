#!/bin/bash

source $(pwd)/scripts/util.sh

next "installing work/personal apps and tools..."

sudo -v

next "Updating system..."
sudo pacman -Syuu --noconfirm

next "Flatpak"
sudo pacman -S --needed --noconfirm flatpak

$(pwd)/scripts/install_apps.sh

next "Java JDK"
sudo pacman -S jdk11-openjdk --noconfirm

next "Github cli"
sudo pacman -S github-cli --noconfirm
warn "Need to run gh login to authenticate"
