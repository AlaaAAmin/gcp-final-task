variable "region" {
  type = string
}
variable "service_account" {
  type = string
}
variable "network_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "master_ipv4_cidr_block" {
  type = string
}
variable "pods_ipv4_cidr_block" {
  type = string
}
variable "services_ipv4_cidr_block" {
  type = string
}
variable "authorized_ipv4_cidr_block" {
  type = string
}
variable "cluster-location" {
  type = string
}
variable "project-id" {
  type = string
}
variable "node-zones" {
  type = list(any)
}
