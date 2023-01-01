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

FILE=/etc/systemd/system/sdcard_minimize_write.service
if [ ! -f "$FILE" ]; then
	FIRST_RUN=true

	# check if sudo password has been set for the deck account
	if [ "$(passwd --status deck | tr -s " " | cut -d " " -f 2)" == "P" ]; then
		echo Sudo password is already set!
	else
		echo Setting sudo password deck:deck
		echo -e "deck\ndeck" | passwd deck &>/dev/null
		sleep 2
		echo Sudo password has been set!
	fi

	sleep 2

	mkdir ~/.ryanrudolf &>/dev/null
	cat >~/.ryanrudolf/sdcard_minimize_write.sh <<EOF
#!/bin/bash
for mountpoint in \$(mount | grep mmcblk0p | tr -s " " | cut -d " " -f 3)
do 
	sudo mount -o rw,remount,noatime \$mountpoint
	echo \$mountpoint has been remounted with noatime flag.
done
sudo swapoff /home/swapfile
sudo umount /run/media/deck/var &> /dev/null
EOF

	chmod +x ~/.ryanrudolf/sdcard_minimize_write.sh
	sleep 2
	echo Script has been created!

	sudo rm /etc/systemd/system/sdcard_minimize_write.service
	cat <<EOF | sudo tee -a /etc/systemd/system/sdcard_minimize_write.service &>/dev/null
[Unit]
Description=Minimize writes to the sdcard - set noatime flag and disable swap.

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/home/deck/.ryanrudolf/sdcard_minimize_write.sh

[Install]
WantedBy=multi-user.target
EOF

	sudo systemctl enable sdcard_minimize_write
fi

sudo steamos-readonly enable

if [ "$FIRST_RUN" ]; then
	echo Shutting down the Steam Deck in 10 seconds.
	sleep 10
	sudo poweroff
fi
