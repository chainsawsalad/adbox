# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :adbox do |ae_config|
    ae_config.vm.box = "lucid32"
    ae_config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
    ae_config.ssh.forward_agent = true

    # This will give the machine a static IP uncomment to enable
    ae_config.vm.network :private_network, ip: "192.168.56.101"

    # Forward guest port 80 to host port 8888 and name mapping
    #ae_config.vm.network :forwarded_port, guest: 80, host: 8888
    ae_config.vm.network :forwarded_port, guest: 3306, host: 8890, auto_correct: true
    ae_config.vm.network :forwarded_port, guest: 5432, host: 5434, auto_correct: true
    # livereload port
    ae_config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true
    ae_config.vm.hostname = "adbox.nanigans.com"
    ae_config.vm.synced_folder "../../src/nanigans", "/var/www", {:mount_options => ['dmode=777','fmode=777']}

    ae_config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    # Enable the Puppet provisioner, with will look in manifests
    ae_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "default.pp"
      puppet.module_path = "modules"
      #puppet.options = "--verbose --debug"
    end

    ae_config.vm.provision :shell, :path => "scripts/enable_remote_mysql_access.sh"
  end
end

