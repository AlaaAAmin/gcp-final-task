resource "google_compute_router" "playground-router" {
  name        = "playground-router"
  description = "playground vpc router"
  region      = var.region
  network     = google_compute_network.playground.id

  # Border Gateway Protocol is a standardized exterior gateway protocol designed to exchange
  # routing and reachability information among autonomous systems on the Internet.
  bgp {
    # each AS is assigned an autonomous system number(ASN), for use in (BGP) routing
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = google_compute_subnetwork.managed.ip_cidr_range
    }
  }
}
