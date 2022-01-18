_Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services._

GuillaumeEm / scaleway-terraform
====


## Overview
A simple personnal cloud, hosting nuaj.eu services (mail, dns, databases, webserver and others), provisionned by terraform + initializated by cloud-init, services setup (mostly docker) is not part of this repo (yet?)

//Awesome architecture png here// 🦄


## Prerequires
You will need to generate an api token [in the console](https://console.scaleway.com/project/credentials)

If you want persistance create disks and ip, you will need to choose the same "scaleway project" and "region" save the ids

_Temporary_ : You have to compile terraform provider to be able to use ip as a datasource :

* [Github repo - scaleway/terraform-provider-scaleway](https://github.com/scaleway/terraform-provider-scaleway)
* [Help ressource to use the provider locally](https://www.infracloud.io/blogs/developing-terraform-custom-provider/)

## Usage

#### Prepare
```
cp terraform.exampletfvars terraform.tfvars
cp example.cloud-init.yaml cloud-init.yaml
```
Edit terraform.tfvars :
* `project_name` 1st part of the names that will be used by terraform
* `zone` region of items that will be created/accessed, please consider greener "fr-par-2"
* `access_key` api access_key, string starting by "SCW"
* `secret_key` api secret_key, guid
* `organization_id` guid of organization/scaleway user
* `project_id` guid of project to associate the instance with
* `core_vol` guid of core additional volume
* `mail_vol` guid of mail additional volume
* `general_core_ports` public ports for the main server
* `general_mail_ports` public ports for the mail server
* `private_core_ports` accessible ports for the other instance and friendlies, main server
* `private_mail_ports` accessible ports for the other instance and friendlies, mail server
* `friendly_ip` any ip that has rights to see private ports

Edit cloud-init.yaml :
* User name (replace you by yours)
* Password of your user ($6$ string)
* Git user/email
* phone_home url endpoint
* Any package, file, config you wish to add. [Link to cloud-init doc](https://cloudinit.readthedocs.io/en/latest/index.html)

#### State management
If you want to use scaleway object storage (s3 compatible) for storing terraform state, as specified in [scaleway documentation](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs#store-terraform-state-on-scaleway-s3-compatible-object-storage) there are no locking mechanism, therefore take care if you need to use this between multiple users
```
cp bucket.exampletf bucket.tf
# edit the values (bucket, key, access_key, secret_key)
nano bucket.tf
```
#### Deploy
Config / Create
```
terraform init
terraform apply
# yes to run
```
Avoid unnecessary charges in your Scaleway account, discard unused instances
```
terraform destroy
```
_Note : IP and Disks will still be billed after a destroy_


## Considerations

Because the reputation of the ip for mail is important and the dns use a glue record, I chose the ip before hand,

Disks are prepared in advance for my convenience

Phonehome url is a scaleway function but feel free to use any endpoint you want, also functions deploy are not yet available in the terraform plugin so you will have to deploy it manually, the function is not in the scope of this repo and is not ready anyway
