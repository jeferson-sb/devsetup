#!/bin/bash

DIR=$(dirname $0)
readonly REPO_ROOT="$(cd "$DIR/.." && pwd)"

source $DIR/util.sh

readonly DOTS="$HOME/.dotfiles"

# Symlink $1 to $2, backing up whatever is already at $2 unless it's already
# the symlink we want (so reruns are idempotent and don't churn a .old file).
symlink_file() {
  local source="$1" target="$2"

  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$target.old"
  fi

  if [[ -L "$target" ]]; then
    return
  fi

  ln -s "$source" "$target"
}

[[ ! -d "${DOTS}" ]] && cp -r "$REPO_ROOT/.dotfiles" $HOME

sudo -v

# Install all dotfiles under .dotfiles to the home directory
for DOTFILE in $(find -H $DOTS -maxdepth 2 -type f)
do
  filename=$(basename "${DOTFILE}")
  next "copy $filename"

  if [[ $DOTFILE =~ "windows" ]]; then
    continue
  fi

  symlink_file "$DOTFILE" "$HOME/$filename"

  check "$filename configured"
done

# Symlink files under .config into ~/.config, preserving their relative path.
# Unlike .dotfiles, ~/.config is a shared system directory holding many
# unrelated apps' configs, so we place only the specific files this repo
# owns instead of copying/symlinking the whole tree.
for CONFIG_FILE in $(find -H "$REPO_ROOT/.config" -type f)
do
  rel="${CONFIG_FILE#$REPO_ROOT/.config/}"
  target="$HOME/.config/$rel"
  next "copy $rel"

  mkdir -p "$(dirname "$target")"
  symlink_file "$CONFIG_FILE" "$target"

  check "$rel configured"
done

# Copy vim theme
[[ ! -d "$HOME/.vim" ]] && cp -r "$REPO_ROOT/.vim" $HOME

check "Configuration done. You might need to restart your terminal to finish the installation"
