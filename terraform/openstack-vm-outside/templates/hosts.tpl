[server]
${server_floating_ip} ansible_user=${outside_vm_user}

[client]
${client_floating_ip} ansible_user=${vm_user}

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

