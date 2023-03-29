#!/bin/bash

DIR="/usr/lib/"
DIR="$HOME/mambaforge/envs/ros_humble/lib/"

echo $DIR

echo "Installing shared libraries to $DIR, please wait"
for f in libViconDataStreamSDK_CPP.so libboost_system-mt.so.1.58.0 libboost_thread-mt.so.1.58.0 libboost_timer-mt.so.1.58.0 libboost_chrono-mt.so.1.58.0 
do
  sudo cp "DataStreamSDK_10.1/$f" "$DIR"
  sudo chmod 0755 "$DIR/$f"
  echo "."
done

sudo ldconfig
echo "."
echo "Installlation finished"
