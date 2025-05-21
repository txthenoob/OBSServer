#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# OBS WebSocket Setup Script
# Enables OBS WebSocket server with plaintext password as required by OBS.
# -----------------------------------------------------------------------------
# ⚠️ OBS WebSocket requires the password to be in plaintext.
# DO NOT hash it manually — OBS handles encryption internally.
# Protect this file using filesystem permissions: chmod 600
# -----------------------------------------------------------------------------

echo ">> Enabling OBS WebSocket support..."

CONFIG_FILE="$HOME/.config/obs-studio/global.ini"
WEBSOCKET_SECTION="[WebSocketServer]"

# Ensure OBS config file exists
mkdir -p "$(dirname "$CONFIG_FILE")"
touch "$CONFIG_FILE"

# Set default WebSocket configuration with password in plaintext
if ! grep -q "$WEBSOCKET_SECTION" "$CONFIG_FILE"; then
  echo ">> Creating WebSocket config section..."
  cat <<EOF >> "$CONFIG_FILE"

$WEBSOCKET_SECTION
Enable=true
AuthRequired=true
ServerPort=4455
ServerPassword=changeme123
EOF
else
  echo ">> Updating existing WebSocket config..."
  sed -i "/\[WebSocketServer\]/,/^$/ s/^Enable=.*/Enable=true/" "$CONFIG_FILE"
  sed -i "/\[WebSocketServer\]/,/^$/ s/^ServerPort=.*/ServerPort=4455/" "$CONFIG_FILE"
  sed -i "/\[WebSocketServer\]/,/^$/ s/^AuthRequired=.*/AuthRequired=true/" "$CONFIG_FILE"
  sed -i "/\[WebSocketServer\]/,/^$/ s/^ServerPassword=.*/ServerPassword=changeme123/" "$CONFIG_FILE"
fi

# Restrict permissions on config file
chmod 600 "$CONFIG_FILE"

echo ">> OBS WebSocket configured on port 4455 with default password."
echo ">> IMPORTANT: Change the password manually in:"
echo "   $CONFIG_FILE"
