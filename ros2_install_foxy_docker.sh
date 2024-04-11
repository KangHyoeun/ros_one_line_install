#!/bin/bash -eu

# The BSD License
# Copyright (c) 2023 Qbotics Labs Pvt Ltd
# Copyright (c) 2014 OROCA and ROS Korea Users Group

#set -x

name_ros_distro=foxy 
user_name=$(whoami)
echo "#######################################################################################################################"
echo ""
echo ">>> {Starting ROS 2 Foxy Installation}"
echo ""
echo ">>> {Checking your Ubuntu version} "
echo ""
#Getting version and release number of Ubuntu
version=`lsb_release -sc`
relesenum=`grep DISTRIB_DESCRIPTION /etc/*-release | awk -F 'Ubuntu ' '{print $2}' | awk -F ' LTS' '{print $1}'`
echo ">>> {Your Ubuntu version is: [Ubuntu $version $relesenum]}"
#Checking version is Focal, if yes proceed othervice quit
case $version in
  "focal" )
  ;;
  *)
    echo ">>> {ERROR: This script will only work on Ubuntu Focal (20.04).}"
    exit 0
esac

echo ""
echo ">>> {ROS 2 Foxy is fully compatible with Ubuntu Focal 20.04}"
echo ""
echo "#######################################################################################################################"
echo ">>> {Step 1: Configure your Ubuntu repositories}"
echo ""
#Configure your Ubuntu repositories to allow "restricted," "universe," and "multiverse." You can follow the Ubuntu guide for instructions on doing this. 
#https://help.ubuntu.com/community/Repositories/Ubuntu


locale  # check for UTF-8

apt update 
apt install -y locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings


##############################################################


apt install -y software-properties-common
add-apt-repository universe

echo ""
echo ">>> {Done: Added Ubuntu repositories}"
echo ""
echo "#######################################################################################################################"
echo ">>> {Step 2: Set up your keys}"
echo ""
echo ">>> {Installing curl for adding keys}"
#Installing curl: Curl instead of the apt-key command, which can be helpful if you are behind a proxy server: 
#TODO:Checking package is not working sometimes, so disabling it
#Checking curl is installed or not
#name=curl
#which $name > /dev/null 2>&1

#if [ $? == 0 ]; then
#    echo "Curl is already installed!"
#else
#    echo "Curl is not installed,Installing Curl"


apt update 
apt install -y curl openssl


#fi

echo "#######################################################################################################################"
echo ""
#Adding keys
echo ">>> {Waiting for adding keys, it will take few seconds}"
echo ""
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

#Checking return value is OK
#case $ret in
#  "OK" )
#  ;;
#  *)
#    echo ">>> {ERROR: Unable to add ROS Foxy keys}"
#    exit 0
#esac

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null


echo ">>> {Done: Added Keys}"
echo ""
echo "#######################################################################################################################"
echo ">>> {Step 4: Updating Ubuntu package index, this will take few minutes depend on your network connection}"
echo ""
apt update
apt upgrade 

echo ""
echo "#######################################################################################################################"
echo ">>> {Step 5: Install ROS, you pick how much of ROS you would like to install.}"
echo "     [1. Desktop Install(Recommended): ROS, RViz, demos, tutorials.]"
echo ""
echo "     [2. ROS-Base: (Bare Bones) Communication libraries, message packages, command line tools. No GUI tools.]"
echo ""
#Assigning default value as 1: Desktop install
read -p "Enter your install (Default is 1):" answer 

case "$answer" in
  1)
    package_type="desktop"
    ;;
  2)
    package_type="ros-base"
    ;;    
  * )
    package_type="desktop"
    ;;
esac
echo "#######################################################################################################################"
echo ""
echo ">>>  {Starting ROS installation, this will take about 20 min. It will depends on your internet  connection}"
echo ""
apt-get install -y ros-${name_ros_distro}-${package_type} python3-argcomplete
apt install -y ros-dev-tools
echo ""
echo ""
echo "#######################################################################################################################"
echo ">>> {Step 6: Setting ROS Environment, This will add ROS environment to .bashrc.}" 
echo ">>> { After adding this, you can able to access ROS commands in terminal}"
echo ""
echo "source /opt/ros/${name_ros_distro}/setup.bash" >> /home/$user_name/.bashrc
source /home/$user_name/.bashrc
echo ""
echo "#######################################################################################################################"
echo ">>> {Step 7: Testing ROS installation, checking ROS version.}"
echo ""
echo ">>> {Type [printenv ROS_DISTRO] to get the current ROS installed version}"
echo ""
printenv ROS_DISTRO
echo "#######################################################################################################################"

