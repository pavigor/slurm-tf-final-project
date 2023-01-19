resource "yandex_iam_service_account" "this" {
  name        = "tfmanager"
  description = "Service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = "b1g8o93jben5u4opcnm7"
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.this.id}"
  ]
}