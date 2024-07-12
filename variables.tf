variable common_name {
  type = string
}

variable project_id {
  type = string
}

variable region {
  type        = string
  description = "Region where the scheduler job resides. If it is not provided, Terraform will use the provider default"
  default     = "europe-west1"
}

variable subject_alternative_names {
  type = list
}

variable pubsub_topic {
  type        = string
  description = "Name of the Topic where Secret Manager events will be published"
}
