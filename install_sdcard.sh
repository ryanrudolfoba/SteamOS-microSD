#!/bin/bash

# Disable udisks2
sudo systemctl stop udisks2.service
sudo systemctl disable udisks2.service
sudo rm /etc/systemd/system/udisks2.service
sudo rm /usr/lib/systemd/system/udisks2.service
systemctl daemon-reload
systemctl reset-failed

# Try to unmount partitions
sudo umount /dev/mmcblk0p7
sudo umount /dev/mmcblk0p6
sudo umount /dev/mmcblk0p8

echo Please press PROCEED at the first prompt to start.
echo And press CANCEL on the next prompt to NOT to reboot the machine.
sudo sed -i 's/nvme0n1/mmcblk0/g' ~/tools/repair_device.sh
sudo ~/tools/repair_device.sh all
