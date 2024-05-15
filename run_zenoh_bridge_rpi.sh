#!/bin/ash
export ROS_DISTRO=humble
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///var/lib/theconstruct.rrl/cyclonedds.xml

# Run the process
/zenoh-bridge-ros2dds -c /app/rpi_config.json5

echo "zenoh-bridge-ros2dds that captures RPi DDS messages has started."
