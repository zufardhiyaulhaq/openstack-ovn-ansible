resource "openstack_compute_instance_v2" "vm0" {
  name              = "vm0"
  image_name        = var.vm_image
  flavor_name       = var.vm_flavor
  key_pair          = var.vm_keypair
  security_groups   = var.vm_securitygroup
  availability_zone = var.vm0_zone
  user_data         = file("${path.module}/templates/userdata.yml")

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
  name              = "vm1"
  image_name        = var.vm_image
  flavor_name       = var.vm_flavor
  key_pair          = var.vm_keypair
  security_groups   = var.vm_securitygroup
  availability_zone = var.vm1_zone
  user_data         = file("${path.module}/templates/userdata.yml")

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

output "vm0_private_ip" {
  value = openstack_compute_instance_v2.vm0.access_ip_v4
}

output "vm0_public_ip" {
  value = openstack_networking_floatingip_v2.floatip_0.address
}

output "vm1_private_ip" {
  value = openstack_compute_instance_v2.vm1.access_ip_v4
}

output "vm1_public_ip" {
  value = openstack_networking_floatingip_v2.floatip_1.address
}

output "os_type" {
  value = var.os_type
}

output "vm_type" {
  value = var.vm_type
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 400"
  }

  depends_on = [
    openstack_compute_floatingip_associate_v2.floatip_associate_0,
    openstack_compute_floatingip_associate_v2.floatip_associate_1,
  ]
}


data "template_file" "group_vars" {
  template = "${file("./templates/group_vars.yml.tpl")}"
  vars = {
    server_local_ip = openstack_compute_instance_v2.vm0.access_ip_v4
    client_local_ip = openstack_compute_instance_v2.vm1.access_ip_v4
    os_type         = var.os_type
    vm_type         = var.vm_type
  }
}

resource "local_file" "group_vars_file" {
  content  = "${data.template_file.group_vars.rendered}"
  filename = "../../ansible/iperf-benchmark/${var.os_type}_${var.vm_type}_ansible_vars.yml"

  depends_on = [
    null_resource.delay,
  ]
}

data "template_file" "hosts" {
  template = "${file("./templates/hosts.tpl")}"
  vars = {
    server_floating_ip = openstack_networking_floatingip_v2.floatip_0.address
    client_floating_ip = openstack_networking_floatingip_v2.floatip_1.address
    vm_user            = var.vm_user
  }
}

resource "local_file" "hosts_file" {
  content  = "${data.template_file.hosts.rendered}"
  filename = "../../ansible/iperf-benchmark/${var.os_type}_${var.vm_type}_hosts"

  depends_on = [
    null_resource.delay,
  ]
}

resource "null_resource" "exec_ansible" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ../../ansible/iperf-benchmark/${var.os_type}_${var.vm_type}_hosts --extra-vars "@../../ansible/iperf-benchmark/${var.os_type}_${var.vm_type}_ansible_vars.yml" ../../ansible/iperf-benchmark/main.yml"
  }

  depends_on = [
    local_file.group_vars_file,
    local_file.hosts_file,
  ]
}
