# Quick ROS  Install

This repository is having a simple bash script to install ROS Melodic and ROS2 Foxy



## Usage

You can just copy-paste the command below in your terminal for installing and uninstalling ROS Noetic. You have to enter your password while running the script. Execute the script as a normal user. 

Single line ROS 2 Humble Install for Ubuntu Jammy 22.04

```
wget -c https://raw.githubusercontent.com/KangHyoeun/ros_one_line_install/main/ros2_install_humble.sh && chmod +x ./ros2_install_humble.sh && ./ros2_install_humble.sh

```


Single line ROS 2 Foxy Install

```
wget -c https://raw.githubusercontent.com/KangHyoeun/ros_one_line_install/main/ros2_install_foxy.sh && chmod +x ./ros2_install_foxy.sh && ./ros2_install_foxy.sh

```

For docker user

```
apt-get install -y wget lsb && wget -c https://raw.githubusercontent.com/KangHyoeun/ros_one_line_install/main/ros2_install_foxy_docker.sh && chmod +x ./ros2_install_foxy_docker.sh && ./ros2_install_foxy_docker.sh

```


--------------------------------------------------------------------------
Single line ROS Melodic Install


```
wget -c https://raw.githubusercontent.com/KangHyoeun/ros_one_line_install/main/ros_install_melodic.sh && chmod +x ./ros_install_melodic.sh && ./ros_install_melodic.sh
```

