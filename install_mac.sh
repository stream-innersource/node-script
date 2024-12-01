#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if Docker Desktop is installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker Desktop..."
    brew install --cask orbstack

    # Launch Docker Desktop
    open /Applications/OrbStack
    
    echo "Waiting for Docker Desktop to start..."
    while ! docker system info &> /dev/null; do
        sleep 1
    done
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    brew install git
fi

# Clone repository
echo "Cloning repository..."
git clone https://github.com/stream-innersource/node-script
cd node-script

# Run docker-compose
echo "Starting services..."
docker-compose up -d 