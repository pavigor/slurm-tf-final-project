resource "yandex_alb_backend_group" "this" {
  name = "${var.environment}-alb-backend-group"
  http_backend {
    name = "${var.environment}-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_compute_instance_group.this.application_load_balancer.0.target_group_id}"]
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "false"
  }
}

resource "yandex_alb_http_router" "this" {
  name      = "${var.environment}-http-router"
}

resource "yandex_alb_virtual_host" "this" {
  name      = "${var.environment}-virtual-host"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "${var.environment}-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout = "3s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {

  name = "${var.environment}-alb"
  labels = var.labels

  network_id = yandex_vpc_network.this.id

  listener {
    name = "${var.environment}-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }


  allocation_policy {
    dynamic "location" {
      for_each = var.az
      content {
        zone_id   = location.value
        subnet_id = yandex_vpc_subnet.this[location.value].id 
      }
    }
  }
}