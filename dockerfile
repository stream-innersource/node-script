# Use Ubuntu as base image
FROM ubuntu:20.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    xdg-utils \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libgles2 \
    libegl1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /app \
    && ln -s /usr/lib/x86_64-linux-gnu/libGLESv2.so.2 /app/libGLESv2.so \
    && ln -s /usr/lib/x86_64-linux-gnu/libEGL.so.1 /app/libEGL.so

# Create working directory
WORKDIR /app

# Modify copy command to ensure target path ends with slash
COPY ./headless_server_* /app/

# Use build argument to set architecture
ARG TARGETARCH

# Choose or download correct binary file based on architecture
RUN if [ "$TARGETARCH" = "amd64" ]; then \
    if [ ! -f "/app/headless_server_amd64" ]; then \
    wget -O /app/headless_server_amd64 https://raw.githubusercontent.com/stream-innersource/node-script/main/headless_server_amd64; \
    fi; \
    cp /app/headless_server_amd64 /app/headless_server; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    if [ ! -f "/app/headless_server_arm64" ]; then \
    wget -O /app/headless_server_arm64 https://raw.githubusercontent.com/stream-innersource/node-script/main/headless_server_arm64; \
    fi; \
    cp /app/headless_server_arm64 /app/headless_server; \
    else \
    echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi \
    && chmod +x /app/headless_server \
    && rm -f /app/headless_server_amd64 /app/headless_server_arm64

# Set container startup command
CMD ["/app/headless_server", \
    "--remote-debugging-port=9222", \
    "--no-sandbox", \
    "--disable-dev-shm-usage", \
    "--disable-gpu", \
    "--disable-gpu-compositing", \
    "--disable-software-rasterizer", \
    "--use-gl=swiftshader"]