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



#****************************************************************************************************
#                                               Aliases
#****************************************************************************************************

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
alias cdzsh="cd $ZSH"

# Oh-My-KDDS
alias kdds_custom="$ZSH/custom"
alias kddsc="$ZSH/custom"
alias kdds_custom_tools="$ZSH/custom/tools"
alias kddst="$ZSH/custom/tools"
alias kdds_custom_plugins="$ZSH/custom/plugins"
alias kddsp="$ZSH/custom/plugins"
alias kdds_logs="$ZSH/logs"

##################################################
#  SECTION: General Aliases
##################################################
alias editkdds="nvim $ZSH/custom/plugins/kdds/kdds.plugin.zsh"
alias editzshrc="nvim $HOME/.zshrc"


##################################################
#  SECTION: Tool Aliases
##################################################
alias updatekdds="$ZSH/custom/tools/update_kdds.sh"
alias kddsupdate="$ZSH/custom/tools/update_kdds.sh"
alias kddsupdk="$ZSH/custom/tools/update_kdds.sh"
alias updatedotfiles="$ZSH/custom/tools/update_dotfiles.sh"
alias kddsupdatedotfiles="$ZSH/custom/tools/update_dotfiles.sh"
alias kddsupdd="$ZSH/custom/tools/update_dotfiles.sh"

##################################################
#  SECTION: Docker Related
##################################################
# Launch Windows in docker using Dockurr
alias dockwindows='docker run -it --rm --name windows -e "VERSION=11" -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "$HOME/NFS/windows:/storage" --stop-timeout 120 docker.io/dockurr/windows'

