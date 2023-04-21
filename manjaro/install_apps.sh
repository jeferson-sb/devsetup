#!/bin/bash 
source $PWD/util.sh

sudo -v

next "Updating system..."
sudo pacman -Syuu

sudo pacman -S -needed git base-devel
next "Package managers - yay, snap, etc"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo pacman -S snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

next "Slack"
sudo snap install slack
check "Slack installed"

next "Postman"
sudo yay -S postman-bin
check "Postman installed"

next "VScode"
yay -S visual-studio-code-bin

next "Android Studio"
yay -S android-studio

next "Java JDK"
sudo pacman -S jdk11-openjdk

next "Spotify"
yay -S spotify

next "Edge"
yay -S microsoft-edge-stable

next "Chrome"
pamac build google-chrome

next "Github cli"
sudo pacman -S github-cli
warn "Need to run gh login to authenticate"

# exa, bat, fd-find, du-dust, tldr, neovim, fzf, neofetch

