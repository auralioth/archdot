#!/usr/bin/env sh

wall_path="$HOME/wallpapers"

hypr_border=$(hyprctl -j getoption decoration:rounding | jq '.int')

rofi_conf="$HOME/.config/rofi/themeselect.rasi"

monitor_width=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
monitor_width=$((monitor_width * 17 / monitor_scale))

# set rofi override
element_border=$((hypr_border * 3))
rofi_override="element{border-radius:${element_border}px;} listview{columns:6;spacing:100px;} element{padding:0px;orientation:vertical;} element-icon{size:${monitor_width}px;border-radius:0px;} element-text{padding:20px;}"

# launch rofi menu
rofi_select=$(find "${wall_path}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort | while read file; do
	echo -en "${file}\x00icon\x1f${wall_path}/${file}\n"
done | rofi -dmenu -theme-str "${rofi_override}" -config "${rofi_conf}")

if [ ! -z "${rofi_select}" ]; then
	swww img ${wall_path}/${rofi_select}

	scr_dir=$(dirname $(realpath $0))

	$scr_dir/wall_convert.sh "${wall_path}/${rofi_select}"
fi
