module "network" {
  source = "./network"
  # pass args here
  vpc_name            = var.vpc_name
  routing_mode        = var.vpc_routing_mode
  mtu                 = var.vpc_mtu
  region              = var.region
  managed_sub_cidr    = var.managed_sub_cidr
  restricted_sub_cidr = var.restricted_sub_cidr
}

module "google_kubernetes_cluster" {
  source = "./kubernetes_cluster"

  region                     = var.region
  project-id                 = var.project_id
  cluster-location           = var.cluster-location
  service_account            = google_service_account.k8s-sa.email
  network_name               = module.network.playground-vpc.name
  subnet_name                = module.network.restricted-sub.name
  master_ipv4_cidr_block     = var.cluster_master_ip_cidr_range
  pods_ipv4_cidr_block       = var.cluster_pods_ip_cidr_range
  services_ipv4_cidr_block   = var.cluster_services_ip_cidr_range
  authorized_ipv4_cidr_block = "${google_compute_instance.private-vm.network_interface.0.network_ip}/32"
}
