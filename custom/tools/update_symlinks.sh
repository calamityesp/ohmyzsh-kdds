#!/usr/bin/env bash

######################################
# GLOBAL
######################################
ZSH="$HOME/.oh-my-zsh-kdds"

######################################
# Collecting the Symbolic links 
######################################
base=()
for dir in $HOME/* ;do
  if [[ -L $dir ]];then
    if [[ "$(readlink "$dir")" == $ZSH/* ]]; then
      base+="$(basename $dir) "
      rm $dir
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
for dir in $ZSH/Dotfiles/*; do 
  stow -d "$ZSH/Dotfiles" -t "$HOME" "$(basename $dir)"
done
