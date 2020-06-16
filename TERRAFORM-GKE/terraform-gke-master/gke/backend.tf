terraform {
  backend "gcs" {
    bucket      = "everisperustate"
    prefix      = "terraform/state"
    credentials = "/home/adminibk/gcp/GOOGLECLOUD/Credentials/everisperu-cc1b3471f8d9.json"
  }
}
