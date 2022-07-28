resource "google_container_cluster" "primary" {
  name                     = "primary"
  location                 = var.cluster-location
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network_name
  subnetwork               = var.subnet_name
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  node_locations           = var.node-zones
  addons_config {
    http_load_balancing {
      disabled = true # if you will create your load balancer
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }
  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = format("%s.svc.id.goog", var.project-id)
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_ipv4_cidr_block
    services_secondary_range_name = var.services_ipv4_cidr_block
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  # allowing access to the bastion server only
  dynamic "master_authorized_networks_config" {
    for_each = var.authorized_ipv4_cidr_block != null ? [var.authorized_ipv4_cidr_block] : []
    content {
      cidr_blocks {
        cidr_block   = master_authorized_networks_config.value
        display_name = "External Control Plane access"
      }
    }
  }

}

# resource "google_container_cluster" "app_cluster" {
#   name     = "app-cluster"
#   location = var.cluster-location

#   # We can't create a cluster with no node pool defined, but we want to only use
#   # separately managed node pools. So we create the smallest possible default
#   # node pool and immediately delete it.
#   remove_default_node_pool = true
#   initial_node_count       = 1

#   ip_allocation_policy {
#     cluster_ipv4_cidr_block  = var.pods_ipv4_cidr_block
#     services_ipv4_cidr_block = var.services_ipv4_cidr_block
#   }
#   network    = var.network_name
#   subnetwork = var.subnet_name

#   logging_service    = "logging.googleapis.com/kubernetes"
#   monitoring_service = "monitoring.googleapis.com/kubernetes"
#   maintenance_policy {
#     daily_maintenance_window {
#       start_time = "02:00"
#     }
#   }

#   master_auth {
#     # username = var.gke-user.name
#     # password = var.gke-user.pass

#     client_certificate_config {
#       issue_client_certificate = false
#     }
#   }

#   dynamic "master_authorized_networks_config" {
#     for_each = var.authorized_ipv4_cidr_block != null ? [var.authorized_ipv4_cidr_block] : []
#     content {
#       cidr_blocks {
#         cidr_block   = master_authorized_networks_config.value
#         display_name = "External Control Plane access"
#       }
#     }
#   }

#   private_cluster_config {
#     enable_private_endpoint = true
#     enable_private_nodes    = true
#     master_ipv4_cidr_block  = var.master_ipv4_cidr_block
#   }

#   release_channel {
#     channel = "STABLE"
#   }

#   addons_config {
#     // Enable network policy (Calico)
#     network_policy_config {
#       disabled = false
#     }
#   }

#   /* Enable network policy configurations (like Calico).
#   For some reason this has to be in here twice. */
#   network_policy {
#     enabled = "true"
#   }

#   workload_identity_config {
#     workload_pool = format("%s.svc.id.goog", var.project-id)
#   }
# }

# resource "google_container_node_pool" "app_cluster_linux_node_pool" {
#   name           = "${google_container_cluster.app_cluster.name}--linux-node-pool"
#   location       = google_container_cluster.app_cluster.location
#   node_locations = var.node-zones
#   cluster        = google_container_cluster.app_cluster.name
#   node_count     = 1

#   autoscaling {
#     max_node_count = 1
#     min_node_count = 1
#   }
#   max_pods_per_node = 30

#   management {
#     auto_repair  = true
#     auto_upgrade = true
#   }

#   node_config {
#     preemptible  = true
#     machine_type = "e2-medium"
#     disk_size_gb = 10

#     service_account = var.service_account
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform",
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#       "https://www.googleapis.com/auth/servicecontrol",
#       "https://www.googleapis.com/auth/service.management.readonly",
#       "https://www.googleapis.com/auth/trace.append",
#     ]

#     labels = {
#       cluster = google_container_cluster.app_cluster.name
#     }

#     shielded_instance_config {
#       enable_secure_boot = true
#     }

#     // Enable workload identity on this node pool.
#     workload_metadata_config {
#       mode = "GKE_METADATA"
#     }

#     metadata = {
#       // Set metadata on the VM to supply more entropy.
#       google-compute-enable-virtio-rng = "true"
#       // Explicitly remove GCE legacy metadata API endpoint.
#       disable-legacy-endpoints = "true"
#     }
#   }

#   upgrade_settings {
#     max_surge       = 1
#     max_unavailable = 1
#   }
# }