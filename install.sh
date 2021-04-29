#!/bin/bash

# Prequisites
sudo apt update && sudo apt upgrade -y
sudo apt install -y vim git python3 python3-venv python3-pip wget htop tmux cron
cd ~
mkdir feec_qa
cd feec_qa

# install IPFS daemon
wget https://dist.ipfs.io/go-ipfs/v0.6.0/go-ipfs_v0.6.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.6.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh
ipfs init
cd ..

# install Robonomics
wget https://github.com/airalab/robonomics/releases/download/v0.24.0/robonomics-ubuntu-0.24.0-x86_64.tar.xz
tar -xvf robonomics-ubuntu-0.24.0-x86_64.tar.xz
sudo chmod +x robonomics
sudo cp robonomics /bin/

# Install RFID listener daemon
sudo apt install -y python3-dev gcc
USER=arseniiarsenii
REPO_NAME=robonomics-qa-reader-daemon
git clone https://github.com/${USER}/${REPO_NAME}.git EventToInternet
sudo mv EventToInternet /etc/systemd/system/
sudo chown -R root:root /etc/systemd/system/EventToInternet
cd /etc/systemd/system/EventToInternet
sudo python3 -m pip install -r requirements.txt
sudo bash install.sh

# Install AGENT
cd ~/feec_qa
sudo apt install -y vlc ffmpeg
git clone https://github.com/arseniiarsenii/robonomics_qa_geoscan.git
cd robonomics_qa_geoscan
python3 -m venv ./venv
source venv/bin/activate
pip install -r requirements.txt
deacivate

# Install BACKEND
cd ~/feec_qa
git clone https://github.com/arseniiarsenii/robonomics-qa-backend.git
cd robonomics-qa-backend
python3 -m venv ./venv
source venv/bin/activate
pip install -r requirements.txt
deactivate

# Post-installation actions
reboot
