resource "google_compute_router_nat" "playground-nat" {
  name                               = "playground-nat"
  router                             = google_compute_router.playground-router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" #requires the subnetwork block below
  subnetwork {
    name                    = google_compute_subnetwork.managed.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config {
    enable = false
    filter = "ERRORS_ONLY"
  }
}
