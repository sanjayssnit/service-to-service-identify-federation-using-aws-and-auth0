resource "aws_apigatewayv2_api" "http_api" {
  name          = "oidc-protected-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "jwt_auth" {
  name              = "OIDCJWTAuthorizer"
  api_id            = aws_apigatewayv2_api.http_api.id
  authorizer_type   = "JWT"
  identity_sources  = ["$request.header.Authorization"]

  jwt_configuration {
    audience = [var.oidc_audience]  # API Identifier from OIDC Provider
    issuer   = var.oidc_issuer      # Issuer URL from OIDC Provider
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_function_arn
}

resource "aws_apigatewayv2_route" "secure_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "GET /protected"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_auth.id
  target             = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}
