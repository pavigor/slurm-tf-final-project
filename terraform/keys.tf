resource "tls_private_key" "ssh_key" {
  count = var.public_ssh_key_path == "" ? 1 : 0
  algorithm = "RSA"
}