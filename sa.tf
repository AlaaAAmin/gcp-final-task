#can be used to ground permissions to pods for example making buckets or firewall rules for pods
resource "google_service_account" "k8s-staging" {
  account_id   = "k8s-staging"
  display_name = "Service Account"
}
