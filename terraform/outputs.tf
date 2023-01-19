output "alb_external_ip" {
  value = "${yandex_alb_load_balancer.this.listener[*].endpoint[*].address[*].external_ipv4_address}"
}