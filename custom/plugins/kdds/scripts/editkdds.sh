#!/usr/bin/env bash

###############################
# Script: editkdds.sh
# Purpose: script to check for and allow you to edit your kdds
###############################

set -euo pipefail

# ---------- globals ----------
kddsdir="$HOME/Repos/ohmyzsh-kdds/custom/plugins/kdds/kdds.plugin.zsh"

# ---------- checks ----------
if [[ -d "$kddsdir" ]]; then
  nvim $kddsdir
else
  echo "TODO: Add a clone function to clone the repo in the repo. If this is runnign then you have zsh installed and oh my kdds running"
  exit 1
fi
