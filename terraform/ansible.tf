resource "local_file" "inventory_file" {
  content = <<-EOT
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
