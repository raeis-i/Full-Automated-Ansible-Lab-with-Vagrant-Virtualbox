require_relative 'vars'
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  (1..NUM_NODES).each do |node_id|
    config.vm.define "node#{node_id}" do |node_vm|
      node_vm.vm.box = IMAGE_Ubuntu
      node_vm.vm.hostname = "node#{node_id}"
      node_vm.vm.network "private_network", ip: "#{NETWORK_RANGE}#{node_id}"
      node_vm.vm.provider "virtualbox" do |v|
        v.name = "Node#{node_id}"
      end
      
      #Run bootstrap.sh in all nodes in order to change ssh setting and modify /etc/hosts 
      node_vm.vm.provision "shell", path: "bootstrap.sh", args: [NUM_NODES, NETWORK_RANGE]
      
      #Copy 2 files in node 1 only to install Ansible and copy key for ssh 
      if node_id == 1
        node_vm.vm.provision "file", source: "ansible.sh", destination: "/home/vagrant/ansible.sh"
        node_vm.vm.provision "file", source: "vars.rb", destination: "/home/vagrant/vars.rb"
      end

    end

  end
  
end
