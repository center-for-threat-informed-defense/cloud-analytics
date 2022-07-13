resource "google_service_account" "default" {
  account_id   = "ca-sa-cluster"
  display_name = "Service Account for container cluster"
}

resource "google_container_cluster" "primary" {
  name               = "sketch-moon"
  location           = var.region
  initial_node_count = 1
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = var.default_tags
  }
  timeouts {
    create = "30m"
    update = "30m"
  }
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host  = google_container_cluster.primary.endpoint
  token = data.google_client_config.provider.access_token
  client_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].client_certificate,
  )
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
  client_key = base64decode(google_container_cluster.primary.master_auth[0].client_key)
}

resource "google_compute_address" "public_lb_ip" {
  name   = "ca-example-lb-ip"
  region = var.region
}

resource "kubernetes_service" "app" {
  metadata {
    name = "app"
  }

  spec {
    selector = {
      run = "app"
    }

    session_affinity = "None"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type             = "LoadBalancer"
    load_balancer_ip = google_compute_address.public_lb_ip.address
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "app"

    labels = {
      run = "app"
    }
  }

  spec {
    replicas = 1

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = 1
        max_unavailable = 0
      }
    }

    selector {
      match_labels = {
        run = "app"
      }
    }

    template {
      metadata {
        name = "app"
        labels = {
          run = "app"
        }
      }

      spec {
        container {
          image = "nginx:1.21"
          name  = "ca-test"

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "KnockKnock"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

output "public_url" {
  value = "http://${google_compute_address.public_lb_ip.address}"
}
