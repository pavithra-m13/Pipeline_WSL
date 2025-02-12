output "website_url" {
  description = "The URL where the website is accessible."
  value       = "http://localhost"
}

output "apache_status" {
  description = "The status of the Apache service."
  value = "Apache is installed, enabled, and started."
}

output "website_deployment_message" {
  description = "Message indicating the website deployment is complete."
  value = "Website files have been deployed to /var/www/html/"
}
