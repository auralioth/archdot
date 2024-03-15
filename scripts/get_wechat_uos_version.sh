#!/bin/bash

cd "$(dirname "$0")" || exit

# Get from `https://aur.archlinux.org/cgit/aur.git/tree/fetch_uos_wechat_release.py?h=wechat-universal-bwrap`
url="https://pro-store-packages.uniontech.com/appstore/dists/eagle/appstore/binary-amd64/Packages.gz"

target_package="com.tencent.wechat"
packages_file="Packages.gz"

if [ -f "$packages_file" ]; then
	rm "$packages_file"
fi

aria2c --no-conf -q "$url"

zgrep -A 20 "Package: $target_package" "$packages_file" | awk -v pkg="$target_package" '
BEGIN { found = 0 }
{
    if ($0 ~ "^Package: "pkg) {
        found = 1;
    }
    if (found && $1 == "Version:") {
        print "Version of "pkg" is " $2;
        exit;
    }
}
'

rm "$packages_file"
