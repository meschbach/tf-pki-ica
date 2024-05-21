output "pki_cert" {
  value = {
    ca   = concat([tls_locally_signed_cert.ica.cert_pem], var.ca.ca)
    cert = tls_locally_signed_cert.ica.cert_pem
    key  = tls_private_key.ica.private_key_pem
  }
}
