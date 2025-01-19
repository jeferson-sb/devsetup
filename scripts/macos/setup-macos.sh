#!/bin/bash
source $PWD/scripts/util.sh

function install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Essentials
install_homebrew

# Update packages
next "update packages"
brew update
check "Your system is up-to-date"

# Essentials
brew install coreutils curl git
brew install gpg gawk

# Apps
brew install watchman
brew install cocoapods
brew install gh
brew install powerlevel10k
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install --cask google-chrome
brew install --cask iterm2

# Xcode
xcode-select --install

# Folders
mkdir projects && cd projects && mkdir personal oss work

check "Your system is ready!"