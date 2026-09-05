#!/bin/bash

source $(pwd)/scripts/util.sh

next "Flatpak"
sudo dnf install -y flatpak

$(pwd)/scripts/install_apps.sh
