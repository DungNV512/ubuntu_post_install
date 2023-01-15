#!/bin/bash

#auth:rzz0
# Tested linux: Ubuntu 22.04
# Apps the script will install:
# Install google chrome, virtualbox, dbeaver-ce, mongodb-compass, zoom
# sublime-text, AWS-CLI, VSCode, Microsoft Teams, Docker
# Downloaded files: ~/Downloads
# Anaconda will be downloaded but not will installed


# System Update
sudo apt update > /dev/null 2>&1

# Create the Downloads directory if it doesn't exist
mkdir -p ~/Downloads

declare -A programs_urls
programs_urls=(
    ["google-chrome-stable"]="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    ["virtualbox-7.0"]="https://download.virtualbox.org/virtualbox/7.0.4/virtualbox-7.0_7.0.4-154605~Ubuntu~jammy_amd64.deb"
    ["dbeaver-ce"]="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
    ["mongodb-compass"]="https://downloads.mongodb.com/compass/mongodb-compass_1.35.0_amd64.deb"
    ["zoom"]="https://zoom.us/client/5.13.4.711/zoom_amd64.deb"
)

for program in "${!programs_urls[@]}"; do
    if dpkg -s "$program" > /dev/null 2>&1; then
        echo "$program is already installed."
    else
        echo "$program is not installed. Downloading and installing..."
        
        wget -P ~/Downloads -c "${programs_urls[$program]}"
        sudo apt install -y ~/Downloads/$(basename "${programs_urls[$program]}")
    fi
done

# Function to check if a program is installed
check_installed() {
  if command -v $1 >/dev/null 2>&1; then
    echo "$1 is already installed"
  else
    echo "$1 is not installed"
    return 1
  fi
}

# Install Sublime Text
check_installed "sublime-text"
if [ $? -ne 0 ]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install sublime-text > /dev/null 2>&1
fi

# Download Anaconda installation script
if [ ! -f ~/Downloads/Anaconda3-2022.10-Linux-x86_64.sh ]; then
  wget -P ~/Downloads -c "https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh"
fi

# Download and install AWS CLI v2
check_installed "aws"
if [ $? -ne 0 ]; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip > /dev/null 2>&1
  sudo ./aws/install
fi

# Download and install Visual Studio Code
check_installed "code"
if [ $? -ne 0 ]; then
  sudo apt install apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update > /dev/null 2>&1
  sudo apt install code
fi

# Install Microsoft Teams
check_installed "teams"
if [ $? -ne 0 ]; then
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
  sudo apt update > /dev/null 2>&1
  sudo apt install teams > /dev/null 2>&1
fi

# Installing Docker
## Removing ond versions
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update  > /dev/null 2>&1
sudo apt-get install -y ca-certificates gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings

if [ ! -f "/etc/apt/keyrings/docker.gpg" ]; then
    echo "Adding Docker GPG key to apt keyring"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
else
    echo "Docker GPG key already exists in apt keyring"
fi

if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
    echo "Adding Docker repository to apt sources"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
else
    echo "Docker repository already exists in apt sources"
fi

sudo apt-get update  > /dev/null 2>&1
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER

## System Update and Upgrade
sudo apt update > /dev/null 2>&1
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

## System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean


# End of Script
echo "We will clear the terminal"
read -p "Press enter to continue"

clear
echo "We recommend you to restart your computer and execute next script manually: ./4_personal_configuration.sh"
echo "You can backup your system using Timeshift too."
echo "#"
echo "#"

while true; do
  echo "Select an option:"
  echo "1. Restart Computer"
  echo "2. Run the next script (./4_personal_configuration.sh)"
  echo "3. Exit"
  read response
  if [ $response = "1" ]; then
    # Restart the computer here
    sudo systemctl reboot
    break
  elif [ $response = "2" ]; then
    # Run the next script here
    ./4_alias_and_plugins.sh
    break
  elif [ $response = "3" ]; then
    echo "Exiting script..."
    break
  else
    echo "Invalid option. Please enter 1, 2, or 3"
  fi
done

