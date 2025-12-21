!/usr/bin/env bash
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
#  SECTION: Checking Existing ZSHRC
################################################
if [[ -f $HOME/.zshrc ]]; then
  log $INFO ".zshrc exists! removing"
  rm ~/.zshrc
fi

##################################################
#  SECTION: SELECT PROFILE
################################################
log $INFO "Select a profile:"
select choice in "main" "develop" "work"; do
  case $REPLY in
    1|2|3)
      CHOICE="$choice"
      break ;;
    *) log $ERROR "Invalid choice. Pick 1, 2, or 3." ;;
  esac
done
log $INFO "$CHOICE profile selected!"

##################################################r
#  SECTION: CHANGE PROFILE
##################################################
log $INFO "Switching to $CHOICE"
git $ZSH checkout $CHOICE

##################################################
#  SECTION: CLONING SUBMODULES
################################################
log $INFO "Initializing All Levals Submodules"
git -C "$ZSH/" submodule update --init --recursive
git -C "$ZSH/" submodule update --remote
# git -C "$ZSH/Dotfiles" submodule update --init --recursive
git -C "$ZSH/Dotfiles" submodule update --remote

##################################################r
#  SECTION: RUN DOTFILES STOW
##################################################
# Remove any symbolic links in .config
for dir in "$HOME/.config/"*;do
  base=$(basename $dir)
  match=$(find "$ZSH/Dotfiles" -type d -name "$base" -prune)
  if [[ -n "$match" ]]; then
    mv $dir $dir.backup
  fi
done

for dir in $ZSH/Dotfiles/*; do
  base=$(basename $dir)
  stow -d $HOME/.oh-my-zsh-kdds/Dotfiles -t ~ $base
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
  else
    if [[ -L $HOME/$dir ]]; then
      rm $HOME/$dir
    fi
  fi
  ln -sf $ZSH/$dir ~/$dir
  log $INFO "Symbolic Link Created: $dir"
done

##################################################r
#  SECTION: FINISH AND LAUNCH ZSH
##################################################
log $INFO "Finished Setting up Oh-My-Zsh-KDDS"
chmod +x $ZSH/oh-my-zsh.sh
exec zsh

