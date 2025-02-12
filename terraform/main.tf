provider "local" {}

resource "null_resource" "setup_apache" {
  provisioner "local-exec" {
    command = <<EOT
      # Update packages and install Apache non-interactively
      sudo -E apt update -y && \
      sudo -E apt install -y apache2 && \
      sudo -E systemctl enable apache2 && \
      sudo -E systemctl start apache2
    EOT
  }
}

resource "null_resource" "deploy_website" {
  depends_on = [null_resource.setup_apache]
  
  provisioner "local-exec" {
    command = <<EOT
      # Deploy website files
      sudo -E cp -r ${path.module}/website/* /var/www/html/
      sudo -E systemctl restart apache2
    EOT
  }
}

output "website_url" {
  value = "http://localhost"
}
