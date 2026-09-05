#!/bin/bash
# Cross-distro GUI app installer. Assumes flatpak + the flathub remote are
# already set up (each distro's setup script handles that bit itself).

source $(pwd)/scripts/util.sh

next "Adding Flathub remote (if needed)"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

next "Installing GUI apps"
mapfile -t apps < <(read_package_list "$(pwd)/scripts/apps.flatpak")
flatpak install -y flathub "${apps[@]}"

next "Checking apps installed"
installed_apps=$(flatpak list --app)
for app in "${apps[@]}"; do
  if grep -q "$app" <<< "$installed_apps"; then
    check "$app installed"
  else
    error "Unable to install $app"
  fi
done
