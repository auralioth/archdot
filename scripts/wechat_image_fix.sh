#!/usr/bin/env bash

fake_path="file://$HOME/xwechat_files"
real_path="$HOME/.var/app/com.tencent.WeChat/xwechat_files"

if [[ "$(wl-paste -l)" =~ "application/x-mimedata-xwechat" ]] && [[ "$(wl-paste -l)" =~ "text/x-moz-url" ]]; then
	clip_image=$(wl-paste)
	if [[ "$clip_image" =~ "$fake_path" ]]; then
		real_image=$(echo "$clip_image" | sed "s|$fake_path|$real_path|")

		wl-copy <"$real_image"
		echo "wechat图像已替换"

	fi
fi
