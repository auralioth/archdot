case $1 in
    dae)
        case $2 in
            r)
                sudo dae reload && dunstify -u critical -i ~/.config/waybar/icons/dae.jpg 'Dae: Reload' -r 91190 -t 3000
            ;;
            s)
                sudo dae suspend && dunstify -u critical -i $XDG_CONFIG_HOME/waybar/icons/dae.jpg  'Dae: Suspend' -r 91190 -t 3000
            ;;
            *) echo "toggleproxy.sh dae [action]"
                echo "-r -- reload dae"
                echo "-s -- suspend dae"
            ;;
        esac
    ;;
    clash) pid=$(pgrep clash-meta)
        if [ -z "$pid" ]; then
          clash-meta -d "$XDG_CONFIG_HOME"/clash-meta &
          dunstify -u critical -i ~/.config/waybar/icons/meta.png 'Clash-Meta: Start' -r 91190 -t 3000
          exit 0
        fi

        pgrep clash-meta | xargs kill -9
        dunstify -u critical -i ~/.config/waybar/icons/meta.png 'Clash-Meta: Stop' -r 91190 -t 3000
    ;;
    *) echo "toggleproxy.sh [action]"
        echo "dae -- toggle dae"
        echo "clash -- toggle clash-meta"
    ;;
esac

