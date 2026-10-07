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
  if [[ -x $(brew --prefix)/opt/asdf/libexec/asdf.sh ]]; then
    # Run the homebrew asdf script sets command higher in path
    source $(brew --prefix)/opt/asdf/libexec/asdf.sh

    # Set Java Home if we are using the older asdf brew version
    if commmand asdf which java &>/dev/null; then
      export JAVA_HOME="$(command asdf where java)"
      echo "UPDATE: JAVA_HOME=$JAVA_HOME"
    fi
  fi

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
