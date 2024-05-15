#!/bin/ash
export ROS_DISTRO=humble
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///var/lib/theconstruct.rrl/cyclonedds.xml

# Get the IP address from the environment variable
RPI4_IP=${RPI4_IP:-}
if [ -z "$RPI4_IP" ]; then
    echo "Error: RPI4_IP environment variable is not set."
    exit 1
fi

# Path to the Zenoh configuration file
CONFIG_FILE="/app/rpi_config.json5"

# Run the process
/zenoh-bridge-ros2dds -c $CONFIG_FILE

echo "zenoh-bridge-ros2dds that captures RPi DDS messages has started."
