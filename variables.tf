variable acme_cert_min_days_remaining {
  type = number
  description = "number of days before certifcate expires that it will be renewed"
  default = 30
}

variable acme_email_address {
  type = string
  description = "email address of the registered let's encrypt user account"
}

variable acme_environment {
  description = "Specify whether to use 'production' or 'staging' environment for Let's Encrypt."
  type        = string
  default     = "staging"
}

variable common_name {
  type = string
}

variable dns_project_id {
  type = string
  description = "GCP Project ID where the DNS zones reside"
}

variable project_id {
  type = string
  description = "GCP Project ID where to create the Secret Manager Secrets"
}

variable region {
  type        = string
  description = "Region where the scheduler job resides. If it is not provided, Terraform will use the provider default"
}

variable secret_id_fullchain {
  type = string
  description = "Secret name to store the fullchain.pem in Secret Manager"
}

variable secret_id_privkey {
  type = string
  description = "Secret name to store the privkey.pem in Secret Manager"
}

variable subject_alternative_names {
  type = list
}

variable pubsub_topic {
  type        = string
  description = "Name of the Topic where Secret Manager events will be published"
}
