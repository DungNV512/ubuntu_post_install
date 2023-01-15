#!/bin/bash

#auth:rzz0
#Tested linux: Ubuntu 22.04

# System Update
sudo apt update

# Must have apps
sudo apt install -y build-essential # software development tools
sudo apt install -y gparted # graphical partition editor
sudo apt install -y synaptic # graphical package manager
sudo apt install -y gufw # firewall configuration tool
sudo apt install -y hardinfo # system information and benchmark tool
sudo apt install -y baobab # disk usage analyzer
sudo apt install -y autokey-gtk # desktop automation utility
# sudo apt install -y virtualbox # virtualization software
sudo apt install -y neofetch # system information tool
sudo apt install -y htop # process monitoring tool
sudo apt install -y net-tools # network troubleshooting tools
sudo apt install -y ffmpeg # multimedia framework
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt-get install -y ttf-mscorefonts-installer # Microsoft fonts
sudo apt install -y flameshot # screenshot tool
sudo apt install -y adb # Android Debug Bridge
sudo apt install -y grub-customizer # GRUB bootloader configuration tool
sudo apt install -y scrcpy # Android screen mirroring tool
sudo apt install -y vlc # media player
sudo apt install -y numlockx # enable numlock on boot
sudo apt install -y inetutils-traceroute # network diagnosis tool
sudo apt install -y imwheel # mouse wheel configuration tool
sudo apt install -y tldr # simplified man pages
sudo apt install -y wget # file downloader
sudo apt install -y curl # data transfer tool
sudo apt install -y vim # text editor
sudo apt install -y qbittorrent # BitTorrent client
sudo apt install -y git # version control system

# Other apps:
sudo apt install -y clamav # antivirus software
sudo apt install -y clamav-daemon # antivirus daemon

# Preference apps
sudo apt install -y exa # modern replacement for 'ls' command
sudo apt install -y bat # cat clone with syntax highlighting
sudo apt install -y locate # file location tool

# Main tools of security
sudo apt install -y nmap # network exploration tool
sudo apt install -y tcpdump # packet capture tool
sudo apt install -y sqlmap # SQL injection tool
sudo apt install -y dirb # directory scanner
sudo apt install -y netcat # network utility
sudo apt install -y crunch # password list generator
sudo apt install -y whois # domain information tool
sudo apt install -y nikto # web server scanner
sudo apt install -y dnsenum # DNS information tool
sudo apt install -y iptables # firewall tool
sudo apt install -y whois # domain information tool

# sudo apt install -y discord # chat and voice communication app
sudo apt install -y filezilla # FTP client

# Finishing Things Up
## System Update and Upgrade
sudo apt update  > /dev/null 2>&1
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

## System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

# End of Script

# Display Installation Complete Message
echo "We will clear the terminal"
read -p "Press enter to continue"
clear
echo "All basic apps was installed."
echo "Recommend you to restart your computer and execute next script manually: ./3_download_and_install.sh"
echo "You can backup your system using Timeshift too."
echo "#"
echo "#"

while true; do
  echo "Select an option:"
  echo "1. Restart Computer"
  echo "2. Run the next script (./3_download_and_install.sh)"
  echo "3. Exit"
  read response
  if [ $response = "1" ]; then
    # Restart the computer here
    sudo systemctl reboot
    break
  elif [ $response = "2" ]; then
    # Run the next script here
    ./3_download_and_install.sh
    break
  elif [ $response = "3" ]; then
    echo "Exiting script..."
    break
  else
    echo "Invalid option. Please enter 1, 2, or 3"
  fi
done
