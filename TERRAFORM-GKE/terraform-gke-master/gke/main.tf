provider "google" {
  credentials = file("/home/adminibk/gcp/GOOGLECLOUD/Credentials/everisperu-cc1b3471f8d9.json")
  project     = "everisperu"
  region      = "us-east4"
}

provider "google-beta" {
  credentials = file("/home/adminibk/gcp/GOOGLECLOUD/Credentials/everisperu-cc1b3471f8d9.json")
  project     = "everisperu"
  region      = "us-east4"
}

module "vpc" {
  source                    = "/home/adminibk/gcp/GOOGLECLOUD/terraform-gke-master/modules/vpc"
  environment               = terraform.workspace
  organization              = var.organization
  project                   = var.project
}


module "subnet" {
  source                    = "/home/adminibk/gcp/GOOGLECLOUD/terraform-gke-master/modules/subnet"
  network_self_link         = module.vpc.network_self_link
  environment               = terraform.workspace
  organization              = var.organization
  project                   = var.project
  region                    = var.region
  private_subnet_cidr       = var.private_subnet_cidr
}

module "gke" {
  source                        = "/home/adminibk/gcp/GOOGLECLOUD/terraform-gke-master/modules/gke"
  environment                   = terraform.workspace
  organization                  = var.organization
  project                       = var.project
  network_self_link             = module.vpc.network_self_link
  private_subnet_self_link      = module.subnet.out_private_subnet_self_link
  zone                          = var.zone
  gke_cluster_name              = "gke"
  gke_master_cidr_block         = "172.16.0.16/28"
  gke_k8s_version               = "1.14.10-gke.36"
  /*
    Default node pools
  */
  default_preemptible           = "true"
  default_machine_type          = "custom-4-8192"
  default_disk_size_gb          = "20"
  default_disk_type             = "pd-standard"
  /*
    Node pool config
  */
  gke_node_pools = [
    {
      machine_type       = "custom-4-8192"
      min_node_count     = 1
      max_node_count     = 4
      node_count         = 1
      disk_size_gb       = 20
      disk_type          = "pd-standard"
      preemptible        = true
    },
    #{
    #  machine_type       = "n1-standard-1"
    #  min_node_count     = 3
    #  max_node_count     = 6
    #  node_count         = 6
    #  disk_size_gb       = 10
    #  preemptible        = true
    #},
  ]
}
