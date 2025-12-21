#!/usr/bin/env bash

Dotfiles="$HOME/.oh-my-zsh-kdds/Dotfiles"
git -C $Dotfiles pull
git -C $Dotfiles submodule update --remote
git -C $HOME/.oh-my-zsh-kdds/ submodule update --remote
for dir in $Dotfiles/*; do 
  base=$(basename $dir)
  stow -d $Dotfiles -t ~ $base
done
