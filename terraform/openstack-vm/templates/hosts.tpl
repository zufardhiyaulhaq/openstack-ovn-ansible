[server]
${server_floating_ip} 

[client]
${client_floating_ip}

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_user=${vm_user}
