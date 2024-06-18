#!/bin/ash
export ROS_DISTRO=humble
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_DOMAIN_ID=0

# Path to the Zenoh configuration file
CONFIG_FILE="/app/rpi_config.json5"

# Run the process
/zenoh-bridge-ros2dds -c $CONFIG_FILE

echo "zenoh-bridge-ros2dds that captures RPi DDS messages has started."
