#!/bin/bash 

source $(pwd)/scripts/util.sh

next "installing work/personal apps and tools..."

sudo -v

next "Updating system..."
sudo pacman -Syuu --noconfirm
sudo pacman -S --needed base-devel git libffi libyaml openssl zlib pamac-aur

next "Package managers - yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

next "Package managers - Snap"
sudo pacman -S snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

next "Package managers - Flatpak"
pamac install flatpak libpamac-flatpak-plugin

next "Slack"
flatpak install flathub com.slack.Slack

next "Postman"
yay -S postman-bin --noconfirm

next "VScode"
yay -S visual-studio-code-bin --noconfirm

# next "Android Studio"
# yay -S android-studio --noconfirm

next "Java JDK"
sudo pacman -S jdk11-openjdk --noconfirm

next "Spotify"
flatpak install spotify

next "Edge"
pamac install microsoft-edge-stable-bin

next "Chrome"
pamac build google-chrome

next "Github cli"
sudo pacman -S github-cli --noconfirm
warn "Need to run gh login to authenticate"

next "Checking apps installed"
APPS="slack postman code spotify google-chrome microsoft-edge-stable-bin"
for app in $APPS
do
  check_installation "$app"
done