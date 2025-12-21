#!/usr/bin/env zsh

####################################################
# Script: setup_obsidian.sh
#
# Purpose:
#	Setup Obsidian from Git Repository
#
# Assumptions:
#   - bash available
#   - internet connection
#   - bootstrap has been run and dependencies installed
#   - git repository installed
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

