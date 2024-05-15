#!/bin/ash

# Execute the first script
/app/run_zenoh_bridge_create3.sh &

# Execute the second script
/app/run_zenoh_bridge_rpi.sh
