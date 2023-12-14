provider "aws" {
  alias      = "aws"
  region     = "us-east-1"
  access_key = data.vault_generic_secret.access_key.data["ACCESS_KEY"]
  secret_key = data.vault_generic_secret.secret_key.data["SECRET_KEY"]
}

variable "login_username" {
  description = "The username used for authentication during the login process."
  default     = "tsrlearning"
}

variable "login_password" {
  description = "The password associated with the corresponding login_username for authentication."
  default     = ""
}

data "vault_generic_secret" "password" {
  path = "kv/DefaultUserCredentials"
}

data "vault_generic_secret" "access_key" {
  path = "kv/AWSCredentials"
}

data "vault_generic_secret" "secret_key" {
  path = "kv/AWSCredentials"
}


provider "vault" {
  alias   = "vault"
  address = "https://vault-dev.tsrlearning.link:8200"
  auth_login {
    path = "auth/userpass/login/${var.login_username}"

    parameters = {
      password = var.login_password
    }
  }
}