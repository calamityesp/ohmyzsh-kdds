#!/usr/bin/env zsh
###########################################
# Script: bootstrap.sh
# Purpose: Initial environment bootstrap
###########################################

set -euo pipefail

# ---------- globals ----------
# VARS ONLY

# ---------- functions ----------
# helper functions only

# ---------- checks ----------
# sudo / OS / prerequisites

# ---------- main ----------
printf "Cloning tmux-power...\n"
git $ZSH/Repos/ clone git@github.com:wfxr/tmux-power.git
source ~/.tmux.conf

# ---------- exit ----------
# final message / cleanup


