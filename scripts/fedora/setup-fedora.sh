#!/bin/bash
source $PWD/scripts/util.sh

function update_all() {
  next "update packages"
  dnf check-update
  dnf upgrade
  check "Your system is up-to-date"
}

# Essentials
# TBD

# System update
update_all
