resource "acme_registration" "reg" {
  email_address   = "itcontracts+acme-certs-module@extendaretail.com"
}

resource "acme_certificate" "certificate_1" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = var.subject_alternative_names
  min_days_remaining = 90 #remove after testing or we will get hit by let's encrypt quota limit

  dns_challenge {
    provider = "gcloud"
    config = {
      GCE_PROJECT = "extenda"
    }
  }
}

resource "acme_certificate" "certificate_2" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = var.subject_alternative_names
  min_days_remaining = 60 #remove after testing or we will get hit by let's encrypt quota limit

  dns_challenge {
    provider = "gcloud"
    config = {
      GCE_PROJECT = "extenda"
    }
  }
}

resource "google_compute_ssl_certificate" "certificate_1" {
  name        = "terraform-managed-wildcard-1"
  description = "created and managed by terraform"
  private_key = acme_certificate.certificate_1.private_key_pem
  certificate = "${acme_certificate.certificate_1.certificate_pem}${acme_certificate.certificate_1.issuer_pem}"
}

resource "google_compute_ssl_certificate" "certificate_2" {
  name        = "terraform-managed-wildcard-2"
  description = "created and managed by terraform"
  private_key = acme_certificate.certificate_2.private_key_pem
  certificate = "${acme_certificate.certificate_2.certificate_pem}${acme_certificate.certificate_2.issuer_pem}"
}
