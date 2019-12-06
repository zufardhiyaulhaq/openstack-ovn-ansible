# OpenStack OVN Ansible
This ansible script will provisioning OpenStack with OVN (Open Virtual Network) Enabled.

### Tested
- OpenStack Queens
- 1 controller 3 compute
- OpenvSwitch 1.12.0

### Limitation
- Only support single controller
```
zu-ovn-controller0
Interface Management (eth0) : 10.100.100.200

zu-ovn-compute0
Interface Management (eth0) : 10.100.100.203
Interface Data       (eth1) : 10.101.101.203
Interface External   (eth2) : no ip address

zu-ovn-compute1
Interface Management (eth0) : 10.100.100.204
Interface Data       (eth1) : 10.101.101.204
Interface External   (eth2) : no ip address

zu-ovn-compute2
Interface Management (eth0) : 10.100.100.205
Interface Data       (eth1) : 10.101.101.205
Interface External   (eth2) : no ip address

zu-ovn-bootstrap
Interface Management (eth0) : 10.100.100.210
```
### Installation
- Setup hosts mapping
```
nano /etc/hosts

10.100.100.200 zu-ovn-controller1
10.100.100.203 zu-ovn-compute1
10.100.100.204 zu-ovn-compute2
10.100.100.205 zu-ovn-compute3
```
- Setup and copy key from bootstrap node to all nodes
```
yum install sshpass
ssh-keygen

sshpass -p "rahasia" ssh-copy-id -o StrictHostKeyChecking=no root@zu-ovn-controller0
sshpass -p "rahasia" ssh-copy-id -o StrictHostKeyChecking=no root@zu-ovn-compute0
sshpass -p "rahasia" ssh-copy-id -o StrictHostKeyChecking=no root@zu-ovn-compute1
sshpass -p "rahasia" ssh-copy-id -o StrictHostKeyChecking=no root@zu-ovn-compute2
```
- Install ansible in bootstrap node
```
yum -y update
yum -y install epel-release
yum -y install nano git python python-pip

pip install ansible==2.5.5
```
-  Disable ansible host key checking
```
nano ~/.ansible.cfg

[defaults]
host_key_checking = False
```
- Clone Repository
```
git clone https://github.com/zufardhiyaulhaq/openstack-ovn-ansible.git
```
- Edit value
```
group_vars/all.yml
hosts/hosts
```
- Run Ansible
```
ansible-playbook main.yml -i hosts/hosts
```