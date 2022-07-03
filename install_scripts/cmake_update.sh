#!/bin/bash

apt remove -y --purge --auto-remove cmake
apt update -y && \
apt install -y software-properties-common lsb-release && \
apt clean all

wget -O - https://apt.kitware.com/keys/kitware-archiv

apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"

apt update -y
apt install kitware-archive-keyring -y
rm /etc/apt/trusted.gpg.d/kitware.gpg

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6AF7F09730B3F0A4

apt update -y
apt install cmake -y