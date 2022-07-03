ARG FROM_IMAGE=zephyrprojectrtos/zephyr-build:latest
FROM $FROM_IMAGE
USER root
ENV DEBIAN_FRONTEND=noninteractive

RUN apt upgrade -y

RUN apt-get update -qq && apt-get install -y \
    python3-pip \
    curl \
    git \
    wget \
    git \
    cmake \
    ninja-build \
    udev \
    debconf-utils \
    gperf


WORKDIR /home
RUN mkdir setup
WORKDIR /home/setup

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN git clone https://github.com/15jgme/ros2_setup_scripts_ubuntu.git
WORKDIR /home/setup/ros2_setup_scripts_ubuntu
RUN ./run.sh
RUN rosdep init
RUN rosdep update

# Install microros
COPY install_scripts/microros_install.sh .
RUN chmod +x microros_install.sh
RUN ./microros_install.sh

