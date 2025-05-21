setup_sh = """#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# OBS Server Setup Script
# Can be used manually or automatically (e.g., via autoinstall late-commands)
# -----------------------------------------------------------------------------

echo ">> Running OBS Server setup..."

# If not already inside the repo, clone it
if [ ! -f modules/obs.sh ]; then
  echo ">> Cloning OBSServer repository..."
  git clone https://github.com/txthenoob/OBSServer.git obs-setup
  cd obs-setup
fi

# Make all modules executable
chmod +x modules/*.sh

# Run setup modules
bash modules/obs.sh
bash modules/audio.sh
bash modules/docker-deps.sh

# Run optional cleanup if present
if [ -f modules/cleanup.sh ]; then
  bash modules/cleanup.sh
fi

echo ">> OBS Server setup complete."
"""

path = "/mnt/data/setup.sh"
with open(path, "w") as f:
    f.write(setup_sh)

path
