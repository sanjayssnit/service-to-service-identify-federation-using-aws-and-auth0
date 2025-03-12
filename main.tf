provider "aws" {
  region = "us-east-1"
}

# Lambda Module (No need to pass lambda_function_arn as an argument)
module "lambda" {
  source = "./modules/lambda"
}

# API Gateway Module (Pass the output of lambda module)
module "apigateway" {
  source              = "./modules/apigateway"
  oidc_audience       = var.oidc_audience
  oidc_issuer         = var.oidc_issuer
  lambda_function_arn = module.lambda.lambda_function_arn  # FIXED: This now correctly references the output
}
