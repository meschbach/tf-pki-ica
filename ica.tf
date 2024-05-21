resource "tls_private_key" "ica" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_cert_request" "ica" {
  private_key_pem = tls_private_key.ica.private_key_pem

  dynamic "subject" {
    for_each = [var.subject]
    content {
      common_name         = var.subject.common_name
      country             = var.subject.country
      locality            = var.subject.locality
      organization        = var.subject.organization
      organizational_unit = var.subject.organizational_unit
      postal_code         = var.subject.postal_code
      province            = var.subject.province
      serial_number       = var.subject.serial_number
    }
  }
}

resource "tls_locally_signed_cert" "ica" {
  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "digital_signature",
  ]
  is_ca_certificate  = true
  ca_cert_pem        = var.ca.cert
  ca_private_key_pem = var.ca.key
  cert_request_pem   = tls_cert_request.ica.cert_request_pem
  # 10 year validity
  validity_period_hours = var.validity_in_hours
}
