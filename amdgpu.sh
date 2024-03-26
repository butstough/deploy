#!/usr/bin/bash


# Define the base URL of the repository
REPO_URL="https://repo.radeon.com/amdgpu-install/23.40.2/ubuntu/jammy/"

# Use wget to fetch the index page of the repo, then grep to find .deb files, sort them, and take the last one (assuming it's the latest)
LATEST_DEB=$(wget -qO- $REPO_URL | grep -oP 'href="\K[^"]*.deb' | sort -r | head -n 1)

# Check if we found a .deb file
if [ -z "$LATEST_DEB" ]; then
    echo "No .deb file found in the repository."
    exit 1
fi

# Full URL of the latest .deb package
DEB_URL="${REPO_URL}${LATEST_DEB}"

# Download the latest .deb package
echo "Downloading ${DEB_URL}..."
wget "$DEB_URL"

# Install the downloaded package
# Note: You might need to run this script as root or use sudo before dpkg to have the necessary permissions.
echo "Installing ${LATEST_DEB}..."
sudo dpkg -i "$LATEST_DEB"

# You might need to run apt-get install -f to resolve dependencies.
sudo apt-fast install -f

amdgpu-install -y --accept-eula --usecase=dkms,graphics,multimedia,multimediasdk,workstation,rocm,rocmdev,lrt,amf,opencl,openclsdk,mllib,mlsdk 

