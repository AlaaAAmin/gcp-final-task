resource "google_container_cluster" "primary" {
  name     = "primary"
  location = var.cluster-location # zonal cluster

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network_name
  subnetwork               = var.subnet_name

  addons_config {
    http_load_balancing {
      disabled = false # enable only if you using custom ingress controller
    }
  }
  # update GKE from stable channel
  release_channel {
    channel = "STABLE"
  }

  private_cluster_config {
    # creating a private endpoints on the cluster.
    enable_private_nodes = true
    # to only connext to gke from private endpoint ex: bastion server
    enable_private_endpoint = true
    # cidr will be assigned to the master (control plane) control plane
    master_ipv4_cidr_block = var.master_ipv4_cidr_block #"172.16.0.0/28"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.authorized_ipv4_cidr_block

      display_name = "bastion-server-only"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pods_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }
}

resource "google_container_node_pool" "workers-nodes" {
  name       = "workers-nodes"
  location   = var.cluster-location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = false # enabled = vms that last up to 24 hours after creation.
    machine_type = "e2-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
