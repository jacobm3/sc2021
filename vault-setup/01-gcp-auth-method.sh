vault auth enable gcp

vault write auth/gcp/config \
    credentials=@gcp-creds.json

vault write auth/gcp/role/my-gce-role \
    type="gce" \
    policies="gce-app1" \
    bound_projects="sc2012" \
    bound_zones="us-central1-c" \
    bound_labels="foo:bar,zip:zap" \
    bound_service_accounts="gce-app1@sc2021.iam.gserviceaccount.com"


