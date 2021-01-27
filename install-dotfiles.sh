#!/bin/bash

DIR=$(dirname $0)

source $DIR/util.sh

readonly DOTS="$HOME/.dotfiles"

sudo -v

next "copy .gitconfig and .gitmessage"
ln -s "$DOTS/git/.gitconfig" ~/.gitconfig
ln -n "$DOTS/git/.gitmessage" ~/.gitmessage
check "git configured"

next "copy .vimrc"
ln -s "$DOTS/vim/.vimrc" ~/.vimrc
check "vim configured"

next "copy .zshrc"
ln -s "$DOTS/zsh/.zshrc" ~/.zshrc
check ".zshrc configured"

next "copy .aliases"
ln -s "$DOTS/general/.aliases" ~/.aliases
check ".aliases configured"