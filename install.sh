# Install general dependencies
sudo apt install zsh python psmisc xserver-xorg-core x11-xserver-utils x11-utils imagemagick \
ffmpeg wireless-tools openbox pulseaudio alsa-utils brightnessctl nitrogen dunst tint2   \
lxpolkit rxvt-unicode xclip scrot mpd mpc thunar thunar-archive-plugin thunar-volman     \
ffmpegthumbnailer tumbler w3m w3m-img ncmpcpp viewnior mpv pavucontrol parcellite        \
gsimplecal neofetch htop xsettingsd xautolock rofi rsync -y

# Intall picom dependencies
sudo apt install meson ninja-build libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev        \
libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev    \
libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev \
libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev -y

# Compile picom
git clone https://github.com/yshui/picom.git          && \
cd picom/ && git submodule update --init --recursive  && \
git checkout 9cb552ecd91ec644bf6fcb558ddd44fda5b4f7d9 && \
meson --buildtype=release . build                     && \
ninja -C build                                        && \
ninja -C build install

# Go to Documents directory and clone owl4ce's repository
cd ~/Documents/ && git clone --depth 1 https://github.com/owl4ce/dotfiles.git

# Installation with rsync
rsync -avxHAXP --exclude '.git*' --exclude 'LICENSE' --exclude '*.md' dotfiles/ ~/

# Install icon theme
pushd ~/.icons/ && \
    tar -xJf Papirus-Custom.tar.xz && tar -xJf Papirus-Dark-Custom.tar.xz && \
    sudo ln -vs ~/.icons/Papirus-Custom /usr/share/icons/
    sudo ln -vs ~/.icons/Papirus-Dark-Custom /usr/share/icons/
popd

# Refresh font cache
fc-cache -rv

# Update MPD database
[ -n "$(pgrep mpd)" ] || mpd && mpc update

# Give privileges to brightnessctl
sudo chmod u+s $(command -v brightnessctl)

# Symlink sh to bash
[ "$(readlink -f /bin/sh)" != "$(command -v bash)" ] && sudo ln -vfs $(command -v bash) /bin/sh

# 
# exec openbox-session

# Get user's home directory = $HOME