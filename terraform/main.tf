provider "local" {}

resource "null_resource" "setup_apache" {
  provisioner "local-exec" {
    command = <<EOT
      # Update packages, install Apache, enable, and start the service
      echo '' | sudo -S apt update -y && \
      echo '' | sudo -S apt install -y apache2 && \
      sudo systemctl enable apache2 && \
      sudo systemctl start apache2
      # Check the status of Apache service
      sudo systemctl status apache2 --no-pager
    EOT
  }
}




