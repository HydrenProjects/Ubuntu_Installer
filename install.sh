#!/bin/bash

# Define colors for terminal output
PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Clear the terminal
printf "\033c"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    printf "${RED}Please run as root${NC}\n"
    exit
fi

# Define the installation directory and URL for Ubuntu base tarball
INSTALL_DIR="./ubuntu_22_04"
ARCHIVE_URL="http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.3-base-amd64.tar.gz"

# Check if the directory already exists
if [ -d "$INSTALL_DIR" ]; then
    printf "${GREEN}Directory ${INSTALL_DIR} already exists.${NC}\n"
    printf "${GREEN}Starting terminal in the existing environment...${NC}\n"
else
    # If the directory does not exist, create it and proceed with the installation process
    mkdir -p "$INSTALL_DIR"

    # Simulate starting the Ubuntu installation
    printf "${GREEN}Starting Ubuntu 22.04 installation process...${NC}\n"
    sleep 2

    # Download the Ubuntu 22.04 base tarball
    printf "${GREEN}Downloading Ubuntu 22.04 base files...${NC}\n"
    curl -o ubuntu-22.04.tar.gz "$ARCHIVE_URL"

    # Extract the downloaded tarball to the installation directory
    printf "${GREEN}Extracting Ubuntu 22.04 files...${NC}\n"
    tar -xzf ubuntu-22.04.tar.gz -C "$INSTALL_DIR"

    # Clean up the downloaded archive
    rm ubuntu-22.04.tar.gz
    printf "${GREEN}Files extracted to ${INSTALL_DIR}.${NC}\n"
fi

# Clear screen and display the welcome message
printf "\033c"

# Displaying a custom Ubuntu-like welcome message
echo "Welcome to Ubuntu 24.04 LTS (GNU/Linux 5.14.0-427.33.1.el9_4.x86_64 x86_64)"
echo ""
echo " * Documentation:  https://help.ubuntu.com"
echo " * Management:     https://landscape.canonical.com"
echo " * Support:        https://ubuntu.com/pro"
echo ""
echo "This system has been minimized by removing packages and content that are"
echo "not required on a system that users do not log into."
echo ""
echo "To restore this content, you can run the 'unminimize' command."
echo ""

# Function to simulate a terminal inside the Ubuntu directory
run_cmd() {
    while true; do
        read -p "ubuntu@127.0.0.1:$PWD# " CMD
        eval "$CMD"
        printf "ubuntu@127.0.0.1:$PWD# "
    done
}

# Run the interactive terminal in the extracted Ubuntu environment
cd "$INSTALL_DIR"
run_cmd
