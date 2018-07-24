# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    # Please config.vm.box to local defined box
    # Demo currently using vEOS-lab-4.20.5.2F-virtualbox.box
    # used the following command to add box:
    #   vagrant box add vEOS-lab-4.20.5.2F-virtualbox.box --name 'vEOS-4.20.5.2F'
    #
    config.vm.box = "vEOS-4.20.5.2F"

    config.vm.define "leaf1" do |leaf1|
        leaf1.vm.provision "shell", path: "scripts/base-config.sh", args: "leaf1"
        leaf1.vm.network "forwarded_port", guest: 80, host: 8080
        leaf1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf1.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf1-spine2"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf1"]
            end
        end

    config.vm.define "leaf2" do |leaf2|
        leaf2.vm.provision "shell", path: "scripts/base-config.sh", args: "leaf2"
        leaf2.vm.network "forwarded_port", guest: 80, host: 8081
        leaf2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf2.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf2-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine2"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf2"]
            end
        end

    config.vm.define "leaf3" do |leaf3|
        leaf3.vm.provision "shell", path: "scripts/base-config.sh", args: "leaf3"
        leaf3.vm.network "forwarded_port", guest: 80, host: 8082
        leaf3.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf3.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf3.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf3-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf3-spine2"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf3"]
            end
        end

    config.vm.define "spine1" do |spine1|
        spine1.vm.provision "shell", path: "scripts/base-config.sh", args: "spine1"
        spine1.vm.network "forwarded_port", guest: 80, host: 8083
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine1"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf3-spine1"]
            v.customize ["modifyvm", :id, "--nic5", "intnet", "--intnet5", "spine1-spine2"]
            end
        end

    config.vm.define "spine2" do |spine2|
        spine2.vm.provision "shell", path: "scripts/base-config.sh", args: "spine2"
        spine2.vm.network "forwarded_port", guest: 80, host: 8084
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine2"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine2"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf3-spine2"]
            v.customize ["modifyvm", :id, "--nic5", "intnet", "--intnet5", "spine1-spine2"]
            end
        end

    config.vm.define "host1" do |host1|
        host1.vm.box = "centos7"
        host1.vm.provision "shell", path: "scripts/host-config.sh", args: "192.168.11.100"
        host1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        host1.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1"]
            end
        end
    
    config.vm.define "host2" do |host2|
        host2.vm.box = "centos7"
        host2.vm.provision "shell", path: "scripts/host-config.sh", args: "192.168.12.100"
        host2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        host2.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf2"]
            end
        end
    
    config.vm.define "host3" do |host3|
        host3.vm.box = "centos7"
        host3.vm.provision "shell", path: "scripts/host-config.sh", args: "192.168.13.100"
        host3.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        host3.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf3"]
            end
        end

end
