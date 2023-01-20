terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

# https://cloud.yandex.com/en/docs/tutorials/infrastructure-management/terraform-quickstart
provider "yandex" {

}
