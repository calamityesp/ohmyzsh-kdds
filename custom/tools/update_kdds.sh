#!/usr/bin/env bash

export ZSH="$HOME/.oh-my-kdds-zsh"
export DOTFILES="$ZSH/Dotfiles"

##################################################
#  SECTION: SCRIPT SETUP
##################################################
#strict mode
set -euo pipefail

# Internal field seperator
IFS=$'\n\t'

##################################################
#  SECTION: UPDATE ZSH DIR
##################################################
git -C "$ZSH" pull

##################################################
#  SECTION: UPDATE ZSH SUBMODULES
##################################################
git -C $ZSH submodule update --remote

##################################################
#  SECTION: UPDATE DOTFILES
##################################################
git -C $DOTFILES submodule update --remote

