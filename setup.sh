#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_NAME="zenoh-bridge.service"
SERVICE_PATH="/etc/systemd/system/${SERVICE_NAME}"

echo "[1/9] Checking docker..."
command -v docker >/dev/null 2>&1 || {
  echo "Error: docker is not installed."
  exit 1
}

echo "[2/9] Checking docker compose..."
docker compose version >/dev/null 2>&1 || {
  echo "Error: docker compose plugin is not available."
  exit 1
}

echo "[3/9] Preparing optional Real Robot Service config path..."
RRL_CONFIG="/var/lib/theconstruct.rrl/cyclonedds_husarnet.xml"
RRL_DIR="$(dirname "$RRL_CONFIG")"

sudo mkdir -p "$RRL_DIR"

if [ -d "$RRL_CONFIG" ]; then
  echo "Found directory at $RRL_CONFIG where a file should be. Removing it."
  sudo rm -rf "$RRL_CONFIG"
fi

if [ ! -e "$RRL_CONFIG" ]; then
  echo "Creating placeholder config file."
  sudo touch "$RRL_CONFIG"
fi

echo "[4/9] Writing systemd service..."
cat <<EOF >/tmp/${SERVICE_NAME}
[Unit]
Description=Zenoh bridge docker compose stack
Requires=docker.service
After=docker.service network-online.target turtlebot4.service
Wants=network-online.target

[Service]
Type=oneshot
WorkingDirectory=${REPO_DIR}

# Extra cushion after turtlebot4 service starts.
ExecStartPre=/bin/sleep 20

ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down

RemainAfterExit=yes
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

sudo cp /tmp/${SERVICE_NAME} "${SERVICE_PATH}"
rm -f /tmp/${SERVICE_NAME}

echo "[5/9] Reloading systemd..."
sudo systemctl daemon-reload

echo "[6/9] Enabling docker..."
sudo systemctl enable docker >/dev/null 2>&1 || true

echo "[7/9] Enabling ${SERVICE_NAME}..."
sudo systemctl enable "${SERVICE_NAME}"

echo "[8/9] Stopping any existing compose stack..."
sudo docker compose -f "${REPO_DIR}/docker-compose.yaml" down || true

echo "[9/9] Starting ${SERVICE_NAME}..."
sudo systemctl restart "${SERVICE_NAME}"

echo
echo "Setup complete."
echo
echo "Useful commands:"
echo "  sudo systemctl status ${SERVICE_NAME}"
echo "  sudo journalctl -u ${SERVICE_NAME} -b"
echo "  docker compose -f ${REPO_DIR}/docker-compose.yaml ps"
echo "  docker compose -f ${REPO_DIR}/docker-compose.yaml logs -f"