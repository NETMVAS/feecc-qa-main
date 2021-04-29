#!/bin/bash

# Prequisites
sudo apt update && sudo apt upgrade -y
sudo apt install -y vim git python3 python3-venv python3-pip wget htop tmux cron

# install IPFS daemon
wget https://dist.ipfs.io/go-ipfs/v0.6.0/go-ipfs_v0.6.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.6.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/5050
ipfs init
cd ..

# install Robonomics
wget https://github.com/airalab/robonomics/releases/download/v0.24.0/robonomics-ubuntu-0.24.0-x86_64.tar.xz
tar -xvf robonomics-ubuntu-0.24.0-x86_64.tar.xz
sudo cp robonomics /bin/

# Install AGENT
sudo apt install -y vlc ffmpeg
cd Agent
python3 -m venv ./venv
source venv/bin/activate
pip install -r requirements.txt
deacivate
cd ..

# Install BACKEND
cd Backend
python3 -m venv ./venv
source venv/bin/activate
pip install -r requirements.txt
deactivate
cd ..

# Install systemd services
sudo cp services/* /etc/systemd/system/
sudo systemctl enable feecc-agent.service
sudo systemctl enable feecc-backend.service
sudo systemctl enable ipfs.service
sudo systemctl enable robonomics.service

# Install RFID listener daemon
sudo apt install -y python3-dev gcc
sudo mv EventToInternet /etc/systemd/system/
sudo chown -R root:root /etc/systemd/system/EventToInternet
cd /etc/systemd/system/EventToInternet
sudo python3 -m pip install -r requirements.txt
sudo bash install.sh

# Post-installation actions
echo 'Done. Rebooting now.'
sudo systemctl reboot
