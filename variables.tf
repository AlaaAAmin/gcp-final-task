variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_routing_mode" {
  type = string
}
variable "vpc_mtu" {
  type = number
}
variable "managed_sub_cidr" {
  type = string
}
variable "restricted_sub_cidr" {
  type = string
}
variable "private-vm-type" {
  type = string
}
variable "private-vm-state" {
  type = string
}
variable "private-vm-name" {
  type = string
}
variable "private-vm-image" {
  type = string
}
variable "private-vm-zone" {
  type = string
}

#gke --------------------------------
variable "cluster_master_ip_cidr_range" {
  type = string
}
variable "cluster_pods_ip_cidr_range" {
  type = string
}
variable "cluster_services_ip_cidr_range" {
  type = string
}
variable "gke-user" {
  type = map(any)
}
variable "cluster_node_zones" {
  type = list(any)
}
variable "cluster-location" {
  type = string
}
