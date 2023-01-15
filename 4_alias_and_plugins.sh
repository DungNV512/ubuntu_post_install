#!/bin/bash

#auth:rzz0
# Tested linux: Ubuntu 22.04
# Making some useful alias
# Installing Zsh, make it default and install some useful plugins
# Installing powerlevel10k
# installing fonts to use with zsh
# ATTENTION:
## you will need: change font from your terminal to: MesloLGS NF
## you will need run: p10k configure
## this command is used to personalize your prompt.


sudo apt install -y zsh

# Add alias to .bashrc
echo '# '
echo '# Alias' >> ~/.bashrc
echo 'alias ls="exa --icons"' >> ~/.bashrc
echo 'alias bat="batcat --style=auto"' ~/.bashrc
echo 'alias ll="ls -alF"' ~/.bashrc
echo 'alias grep="grep --color=auto"' ~/.bashrc
echo 'alias ..="cd .."' >> ~/.bashrc
echo 'alias l="ls -CF"' >> ~/.bashrc
echo 'alias c="clear"' >> ~/.bashrc
echo 'alias h="history | grep"' >> ~/.bashrc
echo 'alias cp="cp -i"' >> ~/.bashrc
echo 'alias mv="mv -i"' >> ~/.bashrc
echo 'alias du="du -sh"' >> ~/.bashrc

# Install Oh My Zsh Automatic
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Oh My Zsh with this script
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
chsh -s $(which zsh)

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-docker ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-docker


# install fonts
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Create a fonts directory
mkdir -p $HOME/.local/share/fonts

# Download the fonts
wget -P $HOME/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -P $HOME/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -P $HOME/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -P $HOME/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Update font cache
fc-cache -f -v  > /dev/null 2>&1

# Enable plugins in .zshrc
sed -i 's/plugins=(git)/plugins=( command-not-found git dirhistory docker docker-compose history sudo zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-docker )/g' $HOME/.zshrc

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set powerlevel10k as the default theme
sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' $HOME/.zshrc

# Set zsh as default
chsh -s $(which zsh)

# Add alias to .zshrc
echo '# '
echo '# Alias' >> ~/.zshrc
echo 'alias ls="exa --icons"' >> ~/.zshrc
echo 'alias bat="batcat --style=auto"' >> ~/.zshrc
echo 'alias ll="ls -alF"' >> ~/.zshrc
echo 'alias grep="grep --color=auto"' >> ~/.zshrc
echo 'alias ..="cd .."' >> ~/.zshrc
echo 'alias l="ls -CF"' >> ~/.zshrc
echo 'alias c="clear"' >> ~/.zshrc
echo 'alias h="history | grep"' >> ~/.zshrc
echo 'alias cp="cp -i"' >> ~/.zshrc
echo 'alias mv="mv -i"' >> ~/.zshrc
echo 'alias du="du -sh"' >> ~/.zshrc


# End of Script
echo "We recommend you to restart your computer."
echo "Aditionlly, you need set your terminal font to MesloLGS NF"
echo "Go to terminal settings > profiles > select Custom Font > MesloLGS NF"
echo "We recommend yout to backup your system using Timeshift too."
echo "#"
echo "#"

while true; do
  echo "Select an option:"
  echo "1. Restart Computer"
  echo "2. Run the next script (./5_SystemUpdateUpgrade.sh)"
  echo "3. Exit"
  read response
  if [ $response = "1" ]; then
    # Restart the computer here
    sudo systemctl reboot
    break
  elif [ $response = "2" ]; then
    # Run the next script here
    ./5_SystemUpdateUpgrade.sh
    break
  elif [ $response = "3" ]; then
    echo "Exiting script..."
    break
  else
    echo "Invalid option. Please enter 1, 2, or 3"
  fi
done
