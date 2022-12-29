# How to Install SteamOS to a MicroSD

## About
This repository contains the instructions and scripts on how to install SteamOS to a microSD.

This will mostly benefit Steam Deck users who are using Windows primarily on the main internal SSD.

The script is divided into two parts - modified SteamOS recovery script that installs directly to the microSD, and a post install script to allow SteamOS updates and to minimize writes to the sdcard.


## Disclaimer
1. Do this at your own risk!
2. I will not be held responsible for data loss, broken sdcards etc etc.


## But Why?!?
Several reasons why I did this -

1. Perform BIOS / firmware updates which are usually only available when on the SteamOS beta / preview branch.
2. Change to the beta / preview branch and perform testing without affecting the OS installed on the main drive.
3. I haven't seen anyone install SteamOS on a microSD in a "clean" way. The closest I can find involves cloning an existing install to a microSD.


## Requirements
1. SteamOS Recovery Image.
2. USB flash drive for Steam Recovery Image. Recommended size is at least 8GB USB3.
3. USB C hub / dock, keyboard and mouse. (Skip the USB C hub / dock if you are using a wireless keyboard and mouse).
3. Spare MicroSD plugged into the MicroSD slot - this is where SteamOS will be installed. Recommended size is at least 32GB A1 / A2 microSD card.


## Instructions
1. [Follow this steps to create the official SteamOS Recovery image.](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3)
2. Once the SteamOS Recovery image is created, plug it in to the USB C port of the Steam Deck (or USB C hub / dock if you are using one).
3. While the Steam Deck is powered off, press the VOLDOWN + POWER button until you hear a chime.
4. The boot menu will appear, select the USB drive that contains the SteamOS Recovery image and press A button (or enter on the keyboard).
5. Wait until the SteamOS recovery image boots into the desktop.
6. Insert the microsd card where SteamOS will be installed - make sure it is at least a 32GB A1 / A2 card.
7. Connect the Steam Deck to your wifi connection.
8. Open konsole terminal and clone the repsitory that contains the scripts.

    git clone https://github.com/ryanrudolfoba/SteamOS-microSD.git
    
    ![image](https://user-images.githubusercontent.com/98122529/210011557-6ba7290d-96e2-4760-b33c-5c6c5b75c1f7.png)

  
9. Execute the script!

    cd SteamOS-microSD
    
    chmod +x install_sdcard.sh
    
    sudo ./install_sdcard.sh all
    
    ![image](https://user-images.githubusercontent.com/98122529/210011704-03fe588d-94fd-460e-8a5e-750dce98a7f0.png)

  
10. Press Proceed on the dialog prompt. Wait until the reimage is complete.

    ![image](https://user-images.githubusercontent.com/98122529/210011817-8d4a2495-8f75-44c3-95cb-2d0769f9d623.png)

11. Reimage in progress. This will take several minutes depending on the speed of the sdcard.

    ![image](https://user-images.githubusercontent.com/98122529/210011958-4aa53d56-ec83-4dca-9a99-814719b10524.png)

12. Once the reimage is complete, press CANCEL on the prompt and then power off the Steam Deck.

    ![image](https://user-images.githubusercontent.com/98122529/210012527-7f5ab7f4-d723-4091-93ec-589200d552a5.png)



## First Boot
1.
2.
3.
4.
5.


## Post Install Instructions
1. While the Steam Deck is powered off, press the VOLDOWN + POWER button until you hear a chime.
2.
3.
4.
5.
