#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run this script with root privileges"
    exit 1
fi

# Check system type
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    
    # Install Docker based on distribution
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg
        
        # Add Docker's official GPG key
        curl -fsSL https://download.docker.com/linux/${ID}/gpg | apt-key add -
        
        # Add Docker repository
        echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/${ID} $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
        
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        # Install required dependencies
        yum install -y yum-utils device-mapper-persistent-data lvm2
        
        # Add Docker official repository
        yum-config-manager --add-repo https://download.docker.com/linux/${ID}/docker-ce.repo
        
        # Install Docker packages
        yum install -y docker-ce docker-ce-cli containerd.io
    else
        echo "Unsupported operating system"
        exit 1
    fi

    # Modify Docker service startup section
    if systemctl --all --type service | grep -q "docker"; then
        systemctl enable docker
        systemctl start docker
    else
        echo "Docker service not found. Please try restarting your system."
        exit 1
    fi
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing docker-compose..."
    curl -L "https://get.daocloud.io/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        apt-get install -y git
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        yum install -y git
    fi
fi

# Clone repository
echo "Cloning repository..."
git clone https://github.com/stream-innersource/node-script
cd node-script

# Run docker-compose
echo "Starting services..."
docker-compose up -d 