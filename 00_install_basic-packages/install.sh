#!/bin/bash
# ACTION: Install some basic packages
# INFO: Debian netinstall comes with few list of installed packages
# INFO: Some basic packages are: vim vlc zip unzip gmtp mtp-tools mailutils traceroute acl gnupg2 synaptic galternatives mlocate evince apt-transport-https curl
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install free packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y vim vlc zip unzip gmtp mtp-tools mailutils traceroute acl gnupg2 synaptic galternatives mlocate evince apt-transport-https curl rar unrar ntfs-3g

  
