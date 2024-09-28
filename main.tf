provider "aws" {
  region = "us-east-1"
}

resource "aws_cognito_user_pool" "my_user_pool" {
  name = "QuickServeUserPool"

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  mfa_configuration = "OPTIONAL"
}

resource "aws_cognito_user_pool_client" "my_user_pool_client" {
  name         = "MyAppClient"
  user_pool_id = aws_cognito_user_pool.my_user_pool.id
  generate_secret = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  callback_urls = ["https://myapp.com/callback"]
  logout_urls   = ["https://myapp.com/logout"]
}
