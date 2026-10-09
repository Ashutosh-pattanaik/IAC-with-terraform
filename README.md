# IAC-with-terraform

1. Project workflow

main.tf(Define Docker image and container) -> terraform init -> Download the Docker provider -> terraform plan -> Preview infrastructure changes -> terraform apply -> Create the Docker container 
Verify → Inspect state → Destroy

2. Prerequisites

Install these tools on your local Windows computer:

Docker Desktop — must be installed and running.

Terraform CLI — available in your terminal.

PowerShell or Windows Terminal.

Verify the installations:

#docker --version
#docker info
#terraform -version

3. Create the project directory

Run these commands in PowerShell:

#mkdir terraform-docker-project
#cd terraform-docker-project
notepad -> main.tf

Paste the following Terraform configuration into main.tf.

Download the Nginx Docker image

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
terraform {
required_providers {
docker = {
source = "kreuzwerker/docker"
version = "~> 3.0"
}
}
}

provider "docker" {}

Download the Nginx Docker image

resource "docker_image" "nginx" {
name = "nginx"
keep_locally = true
}

Create a Docker container

resource "docker_container" "nginx" {
name = "terraform-nginx"
image = docker_image.nginx.image_id

ports {
internal = 80
external = 8080
}
}

output "container_name" {
value = docker_container.nginx.name
}

output "container_id" {
value = docker_container.nginx.id
}

output "application_url" {
value = "http://localhost:8080"
}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

This configuration uses Nginx as the application, maps container port 80 to local port 8080, and defines outputs for verification.

4. Initialize Terraform

Run:

#terraform init

5. Preview the infrastructure

Before creating anything, run:

#terraform plan

6. Create the container

Execute:

#terraform apply

Review the plan, then enter:

yes

8. Inspect Terraform state

Terraform state tracks the resources managed by your configuration.

Run these commands one at a time:

#terraform state list

Inspect the container resource:

#terraform state show docker_container.nginx

Display the state in JSON format:

#terraform show
#terraform show -json

9. Destroy the infrastructure

When you have finished testing, preview the deletion:

#terraform plan -destroy

Then destroy the Terraform-managed resources:

#terraform destroy

Verify the container is gone:

#docker ps -a
#terraform state list
