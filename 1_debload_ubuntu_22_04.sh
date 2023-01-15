#!/bin/bash

#auth:rzz0
# Tested linux: Ubuntu 22.04

# Removing Snap from Ubuntu
echo "Removing Snaps from Ubuntu"
sudo snap remove snap-store # remove snap store, a software package management and distribution system for Linux
sudo snap remove gtk-common-themes # remove gtk common themes, a set of themes that work with the gtk+ toolkit
sudo snap remove gnome-3-34-1804 # remove gnome 3-34-1804, an open-source desktop environment
sudo snap remove core18 # remove core18, base of the snap system
sudo apt purge -y snapd #purge snapd, the service that runs and manages snaps on the system
echo "Snap and Snapd are removed"
sudo apt-mark hold snap snapd # hold the snap and snapd package from updating
echo "Snap/Snapd are now blocked from your Ubuntu"

# Removing ubuntu help
sudo apt --purge remove -y yelp # remove yelp, the gnome help browser
echo "Yelp doesn't help"

# Removing ubuntu games
sudo apt --purge remove -y aisleriot # remove aisleriot, a collection of card games for gnome
sudo apt --purge remove -y gnome-mahjongg # remove gnome-mahjongg, a solitaire version of the Chinese game
sudo apt --purge remove -y gnome-mines # remove gnome-mines, a minesweeper game
sudo apt --purge remove -y gnome-sudoku # remove gnome-sudoku, a sudoku game
echo "All games are removed from your Ubuntu"

# Removing gnome-software-plugin-snap
sudo apt purge gnome-software-plugin-snap -y # remove gnome-software-plugin-snap, plugin to enable gnome software to install snaps

# Removing seahorse
sudo apt --purge remove -y thunderbird # remove thunderbird, a mail and news client
sudo apt --purge remove -y shotwell # remove shotwell, a digital photo organizer
sudo apt --purge remove -y seahorse # remove seahorse, a gnome application for managing encryption keys

# Ubuntu spying
echo "Removing telemetry from your Ubuntu 22.04"
sudo apt purge evince -y # remove evince, a document viewer
echo "evince/documents removed"
sudo apt purge ubuntu-report popularity-contest apport whoopsie -y # remove telemetry related packages, these packages collect data about system usage and send it to Canoncial for analysis
echo "Yay ubuntu stoped spying on you"

# Other apps
echo "Removing other apps from your Ubuntu 22.04"
sudo apt --purge remove -y remmina #remove remmina, a remote desktop client
sudo apt --purge remove -y gimp #remove gimp, a photo editing software
sudo apt --purge remove -y simple-scan #remove simple-scan, a simple scanning utility

# System Update and Upgrade
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

# System Backup
echo "Installing timeshift for backup and restauration"
sudo apt-add-repository ppa:teejee2008/ppa -y
sudo apt update
sudo apt install -y timeshift

# System Clean Up
echo "Cleanup the system for restart"
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

# End of Script
echo "Clear the terminal"
read -p "Press enter to continue"

clear
echo "Recommend you to restart your computer and execute next script manually: ./2_basic_apps_to_install.sh"
echo "You can backup your system using Timeshift too."
echo "#"
echo "#"

while true; do
  echo "Select an option:"
  echo "1. Restart Computer"
  echo "2. Run the next script (./2_basic_apps_to_install.sh)"
  echo "3. Exit"
  read response
  if [ $response = "1" ]; then
    # Restart the computer here
    sudo systemctl reboot
    break
  elif [ $response = "2" ]; then
    # Run the next script here
    ./2_basic_apps_to_install.sh
    break
  elif [ $response = "3" ]; then
    echo "Exiting script..."
    break
  else
    echo "Invalid option. Please enter 1, 2, or 3"
  fi
done

