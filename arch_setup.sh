#!/usr/bin/env zsh

# install git
sudo pacman -Syu
sudo pacman -S git
git config --global user.name "spomgee" && git config --global user.email "coding.guru16@gmail.com"

# install yay
sudo pacman -S base-devel
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $(whoami):$(whoami) ./yay-git
cd yay-git
makepkg -si

# install oh-my-zsh
RUNZSH='no' zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# configure oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/spomgee/config-files/main/.zshrcARCH -o ~/.zshrc
# install oh-my-zsh plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting && \
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install all necessary packages
## fonts
yay -S ttf-jetbrains-mono ttf-victor-mono-nerd ttf-mplus-nerd ttf-jetbrains-mono ttf-font-awesome ttf-material-icons ttf-remixicon ttf-icomoon-feather
## utils
yay -S kitty bpytop network-manager-applet xclipboard wget xplr cups colorgrab flameshot
## ricing graphics pkgs
yay -S xorg sddm i3-gaps i3-lock-color qt5-graphicaleffects qt5-quickcontrols2 polybar rofi rofi-power-menu-git rofi-emoji dunst light picom-jonaburg-git feh lxappearance cava ueberzug
## audio and bluetooth
yay -S pulseaudio-control pipewire pipewire-pulse pipewire-jack pipewire-audio pamixer npd ncmpcpp cava bluez bluez-utils blueberry blueman
## sdks and runtimes
yay -S rustup python python-pip jdk nodejs npm gcc dart-sass
## apps
yay -S nemo firefox-developer-edition google-chrome-dev discord vlc blender visual-studio-code-bin wireshark-gtk2 qbittorrent megasync-bin
## fun stuff
yay -S neofetch lolcat cowsay wisdom-mod fortune-mod fortune-mod-archlinux cbonsai bash-pipes

# ricing
## gtk theme
git clone https://github.com/stronk-dev/Tokyo-Night-Linux.git
cd Tokyo-Night-Linux
cp -a .config .xinitrc -t ~
sudo cp -a usr/share/themes/TokyoNight /usr/share/themes/
## sddm
echo "[Theme]\nCurrent=tokyo-night-sddm" | sudo tee /etc/sddm.conf
sudo systemctl enable sddm
## tokyo-night rice
git clone https://github.com/rototrash/dotfiles.git
cd dotfiles/home && git checkout tokyo-night
cp -a .Xresources .gtkrc-2.0 .scripts .local .config -t ~
mkdir ~/Pictures && cd ~/Pictures
git clone https://github.com/rototrash/wallpapers.git

# firefox
## startup Firefox to generate necessary directories
firefox-developer-edition & pid=$! && sleep 10 && kill $pid
## install userChrome.css
export FIREFOX_PROFILE="$(echo ~/.mozilla/firefox/*.dev-edition-default)" && \
curl -fsSL https://raw.githubusercontent.com/spomgee/config-files/main/userChrome.css -o userChrome.css && \
mkdir $FIREFOX_PROFILE/chrome/ && mv userChrome.css $FIREFOX_PROFILE/chrome/
## retrieve nightTab backup
mkdir ~/Desktop
curl -fsSL https://raw.githubusercontent.com/itSpongee/config-files/main/nightTab.json -o ~/Desktop/nightTab.json

# enable services
sudo systemctl enable --now bluetooth

# update shell & finish
yay & clear

echo "The following applications and configurations must be installed manually:\n
    * BlueStacks
    * Streamlabs OBS
    * Autodesk Fusion360
    * Google Drive
    * TI-Connect CE
    * Firefox nightTab (.json file located in ~/Desktop)
    * Firefox Color (black=(12, 15, 14), turquoise=(104, 243, 207))\n\n
    Start xorg using sddm."
    
source ~/.zshrc
