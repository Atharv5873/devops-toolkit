#!/bin/bash

# Author:        Atharv Sharma
# Date Created:  26/04/2025
# Date Modified: 26/04/2025

# Description:
# This script creates a new user named 'devuser', sets up SSH key-based authentication for the user,
# and ensures the necessary permissions and directory structure are properly configured.

# Usage:
# To use this script, simply run it. The script will create the user and configure SSH for that user.
# (Important: Replace the SSH key in the script with your own public key for proper authentication.)

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

# Set up SSH for the user
echo "Setting up SSH for '$USER'..."

# Create the .ssh directory and set correct ownership and permissions
sudo mkdir -p /home/$USER/.ssh
sudo chown $USER:$USER /home/$USER
sudo chown $USER:$USER /home/$USER/.ssh
sudo chmod 700 /home/$USER/.ssh

# Add the SSH public key to authorized_keys
echo "$SSH_KEY" | sudo tee /home/$USER/.ssh/authorized_keys > /dev/null

# Set the appropriate permissions for the authorized_keys file
sudo chmod 600 /home/$USER/.ssh/authorized_keys
sudo chown $USER:$USER /home/$USER/.ssh/authorized_keys

# Check if everything was set up correctly
if [ -f /home/$USER/.ssh/authorized_keys ]; then
    echo "SSH key setup for '$USER' complete."
else
    echo "Failed to set up SSH key. Exiting script."
    exit 1
fi

echo "User creation and SSH key setup complete."
