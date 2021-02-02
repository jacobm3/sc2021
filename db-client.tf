resource "google_service_account" "gce-app1-svc-acct" {
  account_id   = "gce-app1"
  display_name = "gce-app1 Service Account"
}

resource "google_compute_instance" "gce-app1" {
  name         = "gce-app1"
  machine_type = "e2-standard-2"
  zone         = "us-central1-c"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.gce-app1-svc-acct.email
    scopes = ["cloud-platform"]
  }
}
