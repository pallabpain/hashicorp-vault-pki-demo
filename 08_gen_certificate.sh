set -o xtrace

# Set environment variables
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# Define username and password
export VAULT_USER="john"
export VAULT_PASSWORD="rocket"

# Log in to Vault with username and password
vault login -format=json -method=userpass \
    username=${VAULT_USER} \
    password=${VAULT_PASSWORD} | jq -r '.auth.client_token' > user.token

# Set the VAULT_TOKEN. We will be able to use this token to
# authenticate against Vault moving forward
export VAULT_TOKEN=`cat user.token`

# Use the new token to generate a new certificate and store it in a file
vault write -format=json pki_int/issue/example-dot-com \
    common_name=test.example.com > test.example.com.crt

# Extract the certificate, issuing CA and private key in separately. These will be used
# by the NGINX server application later
cat test.example.com.crt | jq -r '.data.certificate' > web-server/certs/test.example.pem
cat test.example.com.crt | jq -r '.data.issuing_ca' >> web-server/certs/test.example.pem
cat test.example.com.crt | jq -r '.data.private_key' > web-server/certs/test.example.key
