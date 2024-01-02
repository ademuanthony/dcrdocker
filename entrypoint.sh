#!/bin/sh

# Run dcrinstall and capture any errors
./dcrinstall 2>&1

# Then execute the passed command (CMD from Dockerfile or command line)
exec "$@"
