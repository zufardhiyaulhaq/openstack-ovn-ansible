resource "openstack_compute_instance_v2" "vm0" {
  name = "vm0"
  image_name = var.vm_image
  flavor_name = var.vm_flavor
  key_pair = var.vm_keypair
  security_groups = var.vm_securitygroup
  availability_zone = var.vm0_zone
  user_data = file("${path.module}/templates/userdata.yml")

  network {
    name = var.vm0_network
  }
}

resource "openstack_networking_floatingip_v2" "floatip_0" {
  pool = var.floatip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floatip_associate_0" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_0.address}"
  instance_id = "${openstack_compute_instance_v2.vm0.id}"
}

resource "openstack_compute_instance_v2" "vm1" {
  name = "vm1"
  image_name = var.vm_image
  flavor_name = var.vm_flavor
  key_pair = var.vm_keypair
  security_groups = var.vm_securitygroup
  availability_zone = var.vm1_zone
  user_data = file("${path.module}/templates/userdata.yml")

  network {
    name = var.vm1_network
  }
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = var.floatip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floatip_associate_1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.vm1.id}"
}

output "vm0 private ip" {
  value = openstack_compute_instance_v2.vm0.access_ip_v4
}

output "vm0 public ip" {
  value = openstack_networking_floatingip_v2.floatip_0.address
}

output "vm1 private ip" {
  value = openstack_compute_instance_v2.vm1.access_ip_v4
}

output "vm1 public ip" {
  value = openstack_networking_floatingip_v2.floatip_1.address
}
