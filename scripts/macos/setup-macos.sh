#!/bin/bash
source $PWD/scripts/util.sh

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Packages
brew install cocoapods
brew install gh
brew install powerlevel10k
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install gpg gawk
brew install coreutils curl git

# Xcode tools
xcode-select --install

check "Your system is ready!"
