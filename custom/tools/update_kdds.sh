#!/usr/bin/env zsh

export ZSH="$HOME/.oh-my-zsh-kdds"
export DOTFILES="$ZSH/Dotfiles"

##################################################
#  SECTION: CHECKS
##################################################
if [[ -z $KDDS_PROFILE ]]; then
  printf "Error: .zshrc profile not set. Set and rerun\n"
  exit 1
fi

##################################################
#  SECTION: UPDATE ZSH DIR AND SUBMODULES
##################################################
git -C "$ZSH" pull
git -C $ZSH submodule update --init --recursive

##################################################
#  SECTION: RESETTING SYMLINKS
##################################################
./update_symlinks.sh

##################################################
#  SECTION: SOURCE ZSHRC
##################################################
. $HOME/.zshrc
