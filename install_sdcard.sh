#!/bin/bash

sudo sed -i 's/nvme0n1/mmcblk0/g' ~/tools/repair_device.sh
sudo ~/tools/repair_device.sh all
