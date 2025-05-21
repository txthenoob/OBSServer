#!/bin/bash
set -e

REPO_URL="https://github.com/txthenoob/OBSServer"
TMP_DIR="/tmp/streaming-setup-$$"

echo ">> Cloning repository..."
git clone "$REPO_URL" "$TMP_DIR"
cd "$TMP_DIR"

bash modules/obs.sh
bash modules/audio.sh
bash modules/docker-deps.sh
bash modules/cleanup.sh

echo ">> Copying OBS configuration..."
mkdir -p ~/.config/obs-studio/
cp -r obs-config/* ~/.config/obs-studio/

echo ">> Installation completed."
