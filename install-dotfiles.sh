#!/bin/bash

DIR=$(dirname $0)

source $DIR/util.sh

readonly DOTS="$HOME/.dotfiles"

[[ ! -d "${DOTS}" ]] && cp -r .dotfiles $HOME

sudo -v

# Install all dotfiles under .dotfiles to the home directory
for DOTFILE in $(find -H $DOTS -maxdepth 2 -type f)
do
  filename = $(basename "${DOTFILE}")
  next "copy $filename"
  ln -s $DOTFILE "~/$filename"
  check "$filename configured"
done
