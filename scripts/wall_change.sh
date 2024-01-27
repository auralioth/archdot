#!/bin/bash

# 设置壁纸目录
wallpaper_dir="$HOME/wallpapers"

if [ ! -d $wallpaper_dir ]; then
	echo "wallpaper dir not exits"
	exit 1
fi

swww query
if [ $? -eq 1 ]; then
	swww init
fi

# 指定要查找的图片的名称
current_image=$(swww query | grep "currently displaying" | awk -F 'image: ' '{print $2}')

# 获取壁纸目录中所有的图片文件
image_list=($(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)))

# 对图片列表进行排序
sorted_images=($(printf "%s\n" "${image_list[@]}" | sort))

# 查找指定图片的索引
current_index=-1
for ((i = 0; i < ${#sorted_images[@]}; i++)); do
	if [ "${sorted_images[i]}" == "$current_image" ]; then
		current_index=$i
		break
	fi
done

while getopts "nps" option; do
	case $option in
	n)
		next_index=$(((current_index + 1) % ${#sorted_images[@]}))
		;;
	p)
		next_index=$(((current_index + ${#sorted_images[@]} - 1) % ${#sorted_images[@]}))
		;;
	*)
		echo "invalid args"
		echo "n : set next wall"
		echo "p : set previous wall"
		exit 1
		;;
	esac
done

if [ $current_index -eq -1 ]; then
	echo "image not found: $current_image"
	next_image=$(find "$HOME/wallpapers" -type f | shuf -n 1)
elif [ $# -eq 0 ]; then
	next_image="${sorted_images[$current_index]}"
else
	next_image="${sorted_images[$next_index]}"
fi

swww img $next_image

scr_dir=$(dirname $(realpath $0))

$scr_dir/wall_convert.sh "$next_image"
