resource "google_service_account" "bastion-sa" {
  account_id   = "bastion-sa"
  display_name = "bastion-sa"
}

resource "google_project_iam_binding" "bastion-sa-binding" {
  project = var.project_id
  role    = "roles/container.admin" # admin access
  members = [
    "serviceAccount:${google_service_account.bastion-sa.email}"
  ]
}

resource "google_service_account" "k8s-sa" {
  account_id   = "k8s-sa"
  display_name = "k8s-sa"
}

resource "google_project_iam_binding" "k8s-sa-binding" {
  project = var.project_id
  role    = "roles/storage.admin" # Full access to storage
  members = [
    "serviceAccount:${google_service_account.k8s-sa.email}"
  ]
}
