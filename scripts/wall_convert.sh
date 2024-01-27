#!/usr/bin/env sh

# convert images for rofi loading quickly

rofi_cache_dir=$HOME/.cache/rofi

wall="$1"
cache_img=$(basename "$wall")
if [ ! -d "${rofi_cache_dir}" ]; then
	mkdir -p "${rofi_cache_dir}"
fi

if [ ! -f "${rofi_cache_dir}/${cache_img}.rofi" ]; then
	convert -strip -resize 2000 -gravity center -extent 2000 -quality 90 "${wall}" "${rofi_cache_dir}/${cache_img}.rofi"
fi

if [ ! -f "${rofi_cache_dir}/${cache_img}.blur" ]; then
	convert -strip -scale 10% -blur 0x3 -resize 100% "${wall}" "${rofi_cache_dir}/${cache_img}.blur"
fi
ln -sf ${rofi_cache_dir}/${cache_img}.blur $HOME/.config/rofi/wall.blur
ln -sf ${rofi_cache_dir}/${cache_img}.rofi $HOME/.config/rofi/wall.rofi
