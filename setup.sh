#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# OBS Server Setup Script
# This script installs and configures an OBS streaming server environment.
# Compatible with both manual execution and automated deployment.
# -----------------------------------------------------------------------------

echo ">> Starting OBS Server setup..."

# Ensure Git is available before cloning the repository
if ! command -v git &> /dev/null; then
  echo ">> Git is not installed. Installing Git..."
  sudo apt update && sudo apt install -y git
fi

# Clone the repository only if not already inside the correct folder
if [ ! -f modules/obs.sh ]; then
  echo ">> Cloning OBSServer repository..."
  git clone https://github.com/txthenoob/OBSServer.git obs-setup
  cd obs-setup
fi

# Make sure all module scripts are executable
chmod +x modules/*.sh

# Execute each setup module in order
bash modules/obs.sh
bash modules/audio.sh
bash modules/docker-deps.sh

# Run optional system cleanup if defined
if [ -f modules/cleanup.sh ]; then
  bash modules/cleanup.sh
fi

echo ">> OBS Server setup completed successfully."
