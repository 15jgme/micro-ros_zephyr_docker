#!/bin/bash

cd ~/zephyr-sdk-0.14.2
yes | ./setup.sh -t all -c

# cp -p ~/zephyr-sdk-0.14.2/sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d
# # service udev restart
# udevadm control --reload

#zephyr build vars
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.14.2