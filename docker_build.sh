#!/bin/bash

cp ~/.bashrc .
cp ~/.zshrc .
# cp ~/.oh-my-zsh .

docker build -t micro-ros_zephyr .