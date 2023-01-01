# How to Install SteamOS to a MicroSD

## About

This repository contains the instructions and scripts on how to install SteamOS to a microSD.

This will mostly benefit Steam Deck users who are using Windows primarily on the main internal SSD.

The script is divided into two parts - modified SteamOS recovery script that installs directly to the microSD, and a post install script to allow SteamOS updates and to minimize writes to the sdcard.

## Warning

> **Warning**\
> The method only works if the internal SSD has no traces of SteamOS installed (dualboot or not).

If SteamOS is already installed on the internal SSD, the microSD tries to mount those partitions too causing it to fail to boot! Currently the post install script cannot fix it, as this happens on the first boot after the initial SteamOS update. If you have SteamOS installed on the internal SSD, DO NOT use this script.


## Disclaimer

1. Do this at your own risk!
2. You **WILL** definitely lose all the data on SD card.\
   You **MAY** lose data inside machine if you done something wrong.
3. I will not be held responsible for data loss, broken sdcards etc etc.
4. This is only for educational and research purposes only.

## But Why?!?

Several reasons why I did this

1. Perform BIOS / firmware updates which are usually only available when on the SteamOS beta / preview branch.
2. Change to the beta / preview branch and perform testing without affecting the OS installed on the main drive.
3. I haven't seen anyone install SteamOS on a microSD in a "clean" way with updates working. The closest I can find involves cloning an existing install to a microSD.

## Requirements

1. SteamOS Recovery Image.
2. USB flash drive for Steam Recovery Image. Recommended size is at least 8GB USB3.
3. USB C hub / dock, keyboard and mouse. (Skip the USB C hub / dock if you are using a wireless keyboard and mouse).
4. Spare MicroSD plugged into the MicroSD slot - this is where SteamOS will be installed. Recommended size is at least 32GB A1 / A2 microSD card.

## Instructions

> **Note**\
> If instructed to "Power off" the Steam Deck and then turn on, do not simply "Restart" it.

1. [Follow this steps to create the official SteamOS Recovery image.](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3)
2. Once the SteamOS Recovery image is created, plug it in to the USB C port of the Steam Deck (or USB C hub / dock if you are using one).
3. While the Steam Deck is powered off, press the VOLDOWN + POWER button until you hear a chime.
4. The boot menu will appear, select the USB drive that contains the SteamOS Recovery image and press A button (or enter on the keyboard).
5. Wait until the SteamOS recovery image boots into the desktop.
6. Insert the microsd card where SteamOS will be installed - make sure it is at least a 32GB A1 / A2 card.
7. Connect the Steam Deck to your wifi connection.
8. Open konsole terminal and clone this repository into your home directory.

    ```bash
    cd
    git clone https://github.com/ryanrudolfoba/SteamOS-microSD.git
    ```

    ![image](https://user-images.githubusercontent.com/98122529/210011557-6ba7290d-96e2-4760-b33c-5c6c5b75c1f7.png)

9. Execute the script!

    ```bash
    ~/SteamOS-microSD/install_sdcard.sh
    ```

10. Press *Proceed* on the dialog prompt. Wait until the reimage is complete.

    ![image](https://user-images.githubusercontent.com/98122529/210011817-8d4a2495-8f75-44c3-95cb-2d0769f9d623.png)

11. Reimage in progress. This will take several minutes depending on the speed of the sdcard.

    ![image](https://user-images.githubusercontent.com/98122529/210011958-4aa53d56-ec83-4dca-9a99-814719b10524.png)

12. Once the reimage is complete, press *CANCEL* on the prompt to *NOT* reboot the Steam Deck.

    ![image](https://user-images.githubusercontent.com/98122529/210012527-7f5ab7f4-d723-4091-93ec-589200d552a5.png)

## Install Post Install Script

> **Note**\
> The post install script will create a directory called .ryanrudolf. Don't delete this folder!

> **Warning**\
> If you skip this step, You may fail at Geetings.\
> And you won't be able to perform SteamOS updates, unable to switch between STABLE / BETA / PREVIEW branches, and the precautions I put to minimize writes to the sdcard will not be implemented.

The post install script will set the sudo password for the deck account. It will be set as "deck" (without the quotation marks)

1. Check any mounted partitions by running `lsblk`.

1. Unmount any mounted partitions under /dev/mmcblk0.

    ![Screenshot_20230101_123542](https://user-images.githubusercontent.com/16995691/210184085-30417e05-a8ee-46ec-a8a5-86ab508752f3.png)

    ```bash
    sudo umount /dev/mmcblk0p6
    sudo umount /dev/mmcblk0p7
    sudo umount /dev/mmcblk0p8
    ```

1. Chroot into SteamOS.

    ```bash
    sudo ~/tools/repair_device.sh chroot
    ```

    *You should go into 'Part B'.*\
    ![210183869-79fa4649-305a-46c6-8565-41a00d8d6428](https://user-images.githubusercontent.com/16995691/210185821-b76240a1-7527-4036-8a11-75c379a65818.png)\
    If you are in part A run this command.

    ```bash
    steamos-chroot --disk /dev/mmcblk0 --partset B
    ```

1. Disable SteamOS read-only mode.

    ```bash
    steamos-readonly disable
    ```

    > **Warning**\
    > **DO NOT EXIT THE CHROOT SHELL HERE!** \
    > This *steamos-readonly* tool is buggy. It will enable read-only mode automatically but won't turn it to 'enable' state. Then you cannot disable it again because it's already in disabled state. And you cannot enable it because it's read-only. \
    > So we MUST enable it before exit.

1. Copy the post install script into profile.d

    **↓ OPEN ANOTHER KONSOLE to run this command ↓**

    ```bash
    sudo mkdir -p /run/media/root
    sudo mount /dev/mmcblk0p5 /run/media/root
    sudo cp ~/SteamOS-microSD/post_install_sdcard.sh /run/media/root/etc/profile.d/
    sudo umount /run/media/root
    exit
    ```

1. **Back to the chroot shell** and enable SteamOS read-only mode.

    ```bash
    steamos-readonly enable
    exit
    ```

1. Power off the Steam Deck and then proceed to First Boot.

## First Boot

1. While the Steam Deck is powered off, ***plug out the USB C drive that contains the SteamOS Recovery image.***
1. Press the VOLDOWN + POWER button until you hear a chime.
1. The boot menu will appear, select the microSD where SteamOS is installed and press A button (or enter on the keyboard).
1. Wait until SteamOS loads. This will take about 1-2minutes depending on the speed of the sdcard.
1. Go through the Greetings - language, timezone and WiFi connection.
1. SteamOS will continue with the installation. Wait until this is finished.

    > **Note**\
    > It may stock at "Starting Steam Deck update download". \
    Wait at least about 3 minutes.\
    If it's not progressing, shutdown the Steam Deck at the Steam menu, and then repeat the step 1-2.

1. Once completed the Steam Deck will automatically reboot and launch the OS installed on the internal SSD (Windows or SteamOS).
1. Power off the Steam Deck and then proceed to Post Install Instructions.

## Verification

1. Boot to Desktop Mode.
2. Open konsole terminal.
3. Verify that /var is only mounted once.

    df -h | grep var

    ![image](https://user-images.githubusercontent.com/98122529/210036264-fc56e052-7989-4064-a3f4-fa5e4887599d.png)

4. Verify that swap file TOTAL / USED / FREE shows 0.

    free -h | grep -vi mem

    ![image](https://user-images.githubusercontent.com/98122529/210036292-ad78e0fe-94f5-4156-b449-9e2afcb89836.png)

5. Verify that the microSD / mmcblk0 is mounted with noatime flag.

    mount | grep mmcblk0

    ![image](https://user-images.githubusercontent.com/98122529/210036335-4d50cbe3-e252-46c7-b605-73f6561d3cbb.png)

6. If everything looks good then congrats! SteamOS is now installed on your microSD!

![image](https://user-images.githubusercontent.com/98122529/210017005-6daddcf1-66af-4e69-afbf-364460c7ddd3.png)

## Updating from Stable > Beta > Preview etc etc

**Stable 3.4.4**
![image](https://user-images.githubusercontent.com/98122529/210036714-89bfe0e6-6497-46e5-a553-b65c76d624b4.png)

![image](https://user-images.githubusercontent.com/98122529/210036657-64f8463d-f644-4f79-84c9-f2deab4ca441.png)

**Preview / MAIN 3.5**
![image](https://user-images.githubusercontent.com/98122529/210037882-0e9c0ee0-9766-41e6-af6a-d31ec806bcd4.png)

![image](https://user-images.githubusercontent.com/98122529/210037947-5331a9f4-b4a8-4691-8eaf-45cf06774cdf.png)

![image](https://user-images.githubusercontent.com/98122529/210078810-16bf8b5f-5534-4439-891d-5cefcc58eee9.png)

![image](https://user-images.githubusercontent.com/98122529/210078972-06cb8f9f-234c-4bf9-b725-bede64101cfa.png)

## Trouble Shooting

### /dev/mmcblk0p8 is mounted; will not make a filesystem here

To ensure that the partitions are not mounted before they are formatted, we can utilize the 'mkfs' command during the installation process. \
This will prevent the recovery image OS from automatically mounting the partitions.

![Screenshot_20230101_124055](https://user-images.githubusercontent.com/16995691/210184088-393afff4-673c-4266-8f47-4f6f2224d6f6.png)

1. Umount all the partition mounted.

    > Usee `lsblk` to check if there is any.

    ```bash
    sudo umount /dev/mmcblk0p8
    sudo umount /dev/mmcblk0p7
    sudo umount /dev/mmcblk0p6
    sudo umount /dev/mmcblk0p5
    sudo umount /dev/mmcblk0p4
    sudo umount /dev/mmcblk0p3
    sudo umount /dev/mmcblk0p2
    sudo umount /dev/mmcblk0p1
    ```

2. Delete all the partitions on the microSD card and created a new one.

    ```bash
    sudo fdisk /dev/mmcblk0
    ```

    > Use 'd' to delete partitions and 'n' to create a new one.\
    > Use 'w' to write the changes and exit.
    > I'm not going to explain in depth how to use fdisk. \

3. Run mkfs.ext4 on the partition created.

    ```bash
    sudo mkfs.ext4 /dev/mmcblk0p1
    ```
