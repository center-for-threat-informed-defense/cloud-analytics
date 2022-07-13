#!/bin/bash

CALDERA_TAG="4.0.0-beta"
# install deps
sudo apt-get install -y byobu python-dev libpython3.8-dev unzip gcc software-properties-common python3-venv

# caldera sandcat requires go 1.17, ubuntu 20 only provides 1.13, install 1.18 from backports repo
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install -y golang-go

# create and activate venv
cd ${HOME} || exit
python3 -m venv appenv
source appenv/bin/activate

# install wheel dependency
python -m pip install wheel

# checkout caldera
git clone https://github.com/mitre/caldera.git --recursive --branch ${CALDERA_TAG}
cd caldera/ || exit
python -m pip install -r requirements.txt

# downgrade markupsafe version to avoid unicode import error
python -m pip install markupsafe==2.0.1

python server.py --insecure &

sleep 60

exit

# Caldera will be started by systemd
