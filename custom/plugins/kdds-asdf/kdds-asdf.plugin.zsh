#! /usr/bin/env zsh
####################################################
# Plugin: kdds-asdf.plugin.zsh
#
# Purpose:
#   wrapper around asdf to intercept asdf commands
# Assumptions:
#
# Safe to re-run:
#   Yes
####################################################

##################################################
#  SECTION: Helpers
##################################################
_asdf_java_update () {
  # Run the homebrew asdf script sets command higher in path
  if command -v asdf &>/dev/null; then
    source $(brew --prefix)/opt/asdf/libexec/asdf.sh
  fi

  export JAVA_HOME="$(command asdf where java)"
  echo "JAVA_HOME updated!! "
}

##################################################
#  SECTION: Main
##################################################

# Set java home to current set java
_asdf_java_update

asdf () {
  command asdf "$@"
  if [[ " $* " == *" java "* && " $* " == *" set "* ]]; then
    _asdf_java_update
    source ~/.zshrc
  fi
}
