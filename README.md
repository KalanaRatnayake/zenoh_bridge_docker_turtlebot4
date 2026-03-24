# 🔵️🐉️ Zenoh Bridge Docker for TurtleBot 4 🐉️🔵️

This is a Github import of the [theconstructcore/zenoh_bridge_docker_turtlebot4](https://bitbucket.org/theconstructcore/zenoh_bridge_docker_turtlebot4/src/master/) repository. Checkout the original repo at prior link.  Main changes include,

- Exposing CREATE3_DOMAIN_ID and RASPPI4_DOMAIN_ID as compose.yaml file based ENV parameters (compared to fixed 0 and 1)

This repository contains a docker zenoh bridge setup that gets rid of the TurtleBot4 DDS problems (not being able to see all topics) forever.

---

## 1. Requirements

⚠️ **Both the Raspberry Pi and Create 3 base must be configured.**

### Raspberry Pi configuration.
1. SSH into your TurtleBot 4:
```
ssh ubuntu@[YOUR_TB4_IP_ADDRESS] 
# password (if you haven't changed it): turtlebot4
```
2. In that terminal, run `turtlebot4-setup`:
```
turtlebot4-setup
```
3. Navigate with arrow keys and Enter to `ROS Setup` -> `Bash Setup`
4. Set the following parameters:
    * `ROS_DOMAIN_ID=0` (or any other value)
    * `RMW_IMPLEMENTATION=rmw_cyclonedds_cpp`
    * `CYCLONEDDS_URI=[]` (Empty).
    * Any namespace can be added.
5. Select `Save` at the bottom.
6. Go back to main screen with `Ctrl + C`
7. Select `Apply Settings` -> `Yes`

🕰️ Wait around a minute for the TurtleBot4 chime 🎶 that indicates a restart.

### Create 3 configuration.

1. Access the Create 3 configuration by typing `YOUR_TB4_IP_ADDRESS:8080` in a web browser.
2. Navigate to `Application` -> `Configuration`
3. Set the following parameters:
    * `ROS_DOMAIN_ID=1` (or any other value)
    * `RMW_IMPLEMENTATION=rmw_cyclonedds_cpp`
    * Uncheck `Enable Fast DDS discovery server?`.
    * Any namespace can be added.

4. Click `Save` and then click on `Restart application`

🕰️ Wait around a minute for the TurtleBot4 chime 🎶 that indicates a restart.

---

## 2. Run container
1. SSH into your TurtleBot4.
2. Clone this repository:
```
git clone https://github.com/KalanaRatnayake/zenoh_bridge_docker_turtlebot4.git
```
3. Enter directory:
```
cd zenoh_bridge_docker_turtlebot4
```
4. Run `setup.sh`:
```
./setup.sh
```
5. Wait for setup to complete.
6. Set CycloneDDS as your default RMW implementation:
```
echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ~/.bashrc && source ~/.bashrc
```
7. Check that you receive ROS 2 data, from both the rpi (like `/scan`) and from the Create 3 (like `/odom`)
```
ros2 topic list
ros2 topic echo /scan --once  # Add namespace if needed
ros2 topic echo /odom --once  # Add namespace if needed
```
8. Check that you can undock/dock the robot, and move it with teleop:
```
ros2 action list
ros2 action send_goal /undock irobot_create_msgs/action/Undock "{}"  # Add namespace if needed
ros2 run teleop_twist_keyboard teleop_twist_keyboard  # Add namespace if needed
ros2 action send_goal /dock irobot_create_msgs/action/Dock "{}"  # Add namespace if needed
```
✅ Your TurtleBot4 is now correctly setup. You'll see all ROS 2 topics/services/ actions every time now!

---

## 3. Connect TurtleBot4 with The Construct's Real Robot Connection

🔷️ To be able to use the TurtleBot 4 from The Construct, follow these steps:

1. Complete the instructions from Sections 1. and 2.
2. Register a new robot in The Construct [here](https://app.theconstruct.ai/real-robots).
3. Once registered, copy the install link generated.
4. SSH into your TurtleBot 4.
5. In that terminal, paste the generated install link and press `Enter`. Wait for installation to complete.
6. In that terminal, run `turtlebot4-setup`:
```
turtlebot4-setup
```
7. Navigate with arrow keys and Enter to `ROS Setup` -> `Bash Setup`
8. Set the following parameters:
    * `RMW_IMPLEMENTATION=rmw_cyclonedds_cpp`
    * `ROS_DOMAIN_ID=0`
    * `CYCLONEDDS_URI=[/var/lib/theconstruct.rrl/cyclonedds_husarnet.xml]` 
    * Any namespace can be added.
9. Select `Save` at the bottom.
10. Go back to main screen with `Ctrl + C`
11. Select `Apply Settings` -> `Yes`
12. Restart the zenoh service:
```
sudo systemctl restart zenoh-bridge.service
```
13. In The Construct, open any ROS 2 rosject.
14. Connect to the TurtleBot4 by clicking on the `Connect to Physical Robots` -> `TurtleBot4` -> `CONNECT` on the bottom menu bar.
15. Check that you receive ROS 2 data, from both the rpi (like `/scan`) and from the Create 3 (like `/odom`)
```
ros2 topic list
ros2 topic echo /scan --once  # Add namespace if needed
ros2 topic echo /odom --once  # Add namespace if needed
```
8. Check that you can undock/dock the robot, and move it with teleop:
```
ros2 action list
ros2 action send_goal /undock irobot_create_msgs/action/Undock "{}"  # Add namespace if needed
ros2 run teleop_twist_keyboard teleop_twist_keyboard  # Add namespace if needed
ros2 action send_goal /dock irobot_create_msgs/action/Dock "{}"  # Add namespace if needed
```
✅ Your TurtleBot4 is now connected to The Construct.
