resource "google_service_account" "gce-db1-svc-acct" {
  account_id   = "gce-db1"
  display_name = "gce-db1 Service Account"
}

resource "google_compute_instance" "gce-db1" {
  name         = "gce-db1"
  machine_type = "e2-standard-2"
  zone         = "us-central1-c"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
    sshKeys = "debian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYNkA7EvTrnUuB3JmCjlJ+FD3BSs8sgBEgpk/ujDGXdvMKgiNMAUuRvAtnMo4ilEWNXQXGBQKp3/wE3+yXUDIq4Ve8MkYdn6JQviazqlM9L4JCmZtVEKn7cMo91MR0t82IdfbcI2hM3zgDrXmV/F1Sp9W8z4+TLTNgCmA3d61jvT2YIIxO6ag8zIwGjqwh9+r9lwa0eNRAdqtyO/GXcDAy1UHZPdt3tsTt7Ea2opmMJAWfAYAcw70fqS+9lcPtwvTXlxEoG5BYcDZMSEwmbNlR6Z/rfoGNb91MsspjSwxQwhUj+lILc5W3p3wdtLEiRqSuhr/BZYTTjla4yTI9U5qJ"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.gce-db1-svc-acct.email
    scopes = ["cloud-platform"]
  }
}

output "gce_db1" {
  value = google_compute_instance.gce-db1.network_interface[0].access_config[0].nat_ip
}


