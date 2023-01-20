output "alb_external_ip" {
  value       = tolist(tolist(tolist(tolist(yandex_alb_load_balancer.this.listener).0.endpoint).0.address).0.external_ipv4_address).0.address
  description = "Application load balancer external address"
}

output "private_ssh_key" {
  value     = var.public_ssh_key_path != "" ? "" : "${tls_private_key.ssh_key[0].private_key_openssh}"
  sensitive = true
}

output "public_ip_addresses" {
  value       = zipmap(tolist(yandex_compute_instance_group.this.instances).*.instance_id, flatten(tolist(tolist(yandex_compute_instance_group.this.instances).*.network_interface).*).*.nat_ip_address)
  description = "List of key-value pairs instance_id=nat_ip_address"
}

output "private_ip_addresses" {
  value       = zipmap(tolist(yandex_compute_instance_group.this.instances).*.instance_id, flatten(tolist(tolist(yandex_compute_instance_group.this.instances).*.network_interface).*).*.ip_address)
  description = "List of key-value pairs instance_id=ip_address"
}