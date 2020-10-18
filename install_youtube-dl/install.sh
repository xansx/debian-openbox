#!/bin/bash
# ACTION: Install youtube-dl
# INFO: Install youtube-dl, a program to download videos and audios from youtube
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark='"DEBIAN-OPENBOX'

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install youtube-dl
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

# Check if ffmpeg is installed
ffmpeg
[[ $? == "127" ]] && apt-get install -y ffmpeg

# Config alias for all the users
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /home/*/ /root/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes
    echo "alias youtube-mp3='youtube-dl --extract-audio --audio-format mp3'" >> "$d/.bash_aliases"
    echo "alias youtube-mp3list='youtube-dl --extract-audio --audio-format mp3 --yes-playlist'" >> "$d/.bash_aliases"
done
