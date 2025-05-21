#!/bin/bash
set -e

echo ">> Installing audio support..."

# Instala PulseAudio (más simple de controlar en sistemas dedicados)
sudo apt install -y pulseaudio pavucontrol

# Habilita PulseAudio para el usuario actual
if ! grep -q "autospawn = yes" ~/.config/pulse/client.conf 2>/dev/null; then
  mkdir -p ~/.config/pulse
  echo "autospawn = yes" > ~/.config/pulse/client.conf
  echo "daemon-binary = /usr/bin/pulseaudio" >> ~/.config/pulse/client.conf
  echo "enable-shm = yes" >> ~/.config/pulse/client.conf
fi

echo ">> Audio setup complete."
