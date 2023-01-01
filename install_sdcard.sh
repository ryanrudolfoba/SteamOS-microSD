#!/bin/bash

sudo systemctl stop udisks2.service
sudo systemctl disable udisks2.service
sudo rm /etc/systemd/system/udisks2.service
sudo rm /usr/lib/systemd/system/udisks2.service
systemctl daemon-reload
systemctl reset-failed

sudo sed -i 's/nvme0n1/mmcblk0/g' ~/tools/repair_device.sh
sudo ~/tools/repair_device.sh all
