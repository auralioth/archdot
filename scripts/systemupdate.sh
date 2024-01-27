#!/usr/bin/env bash

# Check release
if [ ! -f /etc/arch-release ]; then
	exit 0
fi

# Check for updates
ofc=$(paru -Qu | wc -l)

# Calculate total available updates
upd=$((ofc))

# Show tooltip
if [ $upd -eq 0 ]; then
	echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
else
	echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Outdated $ofc\"}"
fi

# Trigger upgrade
if [ "$1" == "up" ]; then
	$TERMINAL --title systemupdate sh -c 'paru -Syu'
fi
