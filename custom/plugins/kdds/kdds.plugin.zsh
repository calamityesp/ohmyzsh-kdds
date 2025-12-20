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
##################################################
#  SECTION: Variables
##################################################
CUSTOM="$ZSH/custom/"
PLUGINS="$ZSH/custom/plugins"
TOOLS="$ZSH/custom/tools/"

##################################################
#  SECTION: Directory Aliases
##################################################
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

##################################################
#  SECTION: General Aliases
##################################################
alias editkdds=nvim "$ZSH/custom/plugins/kdds/kdds.plugin.zsh"

##################################################
#  SECTION: Tool Aliases
##################################################
alias updatekdds="$ZSH/custom/tools/update_kdds.sh"
alias updatedotfiles="$ZSH/custom"
