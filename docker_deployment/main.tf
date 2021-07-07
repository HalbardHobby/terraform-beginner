# This block contains main settings, including required providers
terraform {
  required_providers {
    # Each provider requires a source
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0" # This is an optional parameter
    }
  }
}

# This block configures the specified provider
provider "docker" {}

# This block defines a component of infrastructure.
# It can be physical, virtual or logical.
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# The resources contain arguments for configuration.
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
