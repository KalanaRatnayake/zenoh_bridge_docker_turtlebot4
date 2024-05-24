# 🔵️🐉️ Zenoh Bridge Docker for TurtleBot 4 🐉️🔵️

Use this repo's `docker-compose.yaml` to deploy a zenoh solution for the TurtleBot4 (iRobot Create 3 + Raspberry Pi 4) that **aids discovery and integration with The Construct's Real Robot Lab service.**

This repo contains a docker image and compose file that runs the following:

* A docker container with 2 zenoh bridges (`zenoh_bridge_ros2dds`):
    1. Zenoh bridge to capture Create 3 DDS data.
    2. Zenoh bridge to capture Raspberry Pi 4 DDS data.

This setup ensures that the ROS 2 data published by the entire robot is seen as one.

---

## How to use:

The **requirements** for this container to work are:

* TurtleBot 4 RPi4 must have The Construct's **RRL service installed**.
* **Create 3 settings** (access & change through web server):
    1. `ROS_DOMAIN_ID=1`
    2. `RMW_IMPLEMENTATION=rwm_cyclonedds_cpp`
    3. Default RMW XML Profile (leave `Beta Features -> Override RMW Profile` blank)
* Must set **correct RPi4 IP address** in `docker-compose.yaml`:

```
    environment:
      - RPI4_IP=192.168.2.63 # Replace with your actual Raspberry Pi IP address
    volumes:
      - /var/lib/theconstruct.rrl/cyclonedds.xml:/var/lib/theconstruct.rrl/cyclonedds.xml # The Construct RRL XML config file
```

1. Run `docker compose -f /PATH_TO_COMPOSE_FILE/docker-compose.yaml up -d` 

The detached argument `-d` is optional; no terminal is needed if command includes it.

* `docker ps` should show the running container `zenoh-bridge-turtlebot4`:

```
CONTAINER ID   IMAGE                                       COMMAND                  CREATED          STATUS          PORTS     NAMES
672fa78b58e1   rodrigo55/zenoh-bridge-ros2dds:turtlebot4   "/bin/ash -c /app/en…"   16 minutes ago   Up 24 seconds             zenoh-bridge-turtlebot4
```

---

## Base image 

The docker image is built on top of the official Zenoh Bridge ROS2 DDS image `eclipse/zenoh-bridge-ros2dds:latest`.