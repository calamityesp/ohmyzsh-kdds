#!/usr/bin/env bash

ZSH="$HOME/.oh-my-zsh-kdds"

for d in $HOME/*; do
	if [[ -L "$d" ]]; then
    if [[ "$(basename $d)" == $ZSH/* ]]; then
      printf "Removing %s\n" "$d"
      rm $d
    fi
	fi
done
