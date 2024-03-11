#!/bin/bash

# 以 markdown 表格形式输出所有安装包的未安装的可选依赖

read -p "请输入输出文件的路径（默认为用户的HOME目录，按下Enter键即可）: " output_path
output_path=${output_path:-$HOME}

output_file="${output_path}/optional_deps.md"

packages=$(paru -Qq)

>"$output_file"

echo "| 软件包 | 可选依赖 |可选依赖信息|" >>"$output_file"
echo "| ------- | ---- | ------ |" >>"$output_file"

for package in $packages; do
	package_info=$(paru -Qi "$package")

	optional_deps=$(echo -e "$package_info" | grep -E '^\s*可选依赖|^\s{17,}' | grep -v '已安装' | grep -v '无')

	if [ -n "$optional_deps" ]; then
		echo -e "| $package |||" >>"$output_file"
		echo -e "$optional_deps" | sed 's/^可选依赖[[:space:]]*:[[:space:]]*//; s/^/| /; s/^/| /; s/:/ |/g' >>"$output_file"
	fi
done

echo "可选依赖信息已写入 $output_file"
