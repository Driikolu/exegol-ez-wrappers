#!/usr/bin/env bash

# Creating i3status config
mkdir -p ~/.config/i3status/
cp ./confs/i3status_config ~/.config/i3status/config

# Creating i3 bindings
cat ./confs/i3_bindings >> ~/.config/i3/config
sed -i 's/^\([[:space:]]*status_command\)[[:space:]]\+.*/\1 i3status_wrapper.sh/' ~/.config/i3/config
sed -i 's/\bdmenu_run\b/dmenu_wrapper.sh/g' ~/.config/i3/config
sed -i '/^bindsym[[:space:]]\+\$mod\+.*Return exec / {
s/^/# /
h
s/exec .*/exec shell_wrapper.sh/
G
}' ~/.config/i3/config

# Creating .xprofile
cat ./confs/xprofile >> ~/.xprofile

# Adding the scripts
mkdir -p ~/.local/bin/
cp ./scripts/* ~/.local/bin
chmod +x ~/.local/bin/*.sh



