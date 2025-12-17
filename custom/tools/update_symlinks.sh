#!/usr/bin/env bash

######################################
# GLOBAL
######################################
ZSH="$HOME/.oh-my-kdds-zsh"

######################################
# Collecting the Symbolic links 
######################################
base=()
for dir in $HOME/* ;do
  if [[ -L $dir ]];then
    if [[ "$(readlink "$dir")" == $ZSH/* ]]; then
      base+="$(basename $dir) "
    fi
  fi
done

######################################
# Relink the Additional Directories
######################################
for dir in ${base[@]}; do
  ln -sf $ZSH/$dir $HOME/$dir
done

######################################
# Run Stow in Dotfiles
######################################

