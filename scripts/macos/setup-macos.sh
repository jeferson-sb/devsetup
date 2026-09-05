#!/bin/bash
source $PWD/scripts/util.sh

function install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_homebrew

# Update packages
next "update packages"
brew update
check "Your system is up-to-date"

# Essentials
next "install base packages"
mapfile -t base_formulae < <(grep -vE '^\s*(#|$)' "$PWD/scripts/macos/base.packages")
brew install "${base_formulae[@]}"

mapfile -t base_casks < <(grep -vE '^\s*(#|$)' "$PWD/scripts/macos/base-casks.packages")
brew install --cask "${base_casks[@]}"
check "Base packages installed"

# Xcode
xcode-select --install

# Folders
mkdir projects && cd projects && mkdir personal oss work

check "Your system is ready!"