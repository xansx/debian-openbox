#!/bin/bash
# ACTION: Install script to write notes on the conky panel (notes-conky)
# INFO: Script notes-conky allow write notes on the conky panel
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Check if conky is installed.
dpkg -l conky 2>&1 > /dev/null
if [[ $? != "0" ]]
then
    echo "Conky is not installed!"
    exit 1
fi

# Copy script
echo -e "\e[1mInstalling script notes-conky"
cp -v "$base_dir/notes-conky" /usr/bin/
chmod -v a+x /usr/bin/notes-conky


# Config notes-conky files for global (all users)
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /home/*/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue  # Skip dirs that no are homes
    cp -v "${base_dir}/shortcuts.conkyrc" "$d/.config/conky/shortcuts.conkyrc" && chown -R $(stat "$(dirname "$d/.config/conky/shortcuts.conkyrc")" -c %u:%g) "$d/.config/conky/shortcuts.conkyrc"
    cp -v "${base_dir}/notes_conky.txt" "$d/.notes_conky.txt" && chown -R $(stat "$(dirname "$d/.notes_conky.txt")" -c %u:%g) "$d/.notes_conky.txt"
done
