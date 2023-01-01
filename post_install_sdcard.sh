#!/bin/bash

# check if sudo password has been set for the deck account
if [ "$(passwd --status deck | tr -s " " | cut -d " " -f 2)" == "P" ]; then
	echo Sudo password is already set!
else
	echo Setting sudo password deck:deck
	echo -e "deck\ndeck" | passwd deck &>/dev/null
	echo Sudo password has been set!
fi

echo Deleting sdcard automount udev rule and unmount /run/media/var
echo -e "deck\n" | sudo -S steamos-readonly disable &>/dev/null
sudo rm /usr/lib/udev/rules.d/99-sdcard-mount.rules &>/dev/null
sudo udevadm control --reload
sudo udevadm trigger
sudo umount /run/media/var &>/dev/null
sudo umount /run/media/deck/var &>/dev/null
echo sdcard automount udev rule deleted!

FILE=/etc/systemd/system/sdcard_minimize_write.service
if [ ! -f "$FILE" ]; then
	FIRST_RUN=true

	mkdir ~/.ryanrudolf &>/dev/null
	cat >~/.ryanrudolf/sdcard_minimize_write.sh <<EOF
#!/bin/bash
for mountpoint in \$(mount | grep mmcblk0p | tr -s " " | cut -d " " -f 3)
do 
	mount -o rw,remount,noatime \$mountpoint
	echo \$mountpoint has been remounted with noatime flag.
done
swapoff /home/swapfile
umount /run/media/deck/var &> /dev/null
exit 0
EOF

	chmod +x ~/.ryanrudolf/sdcard_minimize_write.sh
	echo Script has been created!

	sudo rm /etc/systemd/system/sdcard_minimize_write.service
	cat <<EOF | sudo tee -a /etc/systemd/system/sdcard_minimize_write.service &>/dev/null
[Unit]
Description=Minimize writes to the sdcard - set noatime flag and disable swap.

[Service]
Type=simple
User=root
ExecStart=/home/deck/.ryanrudolf/sdcard_minimize_write.sh

[Install]
WantedBy=multi-user.target
EOF
	echo Service has been created: sdcard_minimize_write

	# From https://www.reddit.com/r/SteamDeck/comments/vn1nxt/how_to_install_steamos_to_the_microsd_card/
	sudo rm /etc/systemd/system/microsd-umount.service
	cat <<EOF | sudo tee -a /etc/systemd/system/microsd-umount.service &>/dev/null
[Unit]
Description=Attempts to unmount /run/media/var up to 10 times on startup.

[Service]
ExecStart=/bin/bash -c "for i in {0..9}; do if mountpoint -q -- /run/media/var; then umount /run/media/var; else sleep 1; fi; done"

[Install]
WantedBy=multi-user.target
EOF
	echo Service has been created: microsd-umount

	sudo systemctl enable sdcard_minimize_write
	sudo systemctl enable microsd-umount
	echo Services has been enabled.
fi

sudo steamos-readonly enable

if [ "$FIRST_RUN" ]; then
	echo Shutting down the Steam Deck.
	sudo poweroff
fi
