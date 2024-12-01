# Check if running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    Break
}

# Check if Docker Desktop is installed
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Docker Desktop..."
    # Download Docker Desktop installer
    $dockerUrl = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
    $outPath = "$env:TEMP\DockerDesktopInstaller.exe"
    Invoke-WebRequest -Uri $dockerUrl -OutFile $outPath

    # Install Docker Desktop
    Start-Process -Wait $outPath -ArgumentList "install --quiet"
    Remove-Item $outPath

    Write-Output "Docker Desktop installation complete. Please restart your computer and run this script again"
    Exit
}

# Start Docker service
Start-Service docker

# Check if Git is installed
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Git..."
    # Download Git installer
    $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe"
    $outPath = "$env:TEMP\GitInstaller.exe"
    Invoke-WebRequest -Uri $gitUrl -OutFile $outPath

    # Install Git
    Start-Process -Wait $outPath -ArgumentList "/VERYSILENT /NORESTART"
    Remove-Item $outPath
    
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Clone repository
Write-Output "Cloning repository..."
git clone https://github.com/stream-innersource/node-script
Set-Location node-script

# Run docker-compose
Write-Output "Starting services..."
docker-compose up -d