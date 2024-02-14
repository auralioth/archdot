#!/usr/bin/env bash

# 检查上游软件包是否维护良好
# 通过 archlinux api (https://wiki.archlinux.org/title/Official_repositories_web_interface#Flagged) 完成
set -e

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus

num_pages=$(curl -s 'https://archlinux.org/packages/search/json/?flagged=Flagged' | jq -r '.num_pages')

result=$(
	seq 1 $num_pages | parallel -j 4 \
		'comm -12 \
    	<(curl -Ss "https://archlinux.org/packages/search/json/?flagged=Flagged&page={}" | jq -r ".results[].pkgname" | sort) \
      	<(pacman -Qq | sort)' |
		sort
)

if [ -n "$result" ]; then
	notify-send -u normal \
		-t -1 \
		-i "state-warning" \
		-a "kcron" \
		"标记为过时的包" \
		"$result"
else
	notify-send -u normal \
		-i "dialog-positive" \
		-a "kcron" \
		"检查上游软件包维护情况" \
		"所有软件包维护良好"
fi
