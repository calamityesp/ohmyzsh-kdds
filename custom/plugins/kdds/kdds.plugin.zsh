#!/usr/bin/env bash
####################################################
# Plugin: kdds.plugin.zsh
#
# Purpose:
#	  Aliases and Functions for Kdds
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
#  SECTION: Directory Aliases
##################################################
alias editkdds=nvim "$ZSH/custom/plugins/kdds/kdds.plugin.zsh"
alias dotfiles="$ZSH/Dotfiles"
alias scripts="$ZSH/Scripts"
alias repos="$ZSH/Repos"
alias custom="$ZSH/custom"
alias plugins="$ZSH/plugins"

# Oh-My-KDDS
alias kdds_custom="$ZSH/custom"
alias kdds_custom_tools="$ZSH/custom/tools"
alias kdds_tools="$ZSH/custom/tools"
alias kdds_custom_plugins="$ZSH/custom/plugins"
alias kdds_logs="$ZSH/logs"

