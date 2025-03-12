variable "oidc_audience" {
  description = "OIDC API Audience (API Identifier)"
  type        = string
  default     = "https://example-api.com"
}

variable "oidc_issuer" {
  description = "OIDC Provider Issuer URL"
  type        = string
  default     = "https://example-tenant.us.auth0.com/"
}
