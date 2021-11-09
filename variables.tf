variable "yc_token" {}
variable "yc_cloud_id" {}
variable "yc_zone" {}
variable "yc_folder_id" {}
variable "yc_cores" {}
variable "yc_memory" {}
variable "yc_imageid" {}
variable "yc_disk_size" {}
variable "vm_count" {
  default = "1"
  description = "Number of vm"
  }
