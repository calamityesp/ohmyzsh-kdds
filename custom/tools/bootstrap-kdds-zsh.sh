#!/usr/bin/env bash

####################################################
# Script: bootstrap-kdds-zsh.sh
#
# Purpose:
#   Initial machine bootstrap and shell setup
#
# Assumptions:
#   - Linux system
#   - bash available
#
# Safe to re-run:
#   Yes
####################################################

#strict mode
set -euo pipefail

# Internal field seperator
IFS=$'\n\t'


####################################################
# Globals
####################################################
readonly RED="\e[31m"
readonly RESET="\e[0m"
readonly GREEN="\e[32m"

####################################################
# Variables
####################################################
FAILED=0
DEPENDENCIES=(
   curl
   zsh
   git
   nvim
   stow
)

ERROR="$RED \e[DERROR$RESET"
INFO="$GREEN \e[DINFO$RESET"
CONFIRMED="$GREEN \e[D✔$RESET"
MISSING="$RED \e[D❌$RESET"


####################################################
# Functions
####################################################
log() {
   level="$1"
   printf "[%b] %s\n" "${level}" "$2"
}
chk_dependency() {
   # using \e[D to move cursor left and remove a space
   if ! command -v "$1" &>/dev/null;then
      # only the marks are colored
      log $ERROR "$1"
      FAILED=1
   else
      log $CONFIRMED "$1"
   fi
}

####################################################
# Checks
####################################################

for d in "${DEPENDENCIES[@]}";do
   chk_dependency "$d"
done

(( $FAILED > 0 )) && (
   log $MISSING "Missing dependencies..."
   printf "%b\n" "$RED \e[DInstall All Dependencies Then Restart Kdds Bootstrap$RESET"
   exit 1
)


####################################################
# Check Brew Installation
####################################################
if [[ -x "/opt/homebrew/bin/brew" ]]; then
   eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
   eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
   printf "✘ Homebrew not found. Installing\n"
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   if [ $? -gt 0 ]; then
      log $ERROR "Brew Installation failed. Please install homebrew and rerun script"
      exit 1
   fi
fi

log $CONFIRMED "brew"

####################################################
# run Oh-my-zsh install script
####################################################
if [[ ! -d $HOME/.oh-my-zsh-kdds ]]; then
  log $INFO "Installing Oh-my-zsh-kdds"
  export ZSH="$HOME/.oh-my-kdds-zsh"
  export REPO="calamityesp/ohmyzsh-kdds"
  export REMOTE="https://github.com/calamityesp/ohmyzsh-kdds.git"
  export BRANCH="main"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

####################################################
# run kdds setup script
####################################################
log $INFO "Installing Oh-my-zsh-kdds:"
sleep 2

bash -c "$(curl https://raw.githubusercontent.com/calamityesp/ohmyzsh-kdds/refs/heads/main/custom/tools/setup-oh-my-zsh-kdds.sh)"
