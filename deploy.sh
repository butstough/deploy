#!/usr/bin/bash

cd ~

git clone https://github.com/ilikenwf/apt-fast.git
sudo apt -y install --install-recommends aria2

sudo cp apt-fast/apt-fast /usr/sbin/
sudo cp files/apt-fast.conf /etc/
sudo cp apt-fast/completions/bash/apt-fast.comp /etc/bash_completion.d/apt-fast

sudo chmod +x /usr/sbin/apt-fast

sudo chown root:root /etc/apt-fast.conf
sudo chown root:root /usr/sbin/apt-fast
sudo chown root:root /etc/bash_completion.d/apt-fast

source ~/.profile

# install standalone deb apps

cd ~

# discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb

# add repos

# multiverse (needed for steam)
sudo add-apt-repository -y multiverse

# firefox nightly
sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa

# musicbrainz
sudo add-apt-repository -y ppa:musicbrainz-developers/stable

#chatterino
sudo add-apt-repository -y ppa:chatterino/chatterino2

# update system and install new software through apt
sudo apt update
# install sign-ins and editor
sudo apt-fast -y install --install-recommends chatterino firefox-trunk steam vim
# update the system software
sudo apt-fast -y upgrade

# install amdgpu driver
# shoutouts chat gippity for this magic 
./amdgpu.sh

# install other software
sudo apt-fast -y install --install-recommends inotify-tools picard winehq-stable
# post-install autoremove
sudo apt autoremove -y

# build and install ffmpeg
cd ~/deploy/ffmpeg
./build.sh
# obs studio
sudo add-apt-repository -y ppa:obsproject/obs-studio
# install obs
sudo apt update
sudo apt-fast -y install --install-recommends obs-studio

# enable 32 bit
sudo dpkg --add-architecture i386

# wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key "https://dl.winehq.org/wine-builds/winehq.key"
sudo wget -NP /etc/apt/sources.list.d/ "https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources"

