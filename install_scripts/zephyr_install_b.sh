#!/bin/bash

cd ~/zephyr-sdk-0.14.2
./setup.sh -t all

# cd /etc
# # mkdir udev
# cd ~/zephyr-sdk-0.14.2

cp -p ~/zephyr-sdk-0.14.2/sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d
# service udev restart
udevadm control --reload