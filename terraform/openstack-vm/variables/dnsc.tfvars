# openstack auth related vars
os_username = "admin"
os_tenant = "admin"
os_password = "ADMIN_PASS"
os_auth = "http://10.200.100.200:5000/v3"
os_region = "RegionOne"
os_domain = "default"

# openstack virtual machine related vars
vm_securitygroup = ["sg-standard"]
vm_keypair = "ansible-ssh"
vm_flavor = "m1.large"
vm_image = "ubuntu-xenial"

# openstack networking
floatip_pool = "external"

# openstack virtual machine 0
vm0_network = "internal-0"
vm0_zone = "compute0"

# openstack virtual machine 1
vm1_network = "internal-1"
vm1_zone = "compute0"

# openstack type & kind
os_type = "ovn"
vm_type = "dnsc"
vm_user = "ubuntu"
