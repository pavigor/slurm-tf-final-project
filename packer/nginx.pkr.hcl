

source "yandex" "this" {
    token               = "${var.yandex_provider.token}"
    folder_id           = "${var.yandex_provider.folder_id}"
    source_image_family = "${var.source_image_family}"
    ssh_username        = "${var.ssh_username}"
    image_name          = join("-", ["${var.image.name}","${var.image.tag}"])
    use_ipv4_nat        = true
}

build {
    sources = [
        "source.yandex.this"
    ]

    provisioner "ansible" {
        ansible_env_vars =[ "ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_SSH_ARGS='-o ForwardAgent=yes -o ControlMaster=auto -o ControlPersist=60s'"]
        user             = "${var.ssh_username}"
        playbook_file    = "./playbook.yml"
        use_proxy        = false
    }
}