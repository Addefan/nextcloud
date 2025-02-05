resource "yandex_compute_instance" "server" {
  name        = "server"
  platform_id = "standard-v3"
  hostname    = "ubuntu"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("${var.ssh_key_path}.pub")}"
  }
}

resource "yandex_vpc_network" "network" {
  name = "server-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "server-subnet"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.0.0/24"]
  network_id     = yandex_vpc_network.network.id
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2404-lts-oslogin"
}

resource "yandex_compute_disk" "boot_disk" {
  name     = "server-boot-disk"
  type     = "network-ssd"
  image_id = data.yandex_compute_image.ubuntu_image.id
  size     = 10
}
