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

# Run docker-compose
echo "Starting services..."
docker-compose up -d 