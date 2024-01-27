#!/usr/bin/env sh

scr_dir=$(dirname $(realpath $0))

# define functions

function print_error
{
	cat <<"EOF"
    ./volumecontrol.sh -[device] <action>
    ...valid device are...
        i -- [i]nput decive
        o -- [o]utput device
    ...valid actions are...
        i -- <i>ncrease volume [+5]
        d -- <d>ecrease volume [-5]
        m -- <m>ute [x]
EOF
}

function notify_vol
{
	vol=$(pamixer $source --get-volume | cat)
	angle="$(((($vol + 2) / 5) * 5))"
	ico="${icodir}/vol-${angle}.svg"
	bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
	dunstify "t2" -a "$vol$bar" "$audio_source" -i $ico -r 91190 -t 800
}

function notify_mute
{
	mute=$(pamixer $source --get-mute | cat)
	if [ "$mute" == "true" ]; then
		dunstify "t2" -a "muted" "$audio_source" -i ${icodir}/muted-${device}.svg -r 91190 -t 800
	else
		dunstify "t2" -a "unmuted" "$audio_source" -i ${icodir}/unmuted-${device}.svg -r 91190 -t 800
	fi
}

# set device source

while getopts io device_type; do
	case $device_type in
	i)
		audio_source=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
		source="--default-source"
		device="mic"
		;;
	o)
		audio_source=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
		source=""
		device="speaker"
		;;
	esac
done

if [ $OPTIND -eq 1 ]; then
	print_error
fi

# set device action

shift $((OPTIND - 1))
step="${2:-5}"
icodir="~/.config/dunst/icons/vol"

case $1 in
i)
	pamixer $source -i ${step}
	notify_vol
	;;
d)
	pamixer $source -d ${step}
	notify_vol
	;;
m)
	pamixer $source -t
	notify_mute
	;;
*) print_error ;;
esac
