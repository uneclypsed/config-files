#!/usr/bin/env zsh

# install git
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git
git config --global user.name "spomgee" && git config --global user.email "coding.guru16@gmail.com"

# install yay
sudo pacman -S --noconfirm base-devel
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $(whoami):$(whoami) ./yay-git
cd yay-git
makepkg -si

# install oh-my-zsh
RUNZSH='no' zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# configure oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/spomgee/config-files/main/.zshrcARCH -o ~/.zshrc

# ricing
## deps
yay -S --noconfirm ttf-jetbrains-mono-nerd ttf-victor-mono-nerd ttf-mplus-nerd ttf-jetbrains-mono ttf-font-awesome ttf-material-design-icons ttf-remixicon ttf-icomoon-feather
yay -S --noconfirm xorg sddm sddm-theme-tokyo-night i3-gaps qt5-graphicaleffects-git qt5-quickcontrols-git rustup kitty polybar rofi rofi-power-menu rofi-emoji dunst light picom-jonaburg-git i3lock-color feh bluez bluez-utils blueberry pulseaudio-control pavucontrol mpd ncmpcpp cava ueberzug w3m starship-git lxappearance kava neofetch lolcal cowsay wisdom-mod bash-pipes cbonsai bpytop network-manager-applet blueman clipit
sudo systemctl enable --now bluetooth
## gtk theme
git clone https://github.com/stronk-dev/Tokyo-Night-Linux.git
cd Tokyo-Night-Linux
cp -a .config .xinitrc .Xresources -t ~
cp -a usr/share/themes/TokyoNight /usr/share/themes/
## sddm
echo "[Theme]\nCurrent=tokyo-night-sddm" | sudo tee /etc/sddm.conf
sudo systemctl enable sddm
## tokyo-night rice
git clone https://github.com/rototrash/dotfiles.git
cd dotfiles/home && git checkout tokyo-night
cp -a .Xresources .gtkrc-2.0 .imwheelrc .scripts .local .config -t ~
mkdir ~/Pictures && cd ~/Pictures
git clone https://github.com/rototrash/wallpapers.git

# install oh-my-zsh plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting && \
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install all applications and cli tools
get python jdk nodejs npm gcc wget sass
get nemo xplr cups fortune-mod fortune-mod-archlinux colorgrab flameshot
get firefox-developer-edition google-chrome-dev discord zoom streamlabs-obs vlc blender autodesk-fusion360 visual-studio-code-bin wireshark qbittorrent ti-connect-ce google-drive megasync

# startup Firefox to generate necessary directories
firefox-developer-edition & pid=$! && sleep 10 && kill $pid

# install userChrome.css
export FIREFOX_PROFILE="$(echo ~/.mozilla/firefox/*.dev-edition-default)" && \
curl -fsSL https://raw.githubusercontent.com/spomgee/config-files/main/userChrome.css -o userChrome.css && \
mkdir $FIREFOX_PROFILE/chrome/ && mv userChrome.css $FIREFOX_PROFILE/chrome/

# retrieve nightTab backup
mkdir ~/Desktop
curl -fsSL https://raw.githubusercontent.com/itSpongee/config-files/main/nightTab.json -o ~/Desktop/nightTab.json

# update shell & finish
clear

echo "The following applications and configurations must be installed manually:\n
    * BlueStacks
    * Firefox nightTab (.json file located in ~/Desktop)
    * Firefox Color (black=(12, 15, 14), turquoise=(104, 243, 207))\n"
    
source ~/.zshrc
