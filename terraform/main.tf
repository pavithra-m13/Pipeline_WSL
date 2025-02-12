provider "local" {}

resource "null_resource" "setup_apache" {
  interpreter = ["bash", "-c"]
  provisioner "local-exec" {
    command = <<EOT
      # Update packages, install Apache, enable, and start the service
      echo '' | sudo -S apt update -y && \
      echo '' | sudo -S apt install -y apache2 && \
      sudo systemctl enable apache2 && \
      sudo systemctl start apache2
    EOT
  }
}

resource "null_resource" "deploy_website" {
  depends_on = [null_resource.setup_apache]
  
  provisioner "local-exec" {
    command = <<EOT
      # Deploy website files
      echo '' | sudo -S cp -r ${path.module}/website/* /var/www/html/
      sudo systemctl restart apache2
    EOT
  }
}

output "website_url" {
  value = "http://localhost"
}
