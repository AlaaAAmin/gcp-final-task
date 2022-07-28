project_id          = "versatile-bolt-354107"
region              = "us-central1" #lowa
vpc_name            = "playground"
vpc_routing_mode    = "REGIONAL"
vpc_mtu             = 1460
managed_sub_cidr    = "10.0.1.0/24"
restricted_sub_cidr = "10.0.2.0/24"
private-vm-type     = "e2-micro" #n1-standard-1
private-vm-state    = "RUNNING"
private-vm-name     = "private-vm"
private-vm-image    = "ubuntu-os-cloud/ubuntu-2004-lts" #project/family #debian-cloud/debian-9
private-vm-zone     = "us-central1-a"

#gke
cluster_master_ip_cidr_range   = "10.100.100.0/28"
cluster_pods_ip_cidr_range     = "10.101.0.0/21"
cluster_services_ip_cidr_range = "10.102.0.0/21"
gke-user = {
  "name" = "super-gene"
  "pass" = "Itisme98"
}
cluster_node_zones = ["us-central1-a"]
cluster-location   = "us-central1-a"
