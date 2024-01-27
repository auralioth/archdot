#!/bin/bash

# Define info func
Parent_thread() {
	echo -e "\033[1;32m==>\033[0m \033[1;37m$1...\033[0m"
}

Child_thread() {
	echo -e "\033[1;34m ->\033[0m \033[1;37m$1...\033[0m"
}

Warning() {
	echo -e "\033[1;33m::\033[0m \033[1;37m$1\033[0m"
}

Error() {
	echo -e "\033[1;31merror:\033[0m \033[1;37m$1.\033[0m"
}

# Cd to the parent directory of install script
cd "$(dirname "$0")" || exit 1

# Install `paru` first to avoid some problems
Parent_thread "Install AUR helper"
sudo pacman -S --needed paru-git

# Check pkglist file
pkglist_newest="../pkglist_newest.txt"
pkglist_all_newest="../pkglist_all_newest.txt"
if [[ ! -f "$pkglist_all_newest" && ! -f "$pkglist_newest" ]]; then
	Error "pkglist file does not exit in the upper directory"
	exit 1
fi

# Install packages
Parent_thread "Install packages"

if ! grep -Fxvqf <(paru -Qq) "$pkglist_newest"; then
	:
elif ! paru -S --needed $(grep -Fxvf <(paru -Qq) "$pkglist_newest"); then
	Error "failed , please try again"
	exit 1
fi

# Install code extensions
Parent_thread "Install code extensions"
# Read extension IDs from a.txt and install them
code_extensions="../code_extensions.txt"
while IFS= read -r extension_id; do
	code --install-extension "$extension_id"
done <$code_extensions

# System settings
Parent_thread "System settings"

# Systemctl
Child_thread "Systemctl settings"
sudo systemctl enable --now bluetooth

# Rustup
Child_thread "Rustup install the toolchain"
rustup default stable

# Change default shell
Child_thread "Change shell to zsh"
if ! echo "$SHELL" | grep -q "/usr/bin/zsh"; then
	chsh -s /usr/bin/zsh
fi

# Add user to groups
Child_thread "Add user to groups"
group=("lp" "input" "docker")
for element in "${group[@]}"; do
	if ! groups | grep -q "$element"; then
		sudo gpasswd -a "$USER" "$element"
	fi
done

# restore files
Parent_thread "Restore files and settings"

# Check the owner
bool=

Child_thread "Check the user"
while true; do
	Warning "Are you the owner of the repository and already setting the ssh? [Y/n]"
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		bool=true
		break
		;;
	[nN][oO] | [nN])
		bool=false
		break
		;;

	*)
		Error "invalid input"
		;;
	esac
done

# Clone archdoc
Child_thread "Clone archdoc"
while true; do
	Warning "Do you want to clone the archdoc? [Y/n]"
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		ARCHDOC_DIR="$HOME/Data/archdoc"

		if [ -d "$ARCHDOC_DIR" ]; then
			mv "$ARCHDOC_DIR" "$ARCHDOC_DIR".bak
			Warning "Has made a backup of archdoc into archdoc.bak"
		fi

		if $bool; then
			git clone git@github.com:auryouth/archdoc.git "$ARCHDOC_DIR"
		else
			git clone https://github.com/auryouth/archdoc.git "$ARCHDOC_DIR"
		fi

		break
		;;
	[nN][oO] | [nN])
		break
		;;

	*)
		Error "invalid input"
		;;
	esac
done

# Clone archbuild
Child_thread "Clone archbuild"
while true; do
	Warning "Do you want to clone the archbuild? [Y/n]"
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		ARCHBUILD_DIR="$HOME/arch/archbuild"

		if [ -d "$ARCHBUILD_DIR" ]; then
			mv "$ARCHBUILD_DIR" "$ARCHBUILD_DIR".bak
			Warning "Has made a backup of archbuild into archbuild.bak"
		fi

		if $bool; then
			git clone git@github.com:auryouth/archbuild.git "$ARCHBUILD_DIR"
		else
			git clone https://github.com/auryouth/archbuild.git "$ARCHBUILD_DIR"
		fi

		break
		;;
	[nN][oO] | [nN])
		break
		;;

	*)
		Error "invalid input"
		;;
	esac
done

# Clone dotfiles
Child_thread "Clone dotfile"
Warning "Default cloning to ~/.dotfile. Feel free to exit and change it. Continue? [Y/n]"
while true; do
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		break
		;;
	[nN][oO] | [nN])
		exit 0
		;;

	*)
		Error "invalid input"
		;;
	esac
done

DOT_DIR="$HOME/.dotfile"

if [ -d "$DOT_DIR" ]; then
	mv "$DOT_DIR" "$DOT_DIR".bak
	Warning "Has made a backup of .dotfile into .dotfile.bak"
fi

# Confirm install
if ($bool && git clone git@github.com:auryouth/archdot.git "$DOT_DIR") || (! $bool && git clone https://github.com/auryouth/archdot.git "$DOT_DIR"); then
	while true; do
		Warning "Are you sure to install? [Y/n]"
		read -r input

		case $input in
		[yY][eE][sS] | [yY])
			cd "$DOT_DIR" || exit 1
			./install
			break
			;;
		[nN][oO] | [nN])
			exit 1
			;;

		*)
			Error "invalid input"
			;;
		esac
	done
else
	Error "failed, please make sure you have cloned the dotfile"
	exit 1
fi

# Confirm reboot to take effect
while true; do
	Warning "Reboot now to take effect? [Y/n]"
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		reboot || sudo reboot
		exit 0
		;;

	[nN][oO] | [nN])
		exit 0
		;;

	*)
		Error "invalid input"
		;;
	esac
done
