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

#resource "google_storage_bucket" "static-site" {
#  name          = "sc2021-bucket"
#  location      = "US"
#  force_destroy = true
#
#  uniform_bucket_level_access = true
#
#  website {
#    main_page_suffix = "index.html"
#    not_found_page   = "404.html"
#  }
#}

#output "gcp_access_token" {
#  value = data.vault_generic_secret.gcp_token.data.token
#}

