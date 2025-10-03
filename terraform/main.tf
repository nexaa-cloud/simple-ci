terraform {
  required_version = ">= 1.0"
  required_providers {
    nexaa = {
      source  = "nexaa-cloud/nexaa"
      version = "0.1.27"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket"
    key    = "simple-ci/terraform.tfstate"
    region = "eu-west-1"

    endpoints = {
      s3 = "https://101010-rockstar-demo-minio.container.tilaa.cloud"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
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
  name        = "simple-ci-${var.environment}"
}

resource "nexaa_container" "simple-ci" {
  name      = "simple-ci-${var.environment}"
  namespace = nexaa_namespace.simple-ci.name
  image     = var.container_image

  resources = data.nexaa_container_resources.container_resource.id

  ports = ["3000"]

  ingresses = [
    {
      domain_name = "simple-ci-${var.environment}.nexaa.io"
      port        = 3000
      tls         = true
    }
  ]

  health_check = {
    port = 3000
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