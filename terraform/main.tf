locals {
  prefix = "stage-"
}

data "yandex_compute_image" "this" {
  name = join("-",["${var.image_name}", "${var.image_tag}"])
}

data "yandex_vpc_subnet" "this" {
  subnet_id = "${yandex_vpc_network.this.id}"
}


resource "yandex_compute_instance_group" "this" {
  name                = "${local.prefix}ig-1"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = false

  instance_template {
    platform_id = "standard-v1"
    name        = "${var.environment}-{instance.zone_id}-{instance_group.id}-{instance.short_id}"
    resources {
        memory = var.vm_resources.memory
        cores  = var.vm_resources.cores
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.this.id}"
        size     = 10
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.this.id}"
      subnet_ids = data.yandex_vpc_subnet.this.v4_cidr_blocks
      nat        = var.allocate_external_ip
    }
    
    labels   = var.instance_group_labels
    
    metadata = {
      ssh-keys = var.public_ssh_key_path != "" ? "centos:${file(var.public_ssh_key_path)}" : "centos:${tls_private_key.ssh_key[0].public_key_openssh}"
    }
    
    network_settings {
      type = "STANDARD"
    }
  }

  application_load_balancer {
    target_group_name = "${var.environment}-alb-tg"
  }

  scale_policy {
    fixed_scale {
      size = var.instance_group_size
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = var.deploy_policy.max_unavailable
    max_creating    = var.deploy_policy.max_creating
    max_expansion   = var.deploy_policy.max_expansion
    max_deleting    = var.deploy_policy.max_deleting
  }

  depends_on = [
    yandex_iam_service_account.this, yandex_resourcemanager_folder_iam_binding.this
  ]
}