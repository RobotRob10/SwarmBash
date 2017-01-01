#!/bin/bash

#This script runs the first-time setup for the CSUCI Swarmathon.

#Install ROS Indigo
sudo -u ubuntu echo "!!!!!Install ROS Indigo"
#add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt-get update
apt-get install ros-indigo-desktop-full

#Install additional plugins
sudo -u ubuntu echo "!!!!!Install additional plugins"
apt-get install ros-indigo-robot-localization
apt-get install ros-indigo-hector-gazebo-plugins
apt-get install ros-indigo-joystick-drivers

#Install git
sudo -u ubuntu echo "!!!!!!Install git"
apt-get install git

#Install Repository
sudo -u ubuntu echo "!!!!!Install repo"
cd ~
sudo -u ubuntu git clone https://github.com/BCLab-UNM/Swarmathon-CSUCI.git
sudo -u ubuntu mv ~/Swarmathon-CSUCI ~/rover_workspace2
sudo -u ubuntu cd ~/rover_workspace2

#Setup ublox GPS submodule
sudo -u ubuntu echo "!!!!!ublox GPS submodule"
sudo -u ubuntu git submodule init
sudo -u ubuntu git submodule update

#Establish ROS catkin workspace
sudo -u ubuntu echo "!!!!!ROS catkin workspace"
if ! grep -q "source /opt/ros/indigo/setup.bash" ~/.bashrc
then 
  sudo -u ubuntu echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
fi
sudo -u ubuntu source ~/.bashrc
sudo -u ubuntu catkin_make

#Update bash session
sudo -u ubuntu echo "!!!!!Update bash session"
sudo -u ubuntu echo "source ~/rover_workspace2/devel/setup.bash" >> ~/.bashrc
sudo -u ubuntu source ~/.bashrc
sudo -u ubuntu echo "export GAZEBO_MODEL_PATH=~/rover_workspace2/simulation/models" >> ~/.bashrc
sudo -u ubuntu echo "export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:~/rover_workspace2/devel/lib/" >> ~/.bashrc
sudo -u ubuntu source ~/.bashrc

#Run simulation
#echo "!!!!!Run simulation"
#chmod +x ./run.sh
#./run.sh
