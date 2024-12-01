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

# Run docker-compose
Write-Output "Starting services..."
docker-compose up -d