#! /usr/bin/env bash

readonly OBSIDIAN="$HOME/Obsidian"
readonly profile="develop"

if [[ -d "$OBSIDIAN" ]]; then
  cd $OBSIDIAN
  printf "Commiting if there is a git file\n"
  sleep 2
  if [[ -d "./git" ]]; then
    git add . || true
    git commit -m "Pushing all existing changes before removal" || true
    git push || true
  fi

  printf "Removing Obsidian Files\n"
  sleep 2
  cd -
  rm -rf "$OBSIDIAN"

  printf "Cloning Obsidian\n"
  sleep 2
  git clone git@github.com:calamityesp/obsidian.git "$OBSIDIAN"
  git -C "$OBSIDIAN" checkout "$profile" || git -C "$OBSIDIAN" checkout -b "$profile" origin/"$profile" || log $ERROR "Failed checkout $profile"
fi


