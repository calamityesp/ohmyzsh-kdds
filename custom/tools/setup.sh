#! /usr/bin/env bash
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

###################################################
#  SECTION: ENV VARIABLES
##################################################
export ohmykddsdir="$HOME/.oh-my-kdds/"

# Set system ENV for convience
export OS="$(uname -s)"

###################################################
#  SECTION: ENV PATHS
##################################################

# Set Homebrew Paths (even if not installed yet)
case "$OS" in
  Linux*) export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"  ;;
esac


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
ADDITONAL_DIRECTORIES=(
    Repos
    Gists
    Scripts
    Projects
    Obsidian
    Notes
  )

DEPENDENCIES=(
  stow
  git
  obsidian
  nvim
)

##################################################
#  SECTION: GLOBAL VARIABLES
##################################################
failed=false

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
chk_install() {
	if ! command -v "$1"; then
		log $MISSING "1"
		failed=true
	else
		log $CONFIRMED "$1"
    failed=false
	fi
}



##################################################
#  SECTION: DEPENDENCY CHECK
##################################################
## Check Homebrew and/or Install
log $INFO "Checking Brew Installation:"
chk_install "brew"
if [[ $failed == "true" ]]; then
  read -p "Homebrew not installed, Run Installation? (Y/n)" response 
  if [[ "${response,,}" == "y" || -z "$response" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    chk_install "brew"
  else
    echo "Install homebrew then run script again"
    exit 1
  fi
fi


## Check Additional Dependencies, install with homebrew if missing
for prog in "${DEPENDENCIES[@]}"; do
  chk_install $prog
  if [[ $failed == "true" ]]; then
    brew install $prog
    chk_install $prog

    # verify installation was successful
    if [[ $failed == "true" ]]; then
      printf "/s failed to install. Please install dependency and rerun script" $prog
      exit 1
    fi
  fi
done

##################################################
#  SECTION: OH-MY-KDDS SUBMODULE INIT
##################################################
## Clone Submodules
git -C "$ohmykddsdir" submodule update --init --recursive

# KDDS Exit
echo "Exiting"
exit 6

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

