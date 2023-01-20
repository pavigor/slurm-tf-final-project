variable "image_name" {
  type        = string
  description = "Name of the image to deploy"
}

variable "image_tag" {
  type        = number
  description = "Image version"
}

variable "vm_resources" {
  type = object({
    memory = number
    cores  = number
  })
  description = "VM resources"
}

variable "instance_group_size" {
  type        = number
  description = "Size of the instance group"
  default     = 1
}

variable "az" {
  type        = list(string)
  description = "A list of availability zones"
  default     = [ "ru-central1-a", "ru-central1-b", "ru-central1-c" ]
}

variable "labels" {
  type        = map
  description = "Labels applied to resources"
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for network"
}

# Instance group settings
variable "environment" {
  type        = string
  description = "Type of environment (qa, prod, dev)"
  default     = "dev"
}

variable "deploy_policy" {
  type = object({
    max_unavailable = number
    max_creating    = number
    max_expansion   = number
    max_deleting    = number
  })
  description = "The deployment policy of the instance group"
}

variable "instance_group_labels" {
  type        = map
  description = "Labels for instance group"
}

variable "instance_group_metadata" {
  type        = map
  description = "Metadata for instance group"
}

variable "allocate_external_ip" {
  type        = bool
  description = "Allocate external IPv4 address on instance"
}

variable "public_ssh_key_path" {
  type        = string
  default     = ""
  description = "Path to ssh public key"
}