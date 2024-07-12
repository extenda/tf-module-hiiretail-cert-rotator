resource acme_registration reg {
  email_address   = var.acme_email_address
}

resource acme_certificate certificate {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = var.subject_alternative_names
  min_days_remaining = var.acme_cert_min_days_remaining

  dns_challenge {
    provider = "gcloud"
    config = {
      GCE_PROJECT = var.dns_project_id
    }
  }
}

resource google_secret_manager_secret fullchain {
  secret_id = var.secret_id_fullchain

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }  
  }

  topics {
    name = "projects/${var.project_id}/topics/${var.pubsub_topic}"
  }
}

resource google_secret_manager_secret_version fullchain {
  secret      = google_secret_manager_secret.fullchain.id
  secret_data = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
}

resource google_secret_manager_secret privkey {
  secret_id = var.secret_id_privkey

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  topics {
    name = "projects/${var.project_id}/topics/${var.pubsub_topic}"
  }
}

resource google_secret_manager_secret_version privkey {
  secret      = google_secret_manager_secret.privkey.id
  secret_data = acme_certificate.certificate.private_key_pem
}
