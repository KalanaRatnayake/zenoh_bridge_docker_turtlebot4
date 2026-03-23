# Use the official Zenoh Bridge ROS2 DDS image as a base
FROM eclipse/zenoh-bridge-ros2dds:latest

# Set environment variables for the ROS2 domain IDs for the Raspberry Pi 4 and Create 3
ENV RASPPI4_DOMAIN_ID=0
ENV CREATE3_DOMAIN_ID=1

# Set the working directory inside the container
WORKDIR /app

# Copy the custom zenoh bridges configuration files into the container
COPY create3_config.json5 /app/create3_config.json5
COPY rpi_config.json5 /app/rpi_config.json5

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
