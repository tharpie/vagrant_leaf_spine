# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "vEOS-4.20.7M"

    config.vm.define "leaf1" do |leaf1|
        leaf1.vm.provision "shell", path: "scripts/base-config.sh leaf1"
        leaf1.vm.network "forwarded_port", guest: 80, host: 8080
        leaf1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf1.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf1-spine2"]
            end
        end

    config.vm.define "leaf2" do |leaf2|
        leaf2.vm.provision "shell", path: "scripts/base-config.sh leaf2"
        leaf2.vm.network "forwarded_port", guest: 80, host: 8081
        leaf2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf2.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf2-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine2"]
            end
        end

    config.vm.define "leaf3" do |leaf3|
        leaf3.vm.provision "shell", path: "scripts/base-config.sh leaf3"
        leaf3.vm.network "forwarded_port", guest: 80, host: 8082
        leaf3.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf3.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        leaf3.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf3-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf3-spine2"]
            end
        end

    config.vm.define "spine1" do |spine1|
        spine1.vm.provision "shell", path: "scripts/base-config.sh spine1"
        spine1.vm.network "forwarded_port", guest: 80, host: 8083
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine1.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine1"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine1"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf3-spine1"]
            v.customize ["modifyvm", :id, "--nic5", "intnet", "--intnet4", "spine1-spine2"]
            end
        end

    config.vm.define "spine2" do |spine2|
        spine2.vm.provision "shell", path: "scripts/base-config.sh spine2"
        spine2.vm.network "forwarded_port", guest: 80, host: 8084
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: true, auto_config: false
        spine2.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "leaf1-spine2"]
            v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "leaf2-spine2"]
            v.customize ["modifyvm", :id, "--nic4", "intnet", "--intnet4", "leaf3-spine2"]
            v.customize ["modifyvm", :id, "--nic5", "intnet", "--intnet4", "spine1-spine2"]
            end
        end
end
