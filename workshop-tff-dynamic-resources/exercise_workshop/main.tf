resource "random_string" "gcp_cloud" {
  length  = 16
  special = false
  upper   = false
}

resource "google_storage_bucket" "flora" {
  name     = "0-${random_string.gcp_cloud.result}"
  location = "US"
}

resource "google_storage_bucket" "fauna" {
  name     = "1-${random_string.gcp_cloud.result}"
  location = "US"
}

resource "google_storage_bucket_object" "flora" {
  name   = "flora"
  source = "./images/flora.jpg"
  bucket = google_storage_bucket.flora.name
}

resource "google_storage_bucket_object" "fauna" {
  name   = "fauna"
  source = "./images/fauna.jpg"
  bucket = google_storage_bucket.fauna.name
}
