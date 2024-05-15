#!/bin/ash
export ROS_DISTRO=humble
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
unset CYCLONEDDS_URI
# Run the process

/zenoh-bridge-ros2dds -c /app/create3_config.json5

echo "zenoh-bridge-ros2dds that captures create3 DDS messages has started."
