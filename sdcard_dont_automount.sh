#!/bin/bash
echo Deleting sdcard automount udev rule and unmount /run/media/var
echo -e "deck\n" | sudo -S steamos-readonly disable &>/dev/null
sudo rm /usr/lib/udev/rules.d/99-sdcard-mount.rules &>/dev/null
sudo udevadm control --reload
sudo udevadm trigger
sudo umount /run/media/var &>/dev/null
sudo umount /run/media/deck/var &>/dev/null
sleep 2
echo sdcard automount udev rule deleted!
sudo steamos-readonly enable
