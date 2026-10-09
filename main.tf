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
