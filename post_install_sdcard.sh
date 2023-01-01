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

service_exists() {
	local n=$1
	if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
		return 0
	else
		return 1
	fi
}

# Run this script in user profile.
if [ ! -f "/home/deck/.profile" ]; then
	touch /home/deck/.profile
	sudo chomod +x /home/deck/.profile
fi

mkdir -p ~/.ryanrudolf &>/dev/null
if ! grep -qsFx "ryanrudolf/post_install_sdcard.sh" "/home/deck/.profile"; then

	SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
	sudo cp "$SCRIPT_DIR/post_install_sdcard.sh" ~/.ryanrudolf/post_install_sdcard.sh
	sudo chomod +x ~/.ryanrudolf/post_install_sdcard.sh

	cat >>/home/deck/.profile <<EOF
~/.ryanrudolf/post_install_sdcard.sh
EOF
fi

if ! service_exists sdcard_minimize_write; then
	# Make the Minimize writes script.
	cat >~/.ryanrudolf/sdcard_minimize_write.sh <<EOF
#!/bin/bash
for mountpoint in \$(mount | grep mmcblk0p | tr -s " " | cut -d " " -f 3)
do 
	mount -o rw,remount,noatime \$mountpoint
	echo \$mountpoint has been remounted with noatime flag.
done
swapoff /home/swapfile &> /dev/null
umount /run/media/deck/var &> /dev/null
exit 0
EOF

	sudo chmod +x ~/.ryanrudolf/sdcard_minimize_write.sh
	echo Script has been created!

	# Create a service to run the script.
	sudo rm /etc/systemd/system/sdcard_minimize_write.service
	cat <<EOF | sudo tee -a /etc/systemd/system/sdcard_minimize_write.service &>/dev/null
[Unit]
Description=Minimize writes to the sdcard - set noatime flag and disable swap.

[Service]
User=root
ExecStart=/home/deck/.ryanrudolf/sdcard_minimize_write.sh

[Install]
WantedBy=multi-user.target
EOF
	echo Service has been created: sdcard_minimize_write
fi

if ! service_exists microsd-umount; then
	# Create a service to unmount /run/media/var on startup.
	# This is to continue the update process with a reboot in update mode.
	# Modify from https://www.reddit.com/r/SteamDeck/comments/vn1nxt/how_to_install_steamos_to_the_microsd_card/
	sudo rm /etc/systemd/system/microsd-umount.service
	cat <<EOF | sudo tee -a /etc/systemd/system/microsd-umount.service &>/dev/null
[Unit]
Description=Attempts to unmount /run/media/var up to 10 times on startup.

[Service]
User=root
ExecStart=/bin/bash -c "for i in {0..9}; do if mountpoint -q -- /run/media/var; then umount /run/media/var; else sleep 1; fi; done"

[Install]
WantedBy=multi-user.target
EOF
	echo Service has been created: microsd-umount

	sudo systemctl enable sdcard_minimize_write
	sudo systemctl enable microsd-umount
	sudo systemctl start sdcard_minimize_write
	sudo systemctl start microsd-umount
	echo Services has been enabled and start.
fi

sudo steamos-readonly enable
exit 0
