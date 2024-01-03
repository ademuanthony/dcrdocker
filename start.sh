#!/bin/bash

# Define directories
DCRD_DIR=~/decred/decred-linux-amd64-v1.8.1
INSTALLER=dcrinstall-linux-amd64-v1.8.1

# Trap SIGINT and SIGTERM for graceful shutdown
trap 'cleanup' SIGINT SIGTERM

cleanup() {
  echo "Shutting down..."
  killall dcrd
  killall dcrwallet
  exit 0
}

# Function to check if dcrd and dcrwallet are already setup
check_and_install() {
  if [ ! -f "$DCRD_DIR/dcrd" ] || [ ! -f "$DCRD_DIR/dcrwallet" ]; then
    echo "Installing Decred binaries..."
    # Run dcrinstall only if dcrd or dcrwallet doesn't exist
    curl -L https://github.com/decred/decred-release/releases/download/v1.8.1/$INSTALLER -o dcrinstall
    chmod +x dcrinstall
    ./dcrinstall 2>&1
  else
    echo "Decred binaries already installed."
  fi
}

# Run the check and install function
check_and_install

echo "Starting dcrd..."
$DCRD_DIR/dcrd --datadir=/data/.dcrd &

echo "Waiting for dcrd to initialize..."
while ! $DCRD_DIR/dcrctl --wallet getinfo &>/dev/null; do
   sleep 10
done
echo "dcrd is ready."

echo "Starting dcrwallet..."
$DCRD_DIR/dcrwallet --datadir=/data/.dcrwallet &

# Keep script running to prevent container from exiting
tail -f /dev/null
