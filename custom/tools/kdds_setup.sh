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
export ZSH="$HOME/.oh-my-kdds"
readonly DOTFILES="$HOME/Dotfiles"
readonly OBSIDIAN="$HOME/Obsidian"
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
    Script
    Projects
    Notes
  )

DEPENDENCIES=(
  stow
  git
  obsidian
  nvim
  tree-sitter
  pdflatex
)


##################################################
#  SECTION: GLOBAL VARIABLES
##################################################
failed=false
profile="main"


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
#  SECTION: Checking Existing ZSHRC
##################################################
if [[ -f $HOME/.zshrc ]]; then
  log $INFO ".zshrc exists! removing"
  rm ~/.zshrc
fi


##################################################
#  SECTION: SELECT PROFILE
##################################################
log $INFO "Select a profile (By Number):"
select choice in "main" "develop" "work"; do
  case $REPLY in
    1|2|3)
      profile="$choice"
      break ;;
    *) log $ERROR "Invalid choice. Pick 1, 2, or 3." ;;
  esac
done
log $INFO "$profile profile selected!"


##################################################
#  SECTION: CHANGE OH-MY-KDDS PROFILE
##################################################
log $INFO "Switching to $profile"
git -C $ZSH checkout $profile


##################################################
#  SECTION: CLONING - SETUP DOTFILES
################################################
log $INFO "Cloning Dotfiles to Home Directory...."
git clone git@github.com:calamityesp/Dotfiles.git -b "$choice" "$DOTFILES" || true
cd $DOTFILES
git submodule update --init --recursive
cd -

# Setup symbolic Links
for dir in "$HOME/Dotfiles/"*; do
  base=$(basename "$dir")
  # stow -n -v -d "$DOTFILES" -t ~ $base (for testing)
  stow -d "$DOTFILES" -t ~ $base
done

# Update the submodules to the correct branch
git -C $DOTFILES submodule update --init --remote --rebase --recursive


##################################################
#  SECTION: CLONING - SETUP TMUX PLUGINS
##################################################
# Install tpm and tmux-power
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
git clone git@github.com:wfxr/tmux-power.git ~/.tmux/plugins/tmux-power || true


##################################################
#  SECTION: NVIM SETUP
##################################################
# Install luarocks
brew install luarocks
if [[ "$?" != 0 ]]; then
  printf "Please install luarocks, and restart script\n"
  exit 1
fi

## texlive installation  ---> texlive-binextra, texlive-latexextra

## Install mermaid support
sudo -k npm install -g @mermaid-js/mermaid-cli

## Installing FD
brew install fd

##################################################
#  SECTION: OBSIDIAN SETUP
##################################################
if [[ -d "$OBSIDIAN" ]]; then
  cd $OBSIDIAN
  log $INFO "Commiting if there is a git file"
  sleep 2
  if [[ -d "./git" ]]; then
    git add . || true
    git commit -m "Pushing all existing changes before removal" || true
    git push || true
  fi

  log $INFO "Removing Obsidian Files"
  sleep 2
  cd -
  rm -rf "$OBSIDIAN"

  log $INFO "Cloning Obsidian"
  sleep 2
  git clone git@github.com:calamityesp/obsidian.git "$OBSIDIAN"
  git -C "$OBSIDIAN" checkout "$profile" || git -C "$OBSIDIAN" checkout -b "$profile" origin/"$profile" || log $ERROR "Failed checkout $profile"
fi


##################################################
#  SECTION: SETUP KDDS DIRECTORIES
##################################################
log $INFO "Setting up Additional Directories"
for dir in ${ADDITONAL_DIRECTORIES[@]}; do
  if [[ -d "$HOME/$dir" && ! -L "$HOME/$dir" ]]; then
    log $WARN "Dir $dir exists!"
    continue
  else
    if [[ -L $HOME/$dir ]]; then
      rm $HOME/$dir
    fi
  fi
  mkdir -p $HOME/$dir
done

## KDDS Remove
exit 6


##################################################r
#  SECTION: FINISH AND LAUNCH ZSH
##################################################
log $INFO "Finished Setting up Oh-My-Zsh-KDDS"
exec zsh -l

