# History
HISTFILE=~/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000

plugins=(git)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Add exports, aliases and functions from dotfiles
readonly DOTFILES="$HOME/.dotfiles/general"

for file in $DOTFILES/.{exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file
