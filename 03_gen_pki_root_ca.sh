#!/bin/bash

set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Enable PKI Secret Engine
vault secrets enable pki

# Set default TTL
vault secrets tune -max-lease-ttl=87600h pki

# Generate root CA
vault write -format=json pki/root/generate/internal \
    common_name="example.com" ttl=8760h > pki-ca-root.json

# Save certificate in a separate file. To be added later in the browser
cat pki-ca-root.json | jq -r '.data.certificate' > ca.pem

# Publish URLs for the root CA
vault write pki/config/urls \
    issuing_certificates="http://localhost:8200/v1/pki/ca" \
    crl_distribution_points="http://localhost:8200/v1/pki/crl"
