 resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
     hostname = yandex_compute_instance.vm.*.name,
     address_vm = yandex_compute_instance.vm.*.network_interface.0.nat_ip_address,
    }
  )
  filename = "inventory"
  provisioner "local-exec" {
    command = "ansible-playbook ./playbook9.yml"
  }
}
