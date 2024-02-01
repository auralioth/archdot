#!/usr/bin/env bash

set -e

# 设置一个时间阈值，例如30天
threshold_days=30

# 获取所有已安装的软件包的名称
installed_packages=$(expac --timefmt='%Y-%m-%d %T' '%l\t%n' $(paru -Qeq) | sort -r | cut -f 2)

# 获取当前日期
current_date=$(date +%s)

# 保存要显示的通知内容
notifications="<html><body>"

# 循环检查每个软件包的最后更新时间
for package in $installed_packages; do
	last_update=$(expac --timefmt='%Y-%m-%d %T' '%l\t%n' $package | cut -f 1)

	# 将日期转换为秒数
	last_update_seconds=$(date --date="$last_update" +%s)

	# 计算距离最后更新的天数
	days_since_last_update=$(((current_date - last_update_seconds) / 86400))

	# 检查是否超过阈值，将信息添加到通知中
	if [ $days_since_last_update -ge $threshold_days ]; then
		notifications+="软件包 <u>$package</u> 已经超过 <u>$threshold_days</u> 天没有更新了（最后更新时间：<i>$last_update</i>）<br>"
	fi
done

notifications+="</body></html>"

# 检查是否有需要显示的通知
if [ -n "$notifications" ]; then
	# 显示KDE通知
	kdialog --passivepopup "$notifications" 10 --icon "dialog-warning" --title "长期未更新软件包"
fi
