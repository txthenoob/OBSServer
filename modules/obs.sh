#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# OBS Studio Installer Script
# Installs OBS Studio and verifies NVIDIA NVENC compatibility (if present).
# Intended for headless or lightweight desktop environments (Openbox, X11).
# -----------------------------------------------------------------------------

echo ">> Installing OBS Studio..."

# Update APT and install OBS
sudo apt update
sudo apt install -y obs-studio

# Check for NVIDIA GPU and driver status
if command -v nvidia-smi &> /dev/null; then
  echo ">> NVIDIA driver detected:"
  nvidia-smi --query-gpu=name,driver_version --format=csv,noheader
  echo ">> NVENC support is likely available for OBS encoding."
else
  echo "⚠️  NVIDIA driver not found or not loaded."
  echo "   Please verify GPU driver installation if hardware encoding is needed."
fi

# Create default OBS config directory if it doesn't exist
OBS_CONFIG_DIR="$HOME/.config/obs-studio"
if [ ! -d "$OBS_CONFIG_DIR" ]; then
  echo ">> Creating default OBS config directory..."
  mkdir -p "$OBS_CONFIG_DIR/basic/scenes"
  mkdir -p "$OBS_CONFIG_DIR/basic/profiles"
fi

echo ">> OBS Studio installation completed."
