# 🔵️🐉️ Zenoh Bridge Docker for TurtleBot 4 🐉️🔵️

Follow [these instructions](https://hub.docker.com/repository/docker/theconstructai/zenoh-bridge-ros2dds/general) to setup.

Use this repo's `docker-compose.yaml` to deploy a zenoh solution for the TurtleBot4 (iRobot Create 3 + Raspberry Pi 4) that **aids discovery and integration with The Construct's Real Robot Lab service.**

This repo contains a docker image and compose file that runs the following:

* A docker container with 2 zenoh bridges (`zenoh_bridge_ros2dds`):
    1. Zenoh bridge to capture Create 3 DDS data.
    2. Zenoh bridge to capture Raspberry Pi 4 DDS data.

This setup ensures that the ROS 2 data published by the entire robot is seen as one.

---

## Base image 

The docker image is built on top of the official Zenoh Bridge ROS2 DDS image `eclipse/zenoh-bridge-ros2dds:latest`.