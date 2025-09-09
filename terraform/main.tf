terraform {
  required_version = ">= 1.0"
  required_providers {
    nexaa = {
      source  = "nexaa-cloud/nexaa"
      version = "0.1.27"
    }
  }
}

provider "nexaa" {
  username = var.nexaa_username
  password = var.nexaa_password
}

data "nexaa_container_resources" "container_resource" {
  cpu = 0.25
  memory = 0.5
}

resource "nexaa_namespace" "simple-ci" {
  name        = "simple-ci"
}

resource "nexaa_container" "simple-ci" {
  name      = "simple-ci"
  namespace = nexaa_namespace.simple-ci.name
  image     = var.container_image

  resources = data.nexaa_container_resources.container_resource.id

  ports = ["80:80"]

  ingresses = [
    {
      domain_name = "simple-ci.nexaa.io"
      port        = 80
      tls         = true
    }
  ]

  health_check = {
    port = 80
    path = "/"
  }

  scaling = {
    type = "manual"
    manual_input = 1
  }

  timeouts {
    create = "30s"
    update = "60s"
    delete = "60s"
  }
}