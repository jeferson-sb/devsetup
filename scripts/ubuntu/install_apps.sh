#!/bin/bash

source $(pwd)/scripts/util.sh

next "Flatpak"
sudo apt update
sudo apt install -y flatpak

$(pwd)/scripts/install_apps.sh
