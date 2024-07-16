### Terraform Module: ACME Certificate Management with GCP Secrets Manager

This Terraform module creates and renews an ACME certificate using Let's Encrypt. The fullchain.pem and privkey.pem are stored in Google Cloud Platform (GCP) Secret Manager Secret Versions. Notifications are published to a Pub/Sub topic when the secret versions are modified.

#### Table of Contents

1. [Usage](#usage)
2. [Variables](#variables)
3. [Outputs](#outputs)
4. [Example](#example)
5. [Requirements](#requirements)
6. [Providers](#providers)

### Usage

```hcl
module "acme_certificate_manager" {
  source = "./path_to_your_module"

  acme_cert_min_days_remaining = 30
  acme_email_address           = "your-email@example.com"
  acme_environment             = "production" # or "staging"
  common_name                  = "example.com"
  dns_project_id               = "your-dns-project-id"
  project_id                   = "your-project-id"
  region                       = "your-region"
  secret_id_fullchain          = "your-fullchain-secret-id"
  secret_id_privkey            = "your-privkey-secret-id"
  subject_alternative_names    = ["www.example.com", "api.example.com"]
  pubsub_topic                 = "your-pubsub-topic"
}
```

### Variables

| Name                         | Type   | Description                                                                 | Default    |
|------------------------------|--------|-----------------------------------------------------------------------------|------------|
| acme_cert_min_days_remaining | number | Number of days before the certificate expires that it will be renewed       | 30         |
| acme_email_address           | string | Email address of the registered Let's Encrypt user account                  |            |
| acme_environment             | string | Specify whether to use 'production' or 'staging' environment for Let's Encrypt | "staging"  |
| common_name                  | string | Common name for the certificate                                             |            |
| dns_project_id               | string | GCP Project ID where the DNS zones reside                                   |            |
| project_id                   | string | GCP Project ID where to create the Secret Manager Secrets                   |            |
| region                       | string | Region where the scheduler job resides                                      |            |
| secret_id_fullchain          | string | Secret name to store the fullchain.pem in Secret Manager                    |            |
| secret_id_privkey            | string | Secret name to store the privkey.pem in Secret Manager                      |            |
| subject_alternative_names    | list   | List of subject alternative names for the certificate                       |            |
| pubsub_topic                 | string | Name of the Topic where Secret Manager events will be published             |            |

### Outputs

This module does not have any outputs.

### Example

```hcl
module "acme_certificate_manager" {
  source = "./path_to_your_module"

  acme_cert_min_days_remaining = 30
  acme_email_address           = "your-email@example.com"
  acme_environment             = "production"
  common_name                  = "example.com"
  dns_project_id               = "your-dns-project-id"
  project_id                   = "your-project-id"
  region                       = "your-region"
  secret_id_fullchain          = "your-fullchain-secret-id"
  secret_id_privkey            = "your-privkey-secret-id"
  subject_alternative_names    = ["www.example.com", "api.example.com"]
  pubsub_topic                 = "your-pubsub-topic"
}
```

### Requirements

| Name    | Version |
|---------|---------|
| terraform | >= 0.12 |
| google    | ~> 3.0  |
| acme      | ~> 1.0  |

### Providers

| Name  | Version |
|-------|---------|
| google | ~> 3.0  |
| acme   | ~> 1.0  |

### Resources

- **acme_registration.reg**: Registers an account with Let's Encrypt.
- **acme_certificate.certificate**: Manages the ACME certificate lifecycle.
- **google_secret_manager_secret.fullchain**: Creates a Secret Manager secret for fullchain.pem.
- **google_secret_manager_secret_version.fullchain**: Stores the fullchain.pem in Secret Manager.
- **google_secret_manager_secret.privkey**: Creates a Secret Manager secret for privkey.pem.
- **google_secret_manager_secret_version.privkey**: Stores the privkey.pem in Secret Manager.

### Notes

- Ensure that you have the necessary IAM roles for managing DNS records and Secret Manager secrets.
- The `acme_environment` variable determines whether to use the Let's Encrypt production or staging environment.

This module is designed to facilitate the automatic creation and renewal of Let's Encrypt certificates and the secure storage of those certificates in GCP Secret Manager. The integration with Pub/Sub ensures that any changes to the secrets are communicated to interested subscribers.