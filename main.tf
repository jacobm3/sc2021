provider "google" {
  project     = "sc2021"
  region      = "us-central1"
  zone        = "us-central1-c"
  access_token = data.vault_generic_secret.gcp_token.data.token
}

# Dynamic GCP access token for provisioning resources
data "vault_generic_secret" "gcp_token" {
  path = "gcp/token/my-token-roleset"
}

