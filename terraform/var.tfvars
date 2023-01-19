image_name = "nginx"
image_tag  = 2

vm_resources = {
  cores  = 2
  memory = 2
}

instance_group_size = 3

labels = {
  env = "prod"
}

cidr_blocks = [ "10.2.0.0/24", "10.3.0.0/24", "10.4.0.0/24" ]

# Instance group settings
deploy_policy = {
  max_unavailable = 2
  max_creating    = 2
  max_expansion   = 2
  max_deleting    = 2
}

instance_group_labels = {
  name = "slurm"
}

instance_group_metadata = {}