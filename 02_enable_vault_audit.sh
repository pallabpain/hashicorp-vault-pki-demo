#!/bin/bash

set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Log into Vault
vault login root

# Print the status
vault status

# Enable audit and log it to a file
vault audit enable file file_path=/var/log/vault_audit.log

# Enable another audit and write raw data instead
vault audit enable -path="file_raw" file log_raw=true file_path=/var/log/vault_audit_raw.log