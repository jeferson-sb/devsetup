#!/bin/bash 

source $(pwd)/scripts/util.sh

next "installing personal apps..."

sudo -v

next "Updating system..."
sudo pacman -Syuu

next "Package managers - yay, snap, etc"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo pacman -S snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

next "Slack"
sudo snap install slack
check "Slack installed"

next "Postman"
yay -S postman-bin
check "Postman installed"

next "VScode"
yay -S visual-studio-code-bin

next "Android Studio"
yay -S android-studio

next "Java JDK"
sudo pacman -S jdk11-openjdk

next "Spotify"
flatpak install spotify
# pamac build spotify
# yay -S spotify

next "Edge"
yay -S microsoft-edge-stable

next "Chrome"
pamac build google-chrome

next "Github cli"
sudo pacman -S github-cli
warn "Need to run gh login to authenticate"
