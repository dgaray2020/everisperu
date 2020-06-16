provider "google" {
  credentials = file("/home/adminibk/gcp/GOOGLECLOUD/Credentials/everisperu-cc1b3471f8d9.json")
  project     = "everisperu"
  region      = "us-east4"
}
// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "flask-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "centos-cloud/debian-7"
   }
 }

// Make sure flask is installed on all new instances for later steps


 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}