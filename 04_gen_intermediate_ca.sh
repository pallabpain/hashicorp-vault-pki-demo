#!/bin/bash

set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Enable PKI Secret Engine
vault secrets enable -path=pki_int pki

# Set default TTL
vault secrets tune -max-lease-ttl=43800h pki_int

# Create intermediate CA and save CSR (Ceritficate Signing Request)
# in a separate file
vault write -format=json pki_int/intermediate/generate/internal \
    common_name="example.com Intermediate Authority" \
    | jq -r '.data.csr' > pki_intermediate.csr

# Send the above CSR to the root CA for signing an save the generated cerficate
# in a separate file
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
    format=pem_bundle ttl=43800h \
    | jq -r '.data.certificate' > intermediate.cert.pem

# Publish the signed certificate back to the intermediate CA
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

# Publish the intermediate CA urls
vault write pki_int/config/urls \
    issuing_certificates="http://localhost:8200/v1/pki_int/ca" \
    crl_distribution_points="http://localhost:8200/v1/pki_int/crl"

