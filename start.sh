#!/bin/bash

trap 'cleanup' SIGINT SIGTERM

cleanup() {
  echo "Shutting down..."
  killall dcrd
  killall dcrwallet
  exit 0
}

echo "Starting dcrd..."
 ~/decred/decred-linux-amd64-v1.8.1/dcrd --datadir=/data/.dcrd &

echo "Waiting for dcrd to initialize..."
while ! ~/decred/decred-linux-amd64-v1.8.1/dcrctl --wallet getinfo &>/dev/null; do
   sleep 10
done
echo "dcrd is ready."

echo "Starting dcrwallet..."
~/decred/decred-linux-amd64-v1.8.1/dcrwallet --datadir=/data/.dcrwallet &

tail -f /dev/null
