#! /usr/bin/env zsh
####################################################
# Plugin: clone-kdds-repos.sh
#
# Purpose:
#   Got tired of having to clone my repos.. this will clone them all to the Repos Directory
#
# Assumptions:
#   - We have a Repos folder already
#   - we have git installed
#   - we have ssh priv
#
# Safe to re-run:
#   Yes | No
####################################################

####################################################
# Functions
####################################################
clone () {

  if [[ ! -d "~/Repos/$1" ]]; then
    printf "Cloning %s ...\n" "$1"
  fi
}

####################################################
# Main
####################################################
if ! command -v git &>/dev/null; then 
  echo "ERROR: Got not installed.. Install git and rerun script"
  exit 1
fi

# Check for repo directory
if [[ $(readlink $HOME/Booty) ]]; then
  read -p "Oh my bash link not present, proceed anyway?" install
  if [[ "y" == $install ]]; then
    echo "Proceding...... "
    sleep 2
  else
    echo "Exiting Program"
    exit 1
  fi
fi

# Clone ohmyzsh
clone "Booty"
