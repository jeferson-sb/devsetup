#!/bin/bash

readonly CLOSE="✘"
readonly CHECK="✔"
readonly WARNING="‼"
readonly NEXT="➡"

readonly RESET="\e[0m"
readonly RED="\e[0;31m"
readonly RED_BOLD="\e[1;31m"
readonly GREEN_BOLD="\e[1;32m"
readonly YELLOW_BOLD="\e[1;33m"
readonly BLUE_BOLD="\e[1;34m"

log() {
  printf "$1\n"
}

next() {
  log "${YELLOW_BOLD}${NEXT}${RESET} $1"
}

check() {
  log "${GREEN_BOLD}${CHECK}${RESET} $1"
}

error() {
  log "${RED_BOLD}${CLOSE}${RESET} $1"
}

warn() {
  log "${YELLOW_BOLD}${WARNING}${RESET} $1"
}

function check_installation() {
  if command -v "$1" &> /dev/null ;then
    check "$1 installed"
  else 
    error "Unable to install $1"
  fi
}