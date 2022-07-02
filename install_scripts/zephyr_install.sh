#!/bin/bash

apt update -y
apt upgrade -y

wget https://apt.kitware.com/kitware-archive.sh
bash kitware-archive.sh

apt install -y --no-install-recommends git cmake ninja-build gperf \
  apt install -y -q udev \
  ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
  make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1

pip3 install --user -U west
echo 'export PATH=~/.local/bin:"$PATH"' >> ~/.zshrc
source ~/.zshrc
echo 'export PATH=~/.local/bin:"$PATH"' >> ~/.bashrc
source ~/.bashrc

west init ~/zephyrproject
cd ~/zephyrproject
west update

west zephyr-export

pip3 install --user -r ~/zephyrproject/zephyr/scripts/requirements.txt

cd ~
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.14.2/zephyr-sdk-0.14.2_linux-x86_64.tar.gz
wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.14.2/sha256.sum | shasum --check --ignore-missing
tar xvf zephyr-sdk-0.14.2_linux-x86_64.tar.gz

# cd zephyr-sdk-0.14.2
# ./setup.sh -y

# # cd /etc
# # mkdir udev
# cd ~/zephyr-sdk-0.14.2
