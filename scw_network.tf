data "scaleway_instance_ip" "public_ip_core" {
  address = "51.159.128.10"
}
data "scaleway_instance_ip" "public_ip_mail" {
  address = "51.159.128.31"
}

resource "scaleway_instance_placement_group" "availability-group" {
  name = "enforce_low_latency_core"
  policy_type = "low_latency"
  policy_mode = "enforced"
}

resource "scaleway_vpc_private_network" "nujcvp" {
    name = "nujcvp-vcp"
    tags = ["Terraform"]
}

resource "scaleway_instance_private_nic" "picnic-core" {
    server_id          = scaleway_instance_server.core.id
    private_network_id = scaleway_vpc_private_network.nujcvp.id
}
resource "scaleway_instance_private_nic" "picnic-mail" {
    server_id          = scaleway_instance_server.mail.id
    private_network_id = scaleway_vpc_private_network.nujcvp.id
}
