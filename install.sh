#!/bin/bash

# Installation script for the 'fire' emergency git script

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# GitHub repository details
GITHUB_USER="uurtech"  # Replace with your GitHub username
REPO_NAME="in-case-of-fire.sh"  # Replace with your repository name
GITHUB_RAW_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/main/fire"

# Function to download fire script from GitHub
download_fire_script() {
    print_info "Downloading fire script from GitHub..."
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    FIRE_SCRIPT="$TEMP_DIR/fire"
    
    # Download the fire script
    if command -v curl >/dev/null 2>&1; then
        curl -sSL "$GITHUB_RAW_URL" -o "$FIRE_SCRIPT" || {
            print_error "Failed to download fire script using curl"
            return 1
        }
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$GITHUB_RAW_URL" -O "$FIRE_SCRIPT" || {
            print_error "Failed to download fire script using wget"
            return 1
        }
    else
        print_error "Neither curl nor wget found. Please install one of them."
        return 1
    fi
    
    # Verify download
    if [ ! -f "$FIRE_SCRIPT" ] || [ ! -s "$FIRE_SCRIPT" ]; then
        print_error "Downloaded fire script is empty or doesn't exist"
        return 1
    fi
    
    print_success "Fire script downloaded successfully"
    echo "$FIRE_SCRIPT"
}

# Check if fire script exists locally, if not download it
FIRE_SCRIPT_PATH=""
if [ -f "fire" ]; then
    print_info "Using local fire script"
    FIRE_SCRIPT_PATH="fire"
else
    print_info "Fire script not found locally, downloading from GitHub..."
    FIRE_SCRIPT_PATH=$(download_fire_script)
    if [ $? -ne 0 ]; then
        print_error "Failed to download fire script"
        exit 1
    fi
fi

# Check if fire script is executable
if [ ! -x "$FIRE_SCRIPT_PATH" ]; then
    print_info "Making fire script executable..."
    chmod +x "$FIRE_SCRIPT_PATH"
fi

print_info "🔥 Installing FIRE emergency git script..."

# Default installation directory
INSTALL_DIR="/usr/local/bin"

# Check if /usr/local/bin exists and is writable
if [ ! -d "$INSTALL_DIR" ]; then
    print_warning "/usr/local/bin doesn't exist. Creating it..."
    sudo mkdir -p "$INSTALL_DIR" || {
        print_error "Failed to create $INSTALL_DIR"
        exit 1
    }
fi

# Copy the script
print_info "Installing fire script to $INSTALL_DIR..."
if sudo cp "$FIRE_SCRIPT_PATH" "$INSTALL_DIR/fire"; then
    print_success "fire script installed successfully!"
else
    print_error "Failed to install fire script"
    exit 1
fi

# Clean up temporary files if we downloaded the script
if [[ "$FIRE_SCRIPT_PATH" == /tmp/* ]] || [[ "$FIRE_SCRIPT_PATH" == */tmp/* ]]; then
    print_info "Cleaning up temporary files..."
    rm -rf "$(dirname "$FIRE_SCRIPT_PATH")" 2>/dev/null || true
fi

# Verify installation
if command -v fire >/dev/null 2>&1; then
    print_success "Installation verified! You can now run 'fire' from anywhere."
else
    print_warning "fire command not found in PATH. You may need to:"
    echo "  1. Restart your terminal, or"
    echo "  2. Run: source ~/.bashrc (or ~/.zshrc)"
    echo "  3. Check if $INSTALL_DIR is in your PATH"
fi

echo
print_info "🔥 FIRE EMERGENCY SCRIPT READY! 🔥"
echo
echo "Usage:"
echo "  fire           - Run emergency git commit and push"
echo "  fire --setup   - Reconfigure target path"
echo "  fire --help    - Show help message"
echo
echo "On first run, you'll be asked to specify which directory to monitor for git repositories."
echo
print_success "Installation complete! Stay safe! 🏃‍♂️💨" 