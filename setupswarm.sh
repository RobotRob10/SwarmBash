#!/bin/bash

#Install ROS Indigo
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo apt-get update
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get -y install ros-indigo-desktop-full

#Install additional plugins
sudo apt-get -y install ros-indigo-robot-localization
sudo apt-get -y install ros-indigo-hector-gazebo-plugins
sudo apt-get -y install ros-indigo-joystick-drivers

#Install git
sudo apt-get -y install git

#Install Repository
cd ~
git clone https://github.com/BCLab-UNM/Swarmathon-CSUCI.git
mv ~/Swarmathon-CSUCI ~/rover_workspace
cd ~/rover_workspace

#Setup ublox GPS submodule
git submodule init
git submodule update

#Establish ROS catkin workspace
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc
catkin_make

#Update bash session
echo "source ~/rover_workspace/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
echo "export GAZEBO_MODEL_PATH=~/rover_workspace/simulation/models" >> ~/.bashrc
echo "export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:~/rover_workspace/devel/lib/" >> ~/.bashrc
source ~/.bashrc

#Run simulation
chmod +x ./run.sh
./run.sh
