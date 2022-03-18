provider "scaleway" {
  access_key      = var.access_key
  secret_key      = var.secret_key
  project_id      = var.project_id
  region          = var.region
  zone            = var.zone
}

resource "scaleway_instance_server" "mail" {
  name = format("%s-%s",var.project_name,"mail")
  type  = "DEV1-S"
  image = "debian-bullseye"
  tags = [ "Terraform", "Mail" ]
  ip_id = data.scaleway_instance_ip.public_ip_mail.id
  enable_ipv6 = true
  security_group_id= scaleway_instance_security_group.sg-mail.id
  placement_group_id = scaleway_instance_placement_group.availability-group.id

  root_volume {
    delete_on_termination = true
  }

  additional_volume_ids = [ data.scaleway_instance_volume.mail_vol.id ]

  user_data = {
    cloud-init = file("${path.module}/cloud-init-mail.yaml")
  }
}

resource "scaleway_instance_server" "core" {
  name = format("%s-%s",var.project_name,"core")
  type  = "DEV1-L"
  image = "debian-bullseye"
  tags = [ "Terraform", "Apps" ]
  ip_id = data.scaleway_instance_ip.public_ip_core.id
  enable_ipv6 = true
  security_group_id= scaleway_instance_security_group.sg-core.id
  placement_group_id = scaleway_instance_placement_group.availability-group.id

  root_volume {
    delete_on_termination = true
  }

  additional_volume_ids = [ data.scaleway_instance_volume.core_vol.id]

  user_data = {
    cloud-init = file("${path.module}/cloud-init-core.yaml")
  }
}
