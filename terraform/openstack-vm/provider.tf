provider "openstack" {
  user_name   = var.os_username
  domain_name = var.os_domain
  tenant_name = var.os_tenant
  password    = var.os_password
  auth_url    = var.os_auth
  region      = var.os_region
}
