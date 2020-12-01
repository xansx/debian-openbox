#!/bin/bash
# ACTION: Install script to rotate everyday Linux solarized wallpapers pack by Andreas Linz
# INFO: wallpaper-rotate script rotate everyday a link to a wallpaper file
# DEFAULT: n

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install dependences
if ! which anacron &>/dev/null; then
	echo -e "\e[1mInstalling packages...\e[0m"
	[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
	apt-get -y install anacron
fi

# Copy rotate script in cron.daily dir
echo -e "\e[1mInstalling script...\e[0m"
f="wallpaper-rotate"
cp -v "${base_dir}/$f" /etc/cron.daily/
chmod a+x "/etc/cron.daily/$f"

# Exec now rotation
echo -e "\e[1mExecuting rotation..\e[0m"
"/etc/cron.daily/$f"
