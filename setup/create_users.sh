#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 23/05/2025

# Description:
# Creates a new user, sets up SSH key-based authentication, ensures correct permissions,
# and starts/enables the SSH service so it is active and persistent.

# Prompt for a valid username
read -r -p "Enter a new user name: " USER

# Validate username format
if [[ ! "$USER" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]; then
    echo "Invalid username format. Exiting script."
    exit 1
fi

# Check if the user already exists
if id "$USER" &>/dev/null; then
    echo "User '$USER' already exists."
else
    echo "Creating user '$USER'..."
    sudo useradd -m "$USER"
    if [ $? -eq 0 ]; then
        echo "User '$USER' created successfully!"
    else
        echo "Failed to create user '$USER'. Exiting script."
        exit 1
    fi
fi

# Ask if the user should have sudo access
read -r -p "Should this user have sudo access? (y/n): " SUDO_CHOICE
if [[ "$SUDO_CHOICE" == [Yy] ]]; then
    sudo usermod -aG sudo "$USER"
    echo "Added '$USER' to the sudo group."
fi

# Prompt for the SSH public key
read -r -p "Enter the SSH public key for '$USER': " SSH_KEY

if [[ -z "$SSH_KEY" ]]; then
    echo "No SSH key provided. Exiting script."
    exit 1
fi

echo "Setting up SSH for '$USER'..."

SSH_DIR="/home/$USER/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

# Create .ssh directory and set correct permissions
sudo -u "$USER" mkdir -p "$SSH_DIR"
sudo -u "$USER" chmod 700 "$SSH_DIR"

# Add SSH key and set file permissions
echo "$SSH_KEY" | sudo -u "$USER" tee "$AUTHORIZED_KEYS" > /dev/null
sudo -u "$USER" chmod 600 "$AUTHORIZED_KEYS"

# Ensure SSH service is started and enabled at boot
echo "Ensuring SSH service is running..."
sudo systemctl enable ssh
sudo systemctl start ssh

# Confirm SSH status
echo -e "\n🔍 SSH service status:"
sudo systemctl status ssh --no-pager

# Final confirmation
echo -e "\n✅ User creation and SSH key setup complete for '$USER'. SSH is active."
