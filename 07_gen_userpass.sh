set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Define username and password
export VAULT_USER="john"
export VAULT_PASSWORD="rocket"

# Enable userpass authentication method
vault auth enable userpass

# Create a new username and password with the policy created in 06_gen_policy.sh
vault write auth/userpass/users/${VAULT_USER} \
    password=${VAULT_PASSWORD} \
    token_policies="pki_int"