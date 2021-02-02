vault auth enable gcp

vault write auth/gcp/config \
    credentials=@gcp-creds.json

vault write auth/gcp/role/my-gce-role \
    type="gce" \
    policies="gce-app1" \
    bound_projects="sc2021" \
    bound_zones="us-central1-c" \
    bound_labels="" \
    bound_service_accounts="gce-app1@sc2021.iam.gserviceaccount.com"

vault policy write gce-app1 - <<EOF
path "kv/data/secret" {
  capabilities = ["read"]
}
path "database/creds/app1-*" {
  capabilities = ["read"]
}
EOF

