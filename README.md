# Terraform

This is our first Terraform project.
Terraform is an orchestration tool that will deploy AMIs
into the cloud.

It can use many providers and use different types of images
and/or provisioning.

In our stack we gave:
- Chef - configuration management.
- Packer - creates immutable images of our machines.
- Terraform - the orchestration tool that will set-up the
infrastructure in the cloud.


Download Terraform.
Clone this repo and open the root directory in a
command line terminal.
Run `terraform apply`.
Open AWS on EU-West-1 and search for Eng48-conrad-bohm-app.
Enter the public ip of this instance into browser search bar, with :27017/posts on the end to access the database dependancy part of the app.
