terraform {
  # The configuration for this backend will be filled in by Terragrunt
  required_version = ">= 1.4.5"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.37.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.37.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}