#!/bin/bash

# Check if file not exists
SOURCE_FILE=~/SteamOS-microSD/post_install_sdcard.sh
TARGET_FILE=/etc/profile.d/post_install_sdcard.sh
if [ ! -f "$TARGET_FILE" ] && [ -f "$SOURCE_FILE" ]; then
    sudo cp $SOURCE_FILE $TARGET_FILE
    echo "post_install_sdcard.sh copied to /etc/profile.d/"
    sudo reboot
fi
