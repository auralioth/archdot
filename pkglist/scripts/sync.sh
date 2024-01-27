#!/bin/bash

# To Do: Sync latest packages

# first sync all the packages
paru -Qq >$PKGLIST_DIR/pkglist_all_newest.txt

# then sync all the explicitly installed packages
# define a storation path
if [ ! -d "$PKGLIST_DIR" ]; then
	mkdir $PKGLIST_DIR
fi

file=$PKGLIST_DIR/pkglist_newest.txt

# define old pkglist file
if [ -e $file ]; then
	mv $file $PKGLIST_DIR/pkglist_old.txt
	pkglist_old=$PKGLIST_DIR/pkglist_old.txt
fi

# get all the newest explicitly installed packages
paru -Qqe >$PKGLIST_DIR/pkglist_newest.txt

if [ $? -ne 0 ]; then
	echo "Failed , please try again"
	exit
else
	DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
	notify-send -i $DIR/sync.ico "Sync Successfully"
	echo "************************************"
	echo "Successfully Sync Installed Packages"
	echo "************************************"
fi

# define newest pkglist file
pkglist_newest=$PKGLIST_DIR/pkglist_newest.txt

# define add and old file
pkglist_add=$PKGLIST_DIR/pkglist_add.txt
pkglist_remove=$PKGLIST_DIR/pkglist_remove.txt

# compare
grep -Fxvf $pkglist_old $pkglist_newest >$pkglist_add
grep -Fxvf $pkglist_newest $pkglist_old >$pkglist_remove

# remove the old one
rm -rf $pkglist_old

if [ -s $pkglist_add ]; then
	notify-send "add packages" "$(<$pkglist_add)"
fi

if [ -s $pkglist_remove ]; then
	notify-send "remove packages" "$(<$pkglist_remove)"
fi

# list code extensions
code --list-extensions >../code_extensions.txt

# list tinytex packages
tlmgr info --list --only-installed --data name >../tinytex-pkgs.txt
