#!/bin/bash

# Try to unmount partitions
sudo umount /dev/mmcblk0p8
sudo umount /dev/mmcblk0p7
sudo umount /dev/mmcblk0p6

# Modify the repair script to use mmcblk0 instead of nvme0n1.
sed 's/nvme0n1/mmcblk0/g' ~/tools/repair_device.sh >~/tools/repair_device_sdcard.sh
sudo chmod +x ~/tools/repair_device_sdcard.sh

echo
echo vvvvvvvvvv
echo Please press PROCEED at the FIRST prompt to start.
echo Then press CANCEL on the NEXT prompt to NOT to reboot the machine.
echo ^^^^^^^^^^
echo
sleep 3

# Run the repair script.
sudo ~/tools/repair_device_sdcard.sh all

# Delete automount sdcard udev rule
cmd echo "mount -o rw,remount / ; steamos-readonly disable; rm /usr/lib/udev/rules.d/99-sdcard-mount.rules" | steamos-chroot --disk /dev/mmcblk0 --partset A --

cmd echo "mount -o rw,remount / ; steamos-readonly disable; rm /usr/lib/udev/rules.d/99-sdcard-mount.rules" | steamos-chroot --disk /dev/mmcblk0 --partset B --

echo Start to insert script!

# Mount home partition and mkdir deck's home directory and .ryanrudolf directory if not exists.
sudo mkdir -p /run/media/home
sudo mount /dev/mmcblk0p8 /run/media/home
sudo mkdir -p /run/media/home/deck/ &>/dev/null
sudo mkdir -p /run/media/home/deck/.ryanrudolf &>/dev/null
sudo chown deck:deck /run/media/home/deck
sudo chown deck:deck /run/media/home/deck/.ryanrudolf

# Copy post_install_sdcard.sh to .ryanrudolf directory.
FILE=/run/media/home/deck/.ryanrudolf/post_install_sdcard.sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
sudo cp "$SCRIPT_DIR/post_install_sdcard.sh" $FILE
sudo chmod +x $FILE
sudo chown deck:deck $FILE

# Add a line to the .profile file of the SteamDeck operating system to run the post_install_sdcard.sh script every time the SteamDeck boots and deck user logs in.
# This ensures that the user does not have to manually run the post_install_sdcard.sh script, especially when they are unable to access the desktop console before the Welcome Greetings Auto Update process during a fresh install.
cat >/run/media/home/deck/.profile <<EOF
~/.ryanrudolf/post_install_sdcard.sh
EOF

sudo umount /run/media/home

echo "Done!"
