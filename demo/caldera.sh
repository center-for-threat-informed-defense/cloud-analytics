# install deps
sudo apt-get install -y byobu python-dev libpython3.8-dev unzip gcc software-properties-common

# caldera sandcat requires go 1.17, ubuntu 20 only provides 1.13, install 1.18 from backports repo
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install -y golang-go

# create and activate venv
python3 -m venv appenv
source appenv/bin/activate

# install wheel dependency
python -m pip install wheel

# checkout caldera
git clone https://github.com/mitre/caldera.git --recursive
cd caldera/
python -m pip install -r requirements.txt

# start caldera
python server.py --insecure
