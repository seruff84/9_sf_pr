resource "yandex_compute_instance" "vm" {
  name		= "sf-9-vm0${count.index+1}"
  count     = var.vm_count
  resources {
    cores         = var.yc_cores
    memory        = var.yc_memory
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.yc_imageid
      size     = var.yc_disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  metadata = {
    ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("./meta.txt")}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 python3-pip -y", "echo Done!"]
    on_failure = continue
    connection {
      host        = "${self.network_interface.0.nat_ip_address}"
      type        = "ssh"
      user        = "seruff"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
 }
  provisioner "local-exec" {
    command = "ansible-playbook ./playbook9.yml"
  }
}

output "external_ip_addresses" {
  value = yandex_compute_instance.vm.*.network_interface.0.nat_ip_address
}

#output "count_external_ip_addresses" {
#  value = length(yandex_compute_instance.vm)
#}
