# OpenStack OVN Ansible
This ansible script will provisioning OpenStack with OVN (Open Virtual Network) Enabled.

### Tested
- OpenStack Queens
- 1 controller 3 compute
- OpenvSwitch 1.11.0

### Requirement
- virtualbox
- vagrant
- ansible 2.5.5
- terraform (optional)

### Installation
- install vagrant plugin
```
vagrant plugin install vagrant-disksize
```

- start vagrant
```
vagrant up
```

- provisioning openstack
```
vagrant provision --provision-with deploy
vagrant provision --provision-with post-deploy
```

- Add compute to spesific zone if necessary
```
vagrant ssh zu-ovn-controller-0

source /root/admin_rc
nova-manage cell_v2 discover_hosts --verbose

openstack aggregate create compute0
openstack aggregate create compute1
openstack aggregate create compute2

openstack aggregate set --zone compute0 compute0
openstack aggregate set --zone compute1 compute1
openstack aggregate set --zone compute2 compute2

openstack aggregate add host compute0 zu-ovn-compute-0
openstack aggregate add host compute1 zu-ovn-compute-1
openstack aggregate add host compute2 zu-ovn-compute-2
```
