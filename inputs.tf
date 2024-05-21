variable "ca" {
  type = object({
    ca   = list(string)
    cert = string
    key  = string
  })
}

variable "subject" {
  type        = object({
    common_name = optional(string)
    country             = optional(string)
    locality            = optional(string)
    organization        = optional(string)
    organizational_unit = optional(string)
    postal_code         = optional(string)
    province            = optional(string)
    serial_number       = optional(number)
  })
  description = "Root certificate subject"
}

variable "validity_in_hours" {
  # 10 years
  default = 10 * 365 * 24
}