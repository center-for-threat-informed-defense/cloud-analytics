resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret"

  labels = var.default_tags

  replication {
    user_managed {
      replicas {
        location = var.region
      }
      replicas {
        location = var.replica_region
      }
    }
  }
}

# create a secret
resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret      = google_secret_manager_secret.secret-basic.id
  secret_data = "secret-data"
}
