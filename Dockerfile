# Use the official Zenoh Bridge ROS2 DDS image as a base
FROM eclipse/zenoh-bridge-ros2dds:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the custom zenoh bridge configuration file into the container
COPY create3_config.json5 /app/create3_config.json5
# Copy the zenoh bridge run scripts
COPY run_zenoh_bridge_create3.sh /app/run_zenoh_bridge_create3.sh
COPY run_zenoh_bridge_rpi.sh /app/run_zenoh_bridge_rpi.sh

# Set execute permissions on the scripts
RUN chmod +x /app/run_zenoh_bridge_create3.sh
RUN chmod +x /app/run_zenoh_bridge_rpi.sh

# Replace the entrypoint script with a modified version
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Set the modified entrypoint script as the entrypoint of the container
ENTRYPOINT ["/bin/ash", "-c", "/app/entrypoint.sh"]
