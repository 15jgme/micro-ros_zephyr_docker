ARG FROM_IMAGE=osrf/ros:foxy-desktop
FROM $FROM_IMAGE
USER root

RUN apt upgrade -y

RUN apt-get update -qq && apt-get install -y \
    python3-pip \
    curl \
    git \
    wget \
    zsh \
    udev \
    git \
    cmake \
    ninja-build \
    gperf

WORKDIR /home
RUN mkdir setup
WORKDIR /home/setup

# Install zephyr
COPY install_scripts/zephyr_install.sh .
RUN chmod +x zephyr_install.sh
RUN ./zephyr_install.sh

COPY install_scripts/zephyr_install_b.sh .
RUN chmod +x zephyr_install_b.sh
RUN ./zephyr_install_b.sh

# Install microros
COPY install_scripts/microros_install.sh .
RUN chmod +x microros_install.sh
RUN ./microros_install.sh

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
