resource "google_compute_subnetwork" "managed" {
  name                     = "managed"
  description              = "private subnet with NAT and bastion server"
  ip_cidr_range            = var.managed_sub_cidr
  region                   = var.region
  network                  = google_compute_network.playground.id
  private_ip_google_access = true #provide access to google apis without having internet
}
resource "google_compute_subnetwork" "restricted" {
  name                     = "restricted"
  description              = "private subnet GKE private control plane"
  ip_cidr_range            = var.restricted_sub_cidr
  region                   = var.region
  network                  = google_compute_network.playground.id
  private_ip_google_access = true #provide access to google apis without having internet
}
# secondary_ip_range = [
#   {
#     range_name    = "k8s-pods-range"
#     ip_cidr_range = var.pods-ip-range
#   },
#   {
#     range_name    = "k8s-service-range"
#     ip_cidr_range = var.services-ip-range
#   }
# ]
