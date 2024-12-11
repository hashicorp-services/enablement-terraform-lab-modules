resource "random_string" "gcp_cloud" {
  length  = 16
  special = false
  upper   = false
}

resource "google_storage_bucket" "bucket_1" {
  name     = random_string.gcp_cloud.result
  location = "US"
}

resource "google_storage_bucket" "bucket_2" {
  name     = random_string.gcp_cloud.result
  location = "US"
}

resource "google_storage_bucket" "bucket_3" {
  name     = random_string.gcp_cloud.result
  location = "US"
}
