resource "google_compute_instance" "private-vm" {
  name                      = var.private-vm-name
  description               = "this private vm is a bastion for the GKE cluster control plane"
  desired_status            = var.private-vm-state
  machine_type              = var.private-vm-type
  allow_stopping_for_update = true #enables changing machine type after creation 
  zone                      = var.private-vm-zone

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = var.private-vm-image
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = module.network.managed_sub.name
  }
}
