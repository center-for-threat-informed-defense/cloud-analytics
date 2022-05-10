terraform {
  backend "gcs" {
    bucket      = "ca-tfstate"
    prefix      = "dev"
    credentials = "cloud-analytics-342815-34ae468440cd.json"
  }
}
