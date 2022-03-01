provider "google" {
  project     = var.project
  credentials = file("cloud-analytics-342815-34ae468440cd.json") // credentials.json to be used here
  region      = var.region
  zone        = var.zone
}
variable "project" {
  type        = string
  default     = "cloud-analytics-342815"
  description = "GCP Project to be used for creating resources"
}
