resource "google_artifact_registry_repository" "ca_repo" {
  provider = google-beta

  location      = var.region
  repository_id = var.repository_name
  description   = "docker repository for container images"
  format        = "DOCKER"
}

resource "google_service_account" "ca-test-account" {
  provider = google-beta

  account_id   = "sa-repo"
  display_name = "Test Service Account"
}

resource "google_artifact_registry_repository_iam_member" "test-iam" {
  provider = google-beta

  location   = google_artifact_registry_repository.ca_repo.location
  repository = google_artifact_registry_repository.ca_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.ca-test-account.email}"
}
