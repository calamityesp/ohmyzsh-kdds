#!/usr/bin/env bash

export ZSH="$HOME/.oh-my-zsh-kdds"
export DOTFILES="$ZSH/Dotfiles"

##################################################
#  SECTION: SCRIPT SETUP
##################################################
#strict mode
set -euo pipefail

# Internal field seperator
IFS=$'\n\t'

##################################################
#  SECTION: UPDATE ZSH DIR AND SUBMODULES
##################################################
git -C "$ZSH" pull
git -C "$ZSH" submodule foreach "git pull"

##################################################
#  SECTION: UPDATE ZSH SUBMODULES
##################################################
git -C $ZSH submodule update --init --recursive
git -C $ZSH submodule update --remote

##################################################
#  SECTION: UPDATE DOTFILES
##################################################
git -C $DOTFILES submodule update --init --recursive
git -C $DOTFILES submodule update --remote

