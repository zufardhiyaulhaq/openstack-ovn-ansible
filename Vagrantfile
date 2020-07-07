# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  
  # change disk size if neccessary
  # https://medium.com/@kanrangsan/how-to-automatically-resize-virtual-box-disk-with-vagrant-9f0f48aa46b3
  # config.disksize.size = '100GB'

  (0..0).each do |i|
    config.vm.define "zu-ovn-controller-#{i}" do |controller|
      controller.vm.hostname = "zu-ovn-controller-#{i}"
      controller.vm.network 'private_network', ip: "10.200.100.20#{i}"
      controller.vm.network 'private_network', ip: "10.201.101.20#{i}"
      controller.vm.provider 'virtualbox' do |vb|
        vb.name = "zu-ovn-controller-#{i}"
        vb.memory = 8000
        vb.cpus = 4
        vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
        vb.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      end
    end
  end

  (0..2).each do |i|
    config.vm.define "zu-ovn-compute-#{i}" do |compute|
      compute.vm.hostname = "zu-ovn-compute-#{i}"
      compute.vm.network 'private_network', ip: "10.200.100.21#{i}"
      compute.vm.network 'private_network', ip: "10.201.101.21#{i}"
      compute.vm.network 'private_network', ip: "10.201.102.21#{i}", auto_config: false
      compute.vm.provider 'virtualbox' do |vb|
        vb.name = "zu-ovn-compute-#{i}"
        vb.memory = 8000
        vb.cpus = 4
        vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
        vb.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
        vb.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      end
    end
  end

  $script = <<-'SCRIPT'
  sudo apt update -y
  sudo apt install python3 python3-pip python-virtualenv -y
  SCRIPT

  config.vm.define 'zu-ovn-internet' do |internet|
    internet.vm.box = 'hashicorp/bionic64'
    internet.vm.hostname = 'zu-ovn-internet'
    internet.vm.network 'private_network', ip: '10.201.102.250'
    internet.vm.provision 'shell', inline: $script
    internet.vm.provider 'virtualbox' do |vb|
      vb.name = 'zu-ovn-internet'
      vb.memory = 4096
      vb.cpus = 2
    end
  end

  config.vm.provision 'deploy', type: 'ansible', run: 'never' do |ansible|
    ansible.version = '2.5.5'
    ansible.groups = {
      'controllers' => %w[zu-ovn-controller-0],
      'computes' => %w[zu-ovn-compute-0 zu-ovn-compute-1 zu-ovn-compute-2]
    }
    ansible.playbook = 'ansible/openstack-install/deploy.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python' }
  end

  config.vm.provision 'post-deploy', type: 'ansible', run: 'never' do |ansible|
    ansible.version = '2.5.5'
    ansible.groups = {
      'controllers' => %w[zu-ovn-controller-0],
      'computes' => %w[zu-ovn-compute-0 zu-ovn-compute-1 zu-ovn-compute-2]
    }
    ansible.playbook = 'ansible/openstack-install/post-deploy.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python' }
  end

  config.vm.provision 'addons-octavia', type: 'ansible', run: 'never' do |ansible|
    ansible.version = '2.5.5'
    ansible.groups = {
      'controllers' => %w[zu-ovn-controller-0],
      'computes' => %w[zu-ovn-compute-0 zu-ovn-compute-1 zu-ovn-compute-2]
    }
    ansible.playbook = 'ansible/openstack-install/addons-octavia.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python' }
  end
end
