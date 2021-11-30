terraform {
  required_providers {
    scaleway = {
      # source = "scaleway/scaleway"
      # compiled more recent provider because i need data source for static ips instructions here : https://github.com/scaleway/terraform-provider-scaleway
      source = "registry.nuaj.eu/scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}
