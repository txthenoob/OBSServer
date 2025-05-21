#!/bin/bash
set -e

echo ">> Removing unneeded software..."
sudo apt purge ubuntu-desktop gnome-shell gdm3 libreoffice* snapd thunderbird* rhythmbox* -y
sudo apt autoremove --purge -y

echo ">> Installing Openbox + LightDM..."
sudo apt install --no-install-recommends openbox lightdm xinit -y

echo ">> Securing SSH..."
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo ">> OBS installed and system cleaned."
