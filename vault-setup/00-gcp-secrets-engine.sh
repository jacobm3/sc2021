export VAULT_NAMESPACE=sc2021

vault secrets enable gcp
vault write gcp/config credentials=@gcp-creds.json

# access token, preferred
# 1hr hard limit
vault write gcp/roleset/my-token-roleset \
    project="sc2021" \
    secret_type="access_token"  \
    token_scopes="https://www.googleapis.com/auth/cloud-platform" \
    bindings=-<<EOF
      resource "//cloudresourcemanager.googleapis.com/projects/sc2021" {
        roles = ["roles/owner"]
      }
EOF


# GCP limits 10 service account keys per account
vault write gcp/roleset/my-key-roleset \
    project="sc2021" \
    secret_type="service_account_key"  \
    bindings=-<<EOF
      resource "//cloudresourcemanager.googleapis.com/projects/sc2021" {
        roles = ["roles/owner"]
      }
EOF

# Create policy allowing use of this secrets engine
# Vault provider for TF creates a temporary token so
# the primary isn't in the state file
vault policy write gcp-creds - <<EOF
path "secret/*" {
  capabilities = ["read"]
}
path "gcp/token/my-token-roleset" {
  capabilities = ["read"]
}
path "gcp/token/my-key-roleset" {
  capabilities = ["read"]
}
path "auth/token/create" {
  capabilities = ["create","update"]
}
EOF

# This token goes in the TFE workspace sensitive env var VAULT_TOKEN
vault token create -policy=gcp-creds -ttl=4320h

