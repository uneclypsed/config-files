#!/usr/bin/env zsh

# install git
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git

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
yay -S --noconfirm nerd-fonts-jetbrains-mono nerd-fonts-victor-mono nerd-fonts-mplus ttf-jetbrains-mono ttf-font-awesome ttf-material-design-icons ttf-remixicon ttf-icomoon-feather
yay -S --noconfirm xorg sddm i3-gaps qt5-graphicaleffects-git qt5-quickcontrols-git rustup kitty polybar rofi rofi-power-menu rofi-emoji dunst light picom-jonaburg-git i3lock-color feh bluez bluez-utils blueberry pulseaudio-control pavucontrol mpd ncmpcpp cava ueberzug w3m starship-git lxappearance kava neofetch lolcal cowsay wisdom-mod bash-pipes cbonsai bpytop network-manager-applet blueman clipit
## gtk theme
git clone https://github.com/stronk-dev/Tokyo-Night-Linux.git
cd Tokyo-Night-Linux
cp -a .config .xinitrc .Xresources -t ~
cp -a usr/share/themes/TokyoNight /usr/share/themes/
## sddm
sudo systemctl enable sddm
git clone https://github.com/rototrash/tokyo-night-sddm.git ~/tokyo-night-sddm
sudo mv ~/tokyo-night-sddm /usr/share/sddm/themes/
echo `sudo nano /etc/sddm.conf\n---\n[Theme]\nCurrent=tokyo-night-sddm` > /etc/sddm.conf
## tokyo-night rice
sudo systemctl enable --now bluetooth
git clone https://github.com/rototrash/dotfiles.git
cd dotfiles/home && git checkout tokyo-night
cp -a .Xresources .gtkrc-2.0 .imwheelrc .scripts .local .config -t ~

# install oh-my-zsh plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting && \
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
