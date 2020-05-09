variable "os_username" {
  type = string
}

variable "os_tenant" {
  type = string
}

variable "os_password" {
  type = string
}

variable "os_auth" {
  type = string
}

variable "os_region" {
  type = string
}

variable "os_domain" {
  type = string
}

variable "vm_securitygroup" {
  type = list(string)
}

variable "vm_keypair" {
  type = string
}

variable "vm_flavor" {
  type = string
}

variable "vm_image" {
  type = string
}

variable "floatip_pool" {
  type = string

}

variable "vm0_zone" {
  type = string
}

variable "vm0_network" {
  type = string
}

variable "vm1_zone" {
  type = string
}

variable "vm1_network" {
  type = string
}

variable "os_type" {
  type = string
}

variable "vm_type" {
  type = string
}
