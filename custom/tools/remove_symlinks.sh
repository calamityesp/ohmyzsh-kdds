#!/usr/bin/env bash

for d in $HOME/*; do
	if [[ -L "$d" ]]; then
    if [[ $d == $ZSH/* ]]; then
      printf "Removing %s\n" "$d"
      rm $d
    fi
	fi
done
