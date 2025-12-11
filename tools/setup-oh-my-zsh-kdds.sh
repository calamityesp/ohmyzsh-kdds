#!/usr/bin/env bash

##################################################
#  SECTION: constants
##################################################
ZSH="$HOME/.oh-my-kdds/"
DOTFILES="$ZSH/dotfiles"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

##################################################
#  SECTION: functions
##################################################
failed=0
chk_install() {
	if ! command -v "$1" &>/dev/null; then
		printf "$RED x$RESET $1 Not FOUND\n"
		failed=1
	else
		printf "$GREEN✔$RESET $1 Installation Found...\n"
	fi
}


##################################################
#  SECTION: Installation Checks
##################################################
chk_install "curl"
chk_install "brew"
chk_install "stow"
chk_install "nvim"
chk_install "tmux"

if (( failed > 0 )); then
	echo "Error: Missing Dependencies. Install and Rerun script!"
	exit 1
fi

##################################################
#  SECTION: Obsidian Setup Installation
##################################################
read -e -p "Do you want Obsidian? (N/y): " -i "n" install
if [[ "y" == $install ]]; then
	echo "yeah fix this shit"
fi

printf "$GREEN✔$RESET Obsidian Check Completed...\n"


##################################################
#  SECTION: Obsidian Setup Installation
##################################################
echo "Checking/Creating Nvim Dotfiles...."
sleep 1
if [ -d $OSH/dotfiles/nvim/.config/nvim ]; then
	printf "\033[A1\r$GREEN✔$RESET \033[DNvim config exists!\n"
else
	printf "\033[A1\rCloning Nvim Configuration ... %-20s\n"
	mkdir -p $OSH/dotfiles/nvim/.config/
	git clone https://github.com/calamityesp/nvim_config_kdds.git $OSH/dotfiles/nvim/.config/nvim
fi

echo "Setting up nvim dotfile..."
stow -d $OSH/dotfiles -t ~ nvim
printf "\033[A1\rNvim setup and configuration done!!...\n"

##################################################
#  SECTION: Finish and launch ZSH
##################################################

echo "Setting ZSH as default shell and launching...."
chsh -s "$(which zsh)"
sleep 2
exec zsh

