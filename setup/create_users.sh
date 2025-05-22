#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 22/05/2025

# Description:
# This script creates a new user, sets up SSH key-based authentication,
# and ensures the necessary permissions and directory structure are configured.

read -p "Enter a new user name: " USER

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

# Prompt for the SSH public key
read -p "Enter the SSH public key for '$USER': " SSH_KEY

# Validate that a key was provided
if [[ -z "$SSH_KEY" ]]; then
    echo "No SSH key provided. Exiting script."
    exit 1
fi

echo "Setting up SSH for '$USER'..."

SSH_DIR="/home/$USER/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

# Create .ssh directory and set permissions
sudo mkdir -p "$SSH_DIR"
sudo chmod 700 "$SSH_DIR"
sudo chown "$USER:$USER" "$SSH_DIR"

# Add SSH key to authorized_keys and set permissions
printf '%s\n' "$SSH_KEY" | sudo tee "$AUTHORIZED_KEYS" > /dev/null
if [ $? -ne 0 ]; then
    echo "Failed to write SSH key to $AUTHORIZED_KEYS"
    exit 1
fi
sudo chmod 600 "$AUTHORIZED_KEYS"
sudo chown "$USER:$USER" "$AUTHORIZED_KEYS"

# Debug output: list file details as root
echo "Debug: Listing authorized_keys file:"
sudo ls -l "$AUTHORIZED_KEYS"

# Verify setup with sudo test
if sudo test -f "$AUTHORIZED_KEYS"; then
    echo "SSH key setup for '$USER' complete."
else
    echo "Failed to set up SSH key. Exiting script."
    exit 1
fi

echo "User creation and SSH key setup complete."
