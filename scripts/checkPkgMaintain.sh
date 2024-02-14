#!/usr/bin/env bash

# 检查上游软件包是否维护良好
# 通过 archlinux api (https://wiki.archlinux.org/title/Official_repositories_web_interface#Flagged) 完成

num_pages=$(curl -s 'https://archlinux.org/packages/search/json/?flagged=Flagged' | jq -r '.num_pages')

result=$(
	seq 1 $num_pages | parallel -j 4 \
		'comm -12 \
    	<(curl -Ss "https://archlinux.org/packages/search/json/?flagged=Flagged&page={}" | jq -r ".results[].pkgname" | sort) \
      	<(pacman -Qq | sort)' |
		sort
)

if [ -n "$result" ]; then
	kdialog --passivepopup "$result" 10 --icon "state-warning" --title "检查上游软件包维护情况"
else
	kdialog --passivepopup "所有软件包维护良好" 10 --icon "dialog-positive" --title "检查上游软件包维护情况"
fi
