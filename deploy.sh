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


sudo apt update
sudo apt-fast -y upgrade
sudo apt autoremove -y


cd ~/deploy/ffmpeg
./build.sh


# add repos

# enable 32 bit
sudo dpkg --add-architecture i386

# wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key "https://dl.winehq.org/wine-builds/winehq.key"
sudo wget -NP /etc/apt/sources.list.d/ "https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources"


# multiverse (needed for steam)
sudo add-apt-repository -y multiverse

# obs studio
sudo add-apt-repository -y ppa:obsproject/obs-studio

# firefox nightly
sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa

# musicbrainz
sudo add-apt-repository -y ppa:musicbrainz-developers/stable

# install new apps from repos
sudo apt update
sudo apt-fast -y install --install-recommends obs-studio firefox-trunk steam picard winehq-stable


# install standalone deb apps

# discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb








