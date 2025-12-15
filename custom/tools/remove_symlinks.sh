#!/usr/bin/env bash

TARGET_DIR="$ZSH"

for d in $HOME/*; do
	if [[ -L "$d" ]]; then
		printf "Removing %s\n" "$d"
		rm $d
	fi
done
