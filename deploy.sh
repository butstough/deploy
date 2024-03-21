#!/usr/bin/bash

cd

git clone https://github.com/ilikenwf/apt-fast.git
sudo apt -y install aria2

sudo cp apt-fast/apt-fast /usr/sbin/
sudo cp files/apt-fast.conf /etc/
sudo cp apt-fast/apt-fast.comp /etc/bash_completion.d/apt-fast

sudo chmod +x /usr/sbin/apt-fast

sudo chown root:root /etc/apt-fast.conf
sudo chown root:root /usr/sbin/apt-fast
sudo chown root:root /etc/bash_completion.d/apt-fast

#. /etc/bash_completion

sudo apt update
sudo apt-fast -y upgrade
sudo apt autoremove -y


cd ~/deploy/ffmpeg
./build.sh


# add repos

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
sudo apt-fast -y install obs-studio firefox-trunk steam picard


# install standalone deb apps

# discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb








