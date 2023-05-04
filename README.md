# Vicon wrapper for ROS2

This ros2 package can be used to stream data from a Vicon mocap system and publish it to custom ROS2 topics.
This repository has the following changes from the [original code base](https://github.com/OPT4SMART/ros2-vicon-receiver):
- IPs adapted to the My580 motion capture system
- Pose information is broadcast as a tf2

If you are using this repo and encounter any problems please report an issue! 

## Network setup

When connected via ethernet to the Vicon desktop computer, set the IP address manually to 
192.168.10.1. Use 255.255.255.0 for netmask and 192.168.10.1 for gateway. See [doc/3_network.png](doc/3_network.png) for a screenshot of the Ubuntu settings.

If there are no recognized objects in the Vicon area, it's normal that you don't receive any data. Data will start to be published once your object is registered and actively tracked inside the Vicon software.

In case you still do not receive any data, make sure that the Vicon machine is publishing, and to the correct IP. In particular, Vicon should be publishing via UDP object stream to 192.168.10.2. See [doc/1_vicon_settings.png](doc/1_vicon_settings.png) and [doc/2_vicon_udp.png](doc/2_vicon_udp.png) for where to find these settings.  

**Currently, the settings in Myhal 580 have changed to IP address 100.66.64.83 to enable use with Wifi router. Other settings (Buffer length, Port) remain unchanged.**

### Wireless Networking

To use the wireless router in MY580, connect the Vicon computer to the Wifi router using a network cable. Connect the machine with the vicon receiver to the wifi:

**Name:       ROB301**

**Password:   50002399**

The ros node should then be able to see the Vicon data.

## Instructions (from original repository)

**ros2-vicon-receiver** is a ROS2 package, written in C++, that retrieves data from Vicon software and publishes it on ROS2 topics. The code is partly derived from a mixture of [Vicon-ROS2](https://github.com/aheuillet/Vicon-ROS2) and [Vicon bridge](https://github.com/ethz-asl/vicon_bridge).

This is NOT an official ROS2 package and is not supported. The package has been successfully tested with ROS2 Dashing Diademata, ROS2 Foxy and ROS2 Galactic on the operating systems Ubuntu 18.04 Bionic Beaver, Ubuntu 20.04 Focal Fossa and MacOS 10.13 High Sierra.

## Requirements

### Installation of dependencies

If you are using Ubuntu 18.04 Bionic Beaver, you can install all the dependencies by simply `cd`'ing into the main project folder and then running
```
$ ./install_ubuntu_bionic.sh
```

Otherwise, proceed as follows. Make sure you have ROS2 installed (follow the instructions at the [ROS2 website](https://index.ros.org/doc/ros2/Installation/)).

Then, install [Colcon](https://colcon.readthedocs.io/en/released/index.html) and [CMake](https://cmake.org/) :
```
$ sudo apt install -y python3-colcon-common-extensions cmake
```

### Installation of Datastream SDK and other libraries

The Datastream SDK libraries are required to be installed in the system. You can find them on [the official website](https://www.vicon.com/software/datastream-sdk/?section=downloads).

This package is shipped with Datastream SDK 10.1 (the latest version at the time of writing). If you are running Linux x64 and you want to install this version, simply `cd` into the main project folder and issue the command
```
$ ./install_libs.sh
```

## Quick start

### Building the package

:warning: Do not forget to source the ROS2 workspace: `source /opt/ros/dashing/setup.bash`

Enter the project folder and build the executable
```
$ cd vicon_receiver
$ colcon build --symlink-install
```

### Running the program

Open a new terminal and source the project workspace:
```
$ source vicon_receiver/install/setup.bash
```

To run the program, use the [launch file template](vicon_receiver/launch/client.launch.py) provided in the package. First, open the file and edit the parameters. Running `colcon build` is not needed because of the `--symlink-install` option previously used.

Now you can the program with
```
$ ros2 launch vicon_receiver client.launch.py
```

Exit the program with CTRL+C.

### Information on ROS2 topics and messages

The **ros2-vicon-receiver** package creates a topic for each segment in each subject with the pattern `namespace/subject_name/segment_name`. Information is published on the topics as soon as new data is available from the vicon client (typically at the vicon client frequency). The message type [Position](vicon_receiver/msg/Position.msg) is used.

Example: suppose your namespace is the default `vicon` and you have two subjects (`subject_1` and `subject_2`) with two segments each (`segment_1` and `segment_2`). Then **ros2-vicon-receiver** will publish [Position](vicon_receiver/msg/Position.msg) messages on the following topics:
```
vicon/subject_1/segment_1
vicon/subject_1/segment_2
vicon/subject_2/segment_1
vicon/subject_2/segment_2
```

## Constributors
**ros2-vicon-receiver** is developed by
[Andrea Camisa](https://www.unibo.it/sitoweb/a.camisa),
[Andrea Testa](https://www.unibo.it/sitoweb/a.testa) and
[Giuseppe Notarstefano](https://www.unibo.it/sitoweb/giuseppe.notarstefano)

## Acknowledgements
This result is part of a project that has received funding from the European Research Council (ERC) under the European Union's Horizon 2020 research and innovation programme (grant agreement No 638992 - OPT4SMART).

<p style="text-align:center">
  <img src="logo_ERC.png" width="200" />
  <img src="logo_OPT4Smart.png" width="200" /> 
</p>
