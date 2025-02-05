resource "local_file" "inventory_file" {
  content  = <<-EOT
    all:
      children:
        webservers:
          hosts:
            server:
              ansible_host: ${yandex_compute_instance.server.network_interface[0].nat_ip_address}
              ansible_ssh_private_key_file: ${var.ssh_key_path}
  EOT
  filename = "../ansible/inventory.yml"
}

resource "null_resource" "apply_ansible" {
  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook --become --become-user root --become-method sudo \
                       -i ../ansible/hosts.yml ../ansible/nextcloud.yml
    EOT
  }

  depends_on = [
    yandex_compute_instance.server,
    local_file.inventory_file,
  ]

  triggers = {
    always_run = timestamp()
  }
}
