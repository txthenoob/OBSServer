#!/bin/bash
set -e

echo ">> Running OBS Server setup..."

# Only clone the repo if running from autoinstall (i.e., not already inside the repo)
if [ ! -f modules/obs.sh ]; then
  echo ">> Cloning OBSServer repository..."
  git clone https://github.com/txthenoob/OBSServer.git obs-setup
  cd obs-setup
fi

# Ensure all scripts are executable
chmod +x modules/*.sh

# Run setup modules
bash modules/obs.sh
bash modules/audio.sh
bash modules/docker-deps.sh

# Optional cleanup
if [ -f modules/cleanup.sh ]; then
  bash modules/cleanup.sh
fi

echo ">> OBS Server setup complete."
