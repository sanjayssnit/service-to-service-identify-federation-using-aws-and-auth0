variable "oidc_audience" {
  description = "OIDC API Audience (API Identifier)"
  type        = string
}

variable "oidc_issuer" {
  description = "OIDC Provider Issuer URL"
  type        = string
}

variable "lambda_function_arn" {
  description = "Lambda function ARN to integrate with API Gateway"
  type        = string
}
