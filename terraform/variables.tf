variable "cloud_id" {
  type        = string
  description = "Идентификатор облака по умолчанию"
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога по умолчанию"
}

variable "zone" {
  type        = string
  description = "Зона доступности по умолчанию"
  default     = "ru-central1-d"
}

variable "sa_key_file_path" {
  type        = string
  description = "Путь к ключу сервисного аккаунта с ролью admin"
  default     = "~/.yc-keys/key.json"
}

variable "ssh_key_path" {
  type        = string
  description = "Путь к SSH-ключу для сервера"
  default     = "~/.ssh/vvot"
}
