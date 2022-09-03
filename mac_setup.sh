#!/usr/bin/env bash

# First, install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install all applications and cli tools
brew install python openjdk git node npm gcc wget &&
brew install --cask steam minecraft firefox-developer-edition google-chrome-dev microsoft-edge discord skype zoom eqmac streamlabs-obs vlc adobe-creative-cloud blender autodesk-fusion360 visual-studio-code github unity vmware-fusion wireshark qbittorrent ti-connect-ce google-drive vitalsource-bookshelf clickup 

# configure git
git config --global user.name "spongee" && git config --global user.email "coding.guru16@gmail.com"

# install & oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# configure oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/itSpongee/config-files/main/.zshrcMAC -o ~/.zshrc

# install oh-my-zsh plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting &&
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install userChrome.css
curl -fsSL https://raw.githubusercontent.com/itSpongee/config-files/main/userChrome.css -o ~/Library/Application\ Support/Firefox/Profiles/*.dev-edition-default/chrome/userChrome.css

# retrieve nightTab backup
curl -fsSL https://raw.githubusercontent.com/itSpongee/config-files/main/nightTab.json -o ~/Desktop/nightTab.json

# update shell & finish
source ~/.zshrc && clear

echo "The following applications and configurations must be installed manually:\n
    * XCode\n
    * VEXCode V5\n
    * VEXCode V5 Pro\n
    * BlueStacks\n
    * Microsoft OneNote\n
    * Firefox nightTab (.json file located in ~/Desktop)"