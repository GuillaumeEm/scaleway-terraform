# Persistent disks to create here : https://console.scaleway.com/instance/volumes
# Select correct project & region

data "scaleway_instance_volume" "core_vol" {
    volume_id = var.core_vol
}
data "scaleway_instance_volume" "mail_vol" {
    volume_id = var.mail_vol
}
