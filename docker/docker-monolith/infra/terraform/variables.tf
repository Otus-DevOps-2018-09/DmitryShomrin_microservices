variable project {
  description = "Project ID"
}
variable proj_zone {
  description = "project zone"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable "private_key_path" {
  description = "private key path"
}

variable "zone" {
  description = "Zone name"
  default     = "europe-west1-b"
}

variable "app_count" {
  description = "App count"
  default     = "1"
}
