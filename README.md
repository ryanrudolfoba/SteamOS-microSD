# How to Install SteamOS to a MicroSD

<p align="center">
  <a href="https://github.com/ryanrudolfoba/SteamOS-microSD/blob/main/README.zh-TW.md">中文</a> |
  <span>English</span>
</p>

## About

This repository contains the instructions and scripts on how to install SteamOS to a microSD.

This will mostly benefit Steam Deck users who are using Windows primarily on the main internal SSD.

> **NOTE**\
> If you are going to use this script for a video tutorial, PLEASE reference on your video where you got the script! This will make the support process easier!
> And don't forget to give a shoutout to [@10MinuteSteamDeckGamer](https://www.youtube.com/@10MinuteSteamDeckGamer/) / ryanrudolf from the Philippines!
>

<b> If you like my work please show support by subscribing to my [YouTube channel @10MinuteSteamDeckGamer.](https://www.youtube.com/@10MinuteSteamDeckGamer/) </b> <br>
<b> I'm just passionate about Linux, Windows, how stuff works, and playing retro and modern video games on my Steam Deck! </b>
<p align="center">
<a href="https://www.youtube.com/@10MinuteSteamDeckGamer/"> <img src="https://github.com/ryanrudolfoba/SteamDeck-Clover-dualboot/blob/main/10minute.png"/> </a>
</p>

<b>Monetary donations are also encouraged if you find this project helpful. Your donation inspires me to continue research on the Steam Deck! Clover script, 70Hz mod, SteamOS microSD, Secure Boot, etc.</b>

<b>Scan the QR code or click the image below to visit my donation page.</b>

<p align="center">
<a href="https://www.paypal.com/donate/?business=VSMP49KYGADT4&no_recurring=0&item_name=Your+donation+inspires+me+to+continue+research+on+the+Steam+Deck%21%0AClover+script%2C+70Hz+mod%2C+SteamOS+microSD%2C+Secure+Boot%2C+etc.%0A%0A&currency_code=CAD"> <img src="https://github.com/ryanrudolfoba/SteamDeck-Clover-dualboot/blob/main/QRCode.png"/> </a>
</p>

## What does this script do?

- Install SteamOS to a microSD
- Setup sudo password for the deck account (as "deck").
- Delete microSD auto mount rules.
- Unmount the microSD partitions (/run/media/var) that SteamOS tries to mount it and fails during OS update process.
- Remount partitions as noatime mode to reduce microSD write operations.
- Disable swap.
- Run the above commands on every boot.
- It will work on next SteamOS update.
  > 20230326: Successfully update SteamOS to version 3.4.6
- All in one script!

## Warning

> **Warning**\
> The method only works if the internal SSD has no traces of SteamOS installed (dualboot or not).

If SteamOS is already installed on the internal SSD, the microSD tries to mount those partitions too causing it to fail to boot! Currently the post install script cannot fix it, as this happens on the first boot after the initial SteamOS update.

> **Warning**\
> If you have SteamOS installed on the internal SSD, DO NOT use this script.

Again,\
***If you have SteamOS installed on the internal SSD, DO NOT use this script.***

## Disclaimer

1. Do this at your own risk!
2. You **WILL** definitely lose all the data on microSD.\
   You **MAY** lose data inside machine if you do something wrong.
3. I will not be held responsible for data loss, broken microSDs etc.
4. This is only for educational and research purposes only.

## But Why?!?

Several reasons why I did this

1. Perform BIOS / firmware updates which are usually only available when on the SteamOS beta / preview branch.
2. Change to the beta / preview branch and perform testing without affecting the OS installed on the main drive.
3. I haven't seen anyone install SteamOS on a microSD in a "clean" way with updates working. The closest I can find involves cloning an existing install to a microSD.

## Requirements

1. [SteamOS Recovery Image](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3).
2. USB flash drive for Steam Recovery Image. Recommended size is at least 8GB USB3.
3. USB C hub / dock, keyboard and mouse. (Skip the USB C hub / dock if you are using a wireless keyboard and mouse).
4. Spare MicroSD plugged into the MicroSD slot - this is where SteamOS will be installed. Recommended size is at least 32GB A1 / A2 microSD.

## Instructions

> **Note**\
> If instructed to "Power off" the Steam Deck and then turn on, do not simply "Restart" it.\
> "Restart" will bypass the boot menu and will boot the OS installed on the internal SSD.

> **Warning**\
> The script will create a directory called .ryanrudolf. Don't delete this folder!\
> The script will set the sudo password for the deck account as "deck" (without the quotation marks)

1. [Follow this steps to create the official SteamOS Recovery image.](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3)
2. Once the SteamOS Recovery image is created, plug it in to the USB C port of the Steam Deck (or USB C hub / dock if you are using one).
3. While the Steam Deck is powered off, press the "VOLDOWN + POWER" button until you hear a chime.
4. The boot menu will appear, select the USB drive that contains the SteamOS Recovery image and press A button (or enter on the keyboard).
5. Wait until the SteamOS recovery image boots into the desktop.
6. Insert the microSD where SteamOS will be installed - make sure it is at least a 32GB A1 / A2 card.
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

11. Reimage in progress. This will take several minutes depending on the speed of the microSD.

    ![image](https://user-images.githubusercontent.com/98122529/210011958-4aa53d56-ec83-4dca-9a99-814719b10524.png)

12. Once the reimage is complete, press *CANCEL* on the prompt to *NOT* reboot the Steam Deck.

    ![image](https://user-images.githubusercontent.com/98122529/210012527-7f5ab7f4-d723-4091-93ec-589200d552a5.png)

## First Boot

1. While the Steam Deck is powered off, ***plug out the USB C drive that contains the SteamOS Recovery image.***
1. Press the "VOLDOWN + POWER" button until you hear a chime.
1. The boot menu will appear, select the microSD where SteamOS is installed and press A button (or enter on the keyboard).
1. Wait until SteamOS loads. This will take about 1-2minutes depending on the speed of the microSD.
1. Go through the Greetings - language, timezone and WiFi connection.
1. SteamOS will continue with the installation.

    > **Note**\
    > The "Remain 1 second." while installing is just a joke.\
    > I think that's calculated based on SSD, not microSD.\
    > So please wait until the installation is finished.

1. It may stock at "Starting Steam Deck update download". \
   Wait at least about 3 minutes.\
   If it's not progressing, *SHUTDOWN* the Steam Deck at the Steam menu, and then repeat the step 1-3.

1. It may stock at "Black screen with a VALVE logo" after shutdown and boot up.\
   This is part of the installation process, and it should take times.\
   Wait at least about 5 minutes.\
   If the fan has stopped functioning and you stock here, ***try pressing buttons A or B several times*** and waiting for a few minutes.\
   I'm not sure exactly why this issue occurs, but in my experience this works.

1. After the update progress is complete, you will be asked to login.\
   We're done!

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

### The buttons are not working while Greetings

I do not know why.\
In my case only the touch screen works.\
If you are unlucky, please connect the keyboard and mouse to operate it.

In my case this problem only happens when Greetings.\
After that everything works fine.

### /dev/mmcblk0p8 is mounted; will not make a filesystem here

![Screenshot_20230101_124055](https://user-images.githubusercontent.com/16995691/210184088-393afff4-673c-4266-8f47-4f6f2224d6f6.png)

The partitions are mounted before formatting during the installation process.\
This may happen when your microSD is formatted before and split into the same partition list.\
Use *fdisk* to delete all the partitions and create a new one. And then format it.\
This will prevent it from automatically mounting the partitions.

Just simply follow the next section.👇

### I just messed up my microSD. How to reset it?

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

2. Delete all the partitions on the microSD and created a new one.

    ```bash
    sudo fdisk /dev/mmcblk0
    ```

    > Use 'd' to delete partitions and 'n' to create a new one.\
    > Use 'w' to write the changes and exit.
    > I'm not going to explain in depth how to use fdisk.

3. Run mkfs.ext4 to format the partition created.

    ```bash
    sudo mkfs.ext4 /dev/mmcblk0p1
    ```

4. You can now go back to [instructions](#instructions) and start from step 9.
