variable "nexaa_username" {
  description = "Username for Nexaa authentication"
  type        = string
  sensitive   = true
}

variable "nexaa_password" {
  description = "Password for Nexaa authentication"
  type        = string
  sensitive   = true
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
  default     = "ghcr.io/nexaa-cloud/simple-ci:latest"
}

variable "environment" {
  description = "Environment name (e.g., branch name for preview environments)"
  type        = string
  default     = "main"
}

variable "s3_access_key" {
  description = "S3 backend access key"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "S3 backend secret key"
  type        = string
  sensitive   = true
}