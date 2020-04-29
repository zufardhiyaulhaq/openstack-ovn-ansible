# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'

  (0..0).each do |i|
    config.vm.define "zu-ovn-controller-#{i}" do |db|
      db.vm.hostname = "zu-ovn-controller-#{i}"
      db.vm.network 'private_network', ip: "10.200.100.20#{i}"
      db.vm.network 'private_network', ip: "10.201.101.20#{i}"
      db.vm.provider 'virtualbox' do |vb|
        vb.name = "zu-ovn-controller-#{i}"
        vb.memory = 8000
        vb.cpus = 4
      end
    end
  end

  (0..2).each do |i|
    config.vm.define "zu-ovn-compute-#{i}" do |web|
      web.vm.hostname = "zu-ovn-compute-#{i}"
      web.vm.network 'private_network', ip: "10.200.100.21#{i}"
      web.vm.network 'private_network', ip: "10.201.101.21#{i}"
      web.vm.network 'private_network', ip: "10.201.102.21#{i}", auto_config: false
      web.vm.provider 'virtualbox' do |vb|
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
