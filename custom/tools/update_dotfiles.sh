#!/usr/bin/env bash

Dotfiles="$HOME/.oh-my-kdds-zsh/Dotfiles"

for dir in $Dotfiles/*; do 
  base=$(basename $dir)
  stow -d $Dotfiles -t ~ $base
done
