#!/usr/bin/env bash

# Exit on error
set -e

# Define variables
NEOVIM_DIR="$HOME/personal/neovim"
NEOVIM_VERSION="v0.10.2"

echo "Installing neovim..."

# Clone or update neovim repository
if [ -d "$NEOVIM_DIR" ]; then
    echo "Updating existing neovim repository..."
    cd "$NEOVIM_DIR"
    git fetch
    git checkout "$NEOVIM_VERSION"
    git pull
else
    echo "Cloning neovim repository..."
    git clone -b "$NEOVIM_VERSION" git@github.com:neovim/neovim.git "$NEOVIM_DIR"
fi

# Build neovim
echo "Building neovim..."
cd "$NEOVIM_DIR"
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install neovim
echo "Installing neovim..."
sudo make install

echo "Neovim installation complete!"