terraform {
  required_version = ">= 1.6.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # For remote Docker: host = "ssh://user@host"
}

############################
# Variables
############################
variable "image_name" {
  description = "Name for the built Docker image"
  type        = string
  default     = "dice-game-nginx"
}

variable "image_tag" {
  description = "Tag for the built Docker image"
  type        = string
  default     = "v2"
}

variable "host_port" {
  description = "Host port to expose the web app"
  type        = number
  default     = 8080
}

############################
# Cache-buster for rebuilds when site files change
############################
locals {
  image_dir         = "${path.module}/image"
  site_dir          = "${local.image_dir}/site"
  site_files        = fileset(local.site_dir, "**/*")
  site_files_hashes = [for f in local.site_files : filesha256("${local.site_dir}/${f}")]
  content_hash      = sha1(join("", local.site_files_hashes))
  app_name          = "dice-game"
}

############################
# Networking
############################
resource "docker_network" "app_net" {
  name   = "tf_${local.app_name}_net"
  driver = "bridge"
}

############################
# Build custom image from ./image
############################
resource "docker_image" "webimg" {
  name = "${var.image_name}:${var.image_tag}"

  build {
    context    = local.image_dir
    dockerfile = "Dockerfile"

    # Rebuild when site files change
    build_args = {
      CACHEBUSTER = local.content_hash
    }
  }

  keep_locally = true
}

############################
# Run container
############################
resource "docker_container" "web" {
  name  = "${local.app_name}-web"
  image = docker_image.webimg.image_id

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = var.host_port
    protocol = "tcp"
  }

  restart = "unless-stopped"
}

############################
# Outputs
############################
output "url" {
  value       = "http://localhost:${var.host_port}/"
  description = "Open your app here"
}

output "image_built" {
  value       = docker_image.webimg.name
  description = "Built image name:tag"
}

output "container_id" {
  value       = docker_container.web.id
  description = "The running container ID for exec access"
}

