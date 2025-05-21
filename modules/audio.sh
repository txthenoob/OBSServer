#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# Audio Setup Script for OBS Server
# Installs and configures PulseAudio for basic input/output device support.
# Intended for minimal desktop environments like Openbox or X11 sessions.
# -----------------------------------------------------------------------------

echo ">> Installing audio support..."

# Install PulseAudio and audio control panel
sudo apt install -y pulseaudio pavucontrol

# Ensure PulseAudio autospawn is enabled
if ! grep -q "autospawn = yes" ~/.config/pulse/client.conf 2>/dev/null; then
  mkdir -p ~/.config/pulse
  echo "autospawn = yes" > ~/.config/pulse/client.conf
  echo "daemon-binary = /usr/bin/pulseaudio" >> ~/.config/pulse/client.conf
  echo "enable-shm = yes" >> ~/.config/pulse/client.conf
fi

echo ">> Audio setup complete."
