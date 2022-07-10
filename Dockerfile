ARG FROM_IMAGE=zephyrprojectrtos/zephyr-build:latest
FROM $FROM_IMAGE
USER root
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

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

WORKDIR /home/setup

# Source the ROS 2 installation
ENV ROS_DISTRO=foxy
RUN source /opt/ros/$ROS_DISTRO/setup.bash

# Create a workspace and download the micro-ROS tools
RUN mkdir microros_ws
WORKDIR /home/setup/microros_ws
RUN git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup &&\
# Update dependencies using rosdep
    apt update && rosdep update &&\
    rosdep install --from-paths src --ignore-src -y &&\
# Install pip
    apt-get install python3-pip 

RUN /bin/bash -c "chmod +x /opt/ros/foxy/setup.bash; source /opt/ros/foxy/setup.bash; colcon build;"
RUN rosdep fix-permissions
RUN /bin/bash -c "chmod +x install/local_setup.bash; source install/local_setup.bash; rosdep update;"
