# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'

  (0..0).each do |i|
    config.vm.define "zu-ovn-controller-#{i}" do |controller|
      controller.vm.hostname = "zu-ovn-controller-#{i}"
      controller.vm.network 'private_network', ip: "10.200.100.20#{i}"
      controller.vm.network 'private_network', ip: "10.201.101.20#{i}"
      controller.vm.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      controller.vm.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      controller.vm.provider 'virtualbox' do |vb|
        vb.name = "zu-ovn-controller-#{i}"
        vb.memory = 8000
        vb.cpus = 4
      end
    end
  end

  (0..2).each do |i|
    config.vm.define "zu-ovn-compute-#{i}" do |compute|
      compute.vm.hostname = "zu-ovn-compute-#{i}"
      compute.vm.network 'private_network', ip: "10.200.100.21#{i}"
      compute.vm.network 'private_network', ip: "10.201.101.21#{i}"
      compute.vm.network 'private_network', ip: "10.201.102.21#{i}", auto_config: false
      compute.vm.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      compute.vm.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      compute.vm.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      compute.vm.provider 'virtualbox' do |vb|
        vb.name = "zu-ovn-compute-#{i}"
        vb.memory = 8000
        vb.cpus = 4
      end
    end
  end

  config.vm.provision 'deploy', type: 'ansible', run: 'never' do |ansible|
    ansible.version = '2.5.5'
    ansible.groups = {
      'controllers' => %w[zu-ovn-controller-0],
      'computes' => %w[zu-ovn-compute-0 zu-ovn-compute-1 zu-ovn-compute-2]
    }
    ansible.playbook = 'provisioning/main.yml'
    ansible.extra_vars = { ansible_python_interpreter: '/usr/bin/python' }
  end
end
