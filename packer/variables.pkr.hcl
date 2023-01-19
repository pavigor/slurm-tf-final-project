variable "yandex_provider" {
  type = object({
    token     = string
    folder_id = string
  })
  sensitive   = true
  description = "Yandex Cloud provider settings"
}

variable "ssh_username" {
  type        = string
  default     = "centos"
  description = "Default ssh username"
}

variable "source_image_family" {
  type        = string
  default     = "centos-7"
  description = "Source image family for build dest image"
}

variable "image_name" {
  type        = string
  description = "Name of the image"
}

variable "image_tag" {
  type        = number
  description = "Tag of the image"
}
