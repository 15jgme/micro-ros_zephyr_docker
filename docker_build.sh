#!/bin/bash

docker build -t micro-ros_zephyr --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) . 