
# Terraform configuration
terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.9"
    }
  }
}

# Render provider configuration
provider "render" {
  # Credentials are read from PowerShell environment variables
  wait_for_deploy_completion = true
}

# Create a Render Web Service
resource "render_web_service" "microservice" {

  name   = "terraform-render-microservice"
  plan   = "starter"
  region = "singapore"

  # Application start command
  start_command = "npm start"

  # Health check
  health_check_path = "/"

  # GitHub repository and Node.js configuration
  runtime_source = {
    native_runtime = {
      auto_deploy = true
      branch      = "main"

      build_command = "npm install"

      repo_url = "https://github.com/Devarapalli-Swetha/terraform-render-microservice"

      runtime = "node"
    }
  }
}

# Display service URL
output "microservice_url" {
  value = render_web_service.microservice.url
}

# Display service ID
output "service_id" {
  value = render_web_service.microservice.id
}
