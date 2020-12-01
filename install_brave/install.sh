#!/bin/bash
# ACTION: Install Brave browser, add to repositories and set has default browser
# INFO: Brave Browser is a fast and secure browser based on Google Chrome. Include ads and tracker blocker and other functions
# INFO: Its recommended config official repositories for weekly updates
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "brave-browser" /etc/apt/ &> /dev/null; then
	echo -e "\e[1mConfiguring repositories...\e[0m"
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" > /etc/apt/sources.list.d/brave-browser-release-trusty.list
	wget -q -O - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	apt-get update
fi

# Install package
echo -e "\e[1mInstalling packages...\e[0m"
apt-get install -y brave-browser

# Set as default
echo -e "\e[1mSetting as default alternative...\e[0m"
#update-alternatives --install /usr/bin/x-www-browser brave-browser /usr/bin/brave-browser-stable 90
#update-alternatives --install /usr/bin/gnome-www-browser brave-browser /usr/bin/brave-browser-stable 90
update-alternatives --set x-www-browser /usr/bin/brave-browser-stable
update-alternatives --set gnome-www-browser /usr/bin/brave-browser-stable
