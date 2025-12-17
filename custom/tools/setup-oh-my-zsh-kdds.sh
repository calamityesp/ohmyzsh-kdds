#!/usr/bin/env bash
####################################################
# Script: setup-oh-my-zsh-kdds.sh
#
# Purpose:
#	Setups oh-my-zsh kdds style
#
# Assumptions:
#   - Linux system
#   - bash available
#   - internet connection
#   - bootstrap has been run and dependencies installed
#
# Safe to re-run:
#   Yes
####################################################

#strict mode
set -euo pipefail

# Internal field seperator
IFS=$'\n\t'


##################################################
#  SECTION: CONSTANTS
##################################################
ZSH="$HOME/.oh-my-zsh-kdds"
readonly DOTFILES="$ZSH/Dotfiles"
readonly GREEN="\e[32m"
readonly RED="\e[31m"
readonly RESET="\e[0m"
readonly YELLOW="\e[33m"

# log levels
readonly INFO="$GREEN \e[DINFO$RESET"
readonly ERROR="$RED \e[DERROR$RESET"
readonly CONFIRMED="$GREEN \e[D✔$RESET"
readonly MISSING="$RED \e[D❌$RESET"
readonly WARN="$YELLOW \e[DWARNING ⚠️$RESET"

# directories
Additonal_Directories=(
    Repos
    Gists
    Scripts
    Projects
    Obsidian
    Notes
  )

##################################################
#  SECTION: LOGGER
##################################################
log () {
	level=$1
	printf "[%b]: %s\n" "$1" "$2" 
}

##################################################
#  SECTION: FUNCTIONS
##################################################
failed=0
chk_install() {
	if ! command -v "$1" &>/dev/null; then
		log $MISSING "1"
		failed=1
	else
		log $CONFIRMED "$1"
	fi
}

##################################################
#  SECTION: DEPENDENCY CHECK
##################################################
if ! command -v stow &>/dev/null; then
  log $ERROR "Stow installation not detected.. Install and rerun script"
  exit 1
fi

##################################################
#  SECTION: ADDING ADDITIONAL DIRECTORIES
##################################################
log $INFO "Adding Additional Directories"

##################################################
#  SECTION: REMOVING STAGNANT SYMLINKS
##################################################
log $INFO "Removing Any Existing Symbolic Links..."

# removing any existing symbolic links to ZSH
source $ZSH/custom/tools/update_symlinks.sh

# removing legacy symbolic links (oh-my-kdds) ---- NOT COMPLETED
log $INFO "Removing Any Legacy Symbolic Links..."
log $INFO "TODO: write legacy setup script"
sleep 1


##################################################
#  SECTION: CLONING DOTFILES
################################################
log $INFO "Setting up Dotfiles Repository"
git -C "$ZSH/" submodule update --init --recursive
if [[ ! -d $ZSH/Dotfiles ]]; then
  git -C "$ZSH/" remote add dotfiles https://github.com/calamityesp/Dotfiles.git
fi

read -e -p "Dotfiles work profile? (N/y): " -i "n" install
if [[ "y" == ${install,,} ]]; then
  log $WARN "Dotfiles: deleting local work branch and making new work branch from remote"
  sleep 2
  git -C $ZSH/Dotfiles checkout -b work origin/work || true
  git -C $ZSH/Dotfiles submodule update --remote
fi

log $INFO "Creating Dotfiles symbolic link"
rm $HOME/.Dotfiles ||yes
ln -sf $ZSH/Dotfiles ~/.Dotfiles

log $WARN "Run $ZSH/tools/nvim_admin.sh to setup admin and edit nvim"

##################################################r
#  SECTION: RUN STOW
##################################################
for dir in $ZSH/Dotfiles/*; do
  base=$(basename $dir)
  stow -d $ZSH/Dotfiles -t ~ $base
done

##################################################r
#  SECTION: Setting Up Additional Directories
##################################################
log $INFO "Setting up Additional Directories"
for dir in ${Additonal_Directories[@]}; do
  mkdir -p $ZSH/$dir
  if [[ -d "$HOME/$dir" && ! -L "$HOME/$dir" ]]; then
    log $WARN "Dir $dir exists! Moving to .old"
    mv $HOME/$dir $HOME/$dir.old
  fi
  rm $dir
  ln -sf $ZSH/$dir ~/$dir
  log $INFO "Symbolic Link Created: $dir"
done

##################################################r
#  SECTION: FINISH AND LAUNCH ZSH
##################################################
log $INFO "Finished Setting up Oh-My-Zsh-KDDS"
exec zsh

