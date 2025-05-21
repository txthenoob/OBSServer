#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# Docker + Docker Compose Setup Script
# Installs Docker Engine and Docker Compose plugins on Ubuntu 24.04 LTS.
# Adds the current user to the docker group for non-root access.
# -----------------------------------------------------------------------------

echo ">> Installing Docker and Docker Compose..."

# Prepare system for Docker installation
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker and plugins
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker "$USER"

echo ">> Docker installed successfully."
echo ">> Please log out and back in to use Docker without sudo."
