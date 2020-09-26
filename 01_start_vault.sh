#!/bin/bash

set -o xtrace

# Get absolute path of the working directory
location=$(pwd)

# Create log directory
mkdir -p ${location}/log

# Create custom network
docker network create dev-network

# Start Vault in dev mode
docker run -d \ 
    --name vault-demo -v ${location}/log:/var/log \
    --network dev-network -p 8200:8200 vault:latest \
    server -dev -dev-root-token-id="root"