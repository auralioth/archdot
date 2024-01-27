#!/usr/bin/env sh

# set variables
rofi_conf="$HOME/.config/rofi/themeselect.rasi"
rofi_style="$HOME/.config/rofi/styles"
rofi_launch="$HOME/.config/rofi/config.rasi"

hypr_border=$(hyprctl -j getoption decoration:rounding | jq '.int')

monitor_width=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
monitor_width=$((monitor_width * 18 / monitor_scale))

# set rofi override
element_border=$((hypr_border * 5))
icon_border=$((element_border - 5))
rofi_override="listview{columns:4;} element{orientation:vertical;border-radius:${element_border}px;} element-icon{border-radius:${icon_border}px;size:${monitor_width}px;} element-text{enabled:false;}"

# launch rofi menu
rofi_select=$(ls ${rofi_style}/style_*.rasi | awk -F '/' '{print $NF}' | cut -d '.' -f 1 | while read style; do
	echo -en "$style\x00icon\x1f$rofi_style/${style}.png\n"
done | rofi -dmenu -theme-str "${rofi_override}" -config $rofi_conf)

echo $rofi_select

# apply rofi style
if [ ! -z $rofi_select ]; then
	cp $rofi_style/${rofi_select}.rasi $rofi_launch
	dunstify "t1" -a " ${rofi_select} applied..." -i "$rofi_style/${rofi_select}.png" -r 91190 -t 2200
fi
