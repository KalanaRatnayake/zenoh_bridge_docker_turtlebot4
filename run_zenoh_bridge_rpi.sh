#!/bin/ash
export ROS_DISTRO=humble
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///var/lib/theconstruct.rrl/cyclonedds.xml
export ROS_DOMAIN_ID=1

# Get the IP address from the environment variable
RPI4_IP=${RPI4_IP:-}
if [ -z "$RPI4_IP" ]; then
    echo "Error: RPI4_IP environment variable is not set."
    exit 1
fi

# Path to the Zenoh configuration file
CONFIG_FILE="/app/rpi_config.json5"

# Replace the placeholder in the configuration file
sed -i "s/__RPI4_IP_PLACEHOLDER__/$RPI4_IP/g" $CONFIG_FILE

# Run the process
/zenoh-bridge-ros2dds -c $CONFIG_FILE

echo "zenoh-bridge-ros2dds that captures RPi DDS messages has started."
