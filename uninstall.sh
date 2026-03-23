#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_NAME="zenoh-bridge.service"
SERVICE_PATH="/etc/systemd/system/${SERVICE_NAME}"

echo "[1/5] Stopping service..."
sudo systemctl stop "${SERVICE_NAME}" || true

echo "[2/5] Disabling service..."
sudo systemctl disable "${SERVICE_NAME}" || true

echo "[3/5] Removing service file..."
sudo rm -f "${SERVICE_PATH}"

echo "[4/5] Reloading systemd..."
sudo systemctl daemon-reload

echo "[5/5] Bringing compose stack down..."
sudo docker compose -f "${REPO_DIR}/compose.yaml" down || true

echo "Uninstall complete."
