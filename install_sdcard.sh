#!/bin/bash

# Disable udisks2
sudo systemctl stop udisks2.service
sudo systemctl disable udisks2.service
sudo rm /etc/systemd/system/udisks2.service
sudo rm /usr/lib/systemd/system/udisks2.service
systemctl daemon-reload
systemctl reset-failed

# Try to unmount partitions
sudo umount /dev/mmcblk0p8
sudo umount /dev/mmcblk0p7
sudo umount /dev/mmcblk0p6

# Modify the repair script to use mmcblk0 instead of nvme0n1.
sudo sed -i 's/nvme0n1/mmcblk0/g' ~/tools/repair_device.sh

echo
echo vvvvvvvvvv
echo Please press PROCEED at the first prompt to start.
echo And press CANCEL on the next prompt to NOT to reboot the machine.
echo ^^^^^^^^^^
echo
sleep 3

# Run the repair script.
sudo ~/tools/repair_device.sh all

echo Start to insert script!

# Mount home partition
sudo mkdir -p /run/media/home
sudo mount /dev/mmcblk0p8 /run/media/home
sudo mkdir -p /run/media/home/deck/ &>/dev/null
sudo mkdir -p /run/media/home/deck/.ryanrudolf &>/dev/null
sudo chown deck:deck /run/media/home/deck
sudo chown deck:deck /run/media/home/deck/.ryanrudolf

FILE=/run/media/home/deck/.ryanrudolf/post_install_sdcard.sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
sudo cp "$SCRIPT_DIR/post_install_sdcard.sh" $FILE
sudo chmod +x $FILE
sudo chown deck:deck $FILE

cat >/run/media/home/deck/.profile <<EOF
~/.ryanrudolf/post_install_sdcard.sh
EOF

sudo umount /run/media/home

echo "Done!"
