# Stream AI Node Installation Guide

This repository contains the installation script for setting up a Stream AI node using Docker. Stream AI nodes contribute to a decentralized network for AI data collection and processing.

## About Stream AI

Stream AI is a decentralized network that revolutionizes data collection and provisioning for AI model training. It harnesses the power of distributed nodes to enable real-time web data processing at scale while maintaining privacy and data integrity.

## Quick Installation

Choose the installation command based on your operating system:

### Linux

```bash
wget https://raw.githubusercontent.com/stream-innersource/node-script/main/install_linux.sh && chmod +x install_linux.sh && ./install_linux.sh
```

### macOS

```bash
curl -O https://raw.githubusercontent.com/stream-innersource/node-script/main/install_mac.sh && chmod +x install_mac.sh && ./install_mac.sh
```

### Windows

```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/stream-innersource/node-script/main/install_windows.ps1 -OutFile install_windows.ps1; .\install_windows.ps1
```

## Prerequisites

System requirements vary by operating system:

### General Requirements

- Docker installed and running
- Active internet connection
- Minimum 2GB RAM
- At least 20GB available storage space
- Port 9222 available

### Platform-Specific Requirements

#### Linux

- Supported distributions: Ubuntu 18.04+, CentOS 7+, Debian 10+
- sudo privileges

#### macOS

- macOS 10.15 (Catalina) or higher
- Homebrew package manager (will be installed by script if missing)

#### Windows

- Windows 10/11 Pro, Enterprise, or Education
- PowerShell 5.0 or higher
- WSL2 support (Windows Subsystem for Linux)

## Installation Steps

1. The script will automatically:

   - Check system requirements
   - Install or update Docker if needed
   - Pull necessary Docker images
   - Configure the node settings
   - Start the Stream AI node services

2. Follow the prompts during installation if any user input is required

3. After successful installation, your node will automatically connect to the Stream AI network

## Features

- Automated Docker-based installation
- Easy-to-use setup process
- Secure connection to Stream AI network
- Real-time data processing capabilities
- Automatic updates and maintenance
- Resource usage optimization
- Built-in monitoring and reporting

## Post-Installation

After installation, you can:

- Monitor your node's performance through the provided dashboard
- Check node status using provided commands
- Earn rewards for contributing to the network
- Participate in the Stream AI ecosystem

## Troubleshooting

Common issues and solutions:

1. If the installation fails, check:

   - Docker service status
   - Internet connectivity
   - System resources availability
   - Port availability

2. For permission issues:
   - Ensure you have sudo privileges
   - Check file permissions
   - Verify Docker group membership

## Documentation

For comprehensive information about Stream AI and its ecosystem, please visit our [official documentation](https://docs.allstream.ai/introduction).

## Support

If you encounter any issues:

1. Check our [official documentation](https://docs.allstream.ai/introduction)
2. Join our community channels
3. Contact our technical support team

## Security

The Stream AI node installation script:

- Uses secure HTTPS connections
- Verifies package signatures
- Implements best security practices
- Regular security updates

## Updates and Maintenance

- Nodes receive automatic updates
- Critical security patches are applied automatically
- Regular maintenance is handled by the system

## Contributing

We welcome contributions to improve the installation script and documentation. Please submit pull requests or report issues through our repository.

---

For more information about Stream AI and its capabilities, visit [Stream AI Documentation](https://docs.allstream.ai/introduction).

## Disclaimer

Please ensure you comply with all local regulations and have the necessary permissions before running a Stream AI node.
