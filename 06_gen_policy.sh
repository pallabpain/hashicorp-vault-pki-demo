set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Create a bew policy to create, update, revoke and list certificates
vault policy write pki_int pki_int.hcl