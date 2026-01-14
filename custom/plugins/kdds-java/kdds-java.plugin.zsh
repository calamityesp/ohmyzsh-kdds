#! /usr/bin/env zsh

####################################################
# Plugin: kdds-java.plugin.zsh
#
# Purpose:
#	  Aliases for working with java
#
# Assumptions:
#   - Linux system
#   - bash available
#   - internet connection
#   - bootstrap has been run and dependencies installed
#   - asdf
#   - asdf java installation
#
# Safe to re-run:
#   Yes
####################################################

##################################################
#  SECTION: Asdf Checks
##################################################

if !command -v asdf &>/dev/null; then
  printf "Asdf command not found."
fi

#****************************************************************************************************
#                                               Functions
#****************************************************************************************************
updatejava () {
  export JAVA_HOME="$(asdf which java)"
}

