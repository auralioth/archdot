#!/usr/bin/env sh

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null
then
    pkill -x "wlogout"
    exit 0
fi

# set file variables
src_dir=`dirname $(realpath $0)`
layout="$HOME/.config/wlogout/layout"
style="$HOME/.config/wlogout/style.css"

if [ ! -f $layout ] || [ ! -f $style ] ; then
    echo "ERROR: Config $1 not found..."
    exit 1;
fi

# detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# theme var
gtk_theme=`gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g"`
gtk_mode=`gsettings get org.gnome.desktop.interface color-scheme | sed "s/'//g" | awk -F '-' '{print $2}'`

# hypr var
hypr_border=`hyprctl -j getoption decoration:rounding | jq '.int'`
hypr_width=`hyprctl -j getoption general:border_size | jq '.int'`

# scale config layout and style
column=6
export margin=$(( y_mon * 28 / hypr_scale ))
export hover_margin=$(( y_mon * 23 / hypr_scale ))

# scale font size
export font_size=$(( y_mon * 2 / 100 ))

# detect gtk system theme
export btn_color=`[ "$gtk_mode" == "dark" ] && ( echo "white" ) || ( echo "black" )`
export win_bg=`[ "$gtk_mode" == "dark" ] && ( echo "rgba(0,0,0,0.5)" ) || ( echo "rgba(255,255,255,0.5)" )`

# eval hypr border radius
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))

# eval config files
wl_style=`envsubst < $style`

# launch wlogout
wlogout -b $column -c 0 -r 0 -m 0 --layout $layout --css <(echo "$wl_style") --protocol layer-shell

