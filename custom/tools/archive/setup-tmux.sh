#!/usr/bin/env zsh
###########################################
# Script: bootstrap.sh
# Purpose: Initial environment bootstrap
###########################################

set -euo pipefail

# ---------- main ----------
printf "Cloning tmux-power...\n"
git -C $ZSH/Repos/ clone git@github.com:wfxr/tmux-power.git
source ~/.tmux.conf
