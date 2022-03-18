variable "region" {
  default = "fr-par"
}
variable "zone" {
  default = "fr-par-2"
}

variable "project_name" {}
variable "access_key" {}
variable "secret_key" {}
variable "organization_id" {}
variable "project_id" {}
variable core_vol {}
variable mail_vol {}

variable general_core_ports {
  default = [22,80,443]
}
variable general_mail_ports {
  default = [22,25,465,993]
}
variable general_core_ports_udp {
  default = []
}
variable general_mail_ports_udp {
  default = []
}
variable private_core_ports {
  default = []
}
variable private_mail_ports {
  default = []
}
variable "friendly_ip" {
}
