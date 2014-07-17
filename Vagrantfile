# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # this line causes the VM to be named.
  config.vm.define :adbox do |adbox|

    settings = {
      'src_folder' => "../../src/nanigans",
      'hostname' => "adbox.nanigans.com"
    }

    custom_settings = File.exists?('settings.yml') ? YAML.load_file('settings.yml') : {}

    settings.merge!(custom_settings)

    adbox.vm.box = "lucid64"
    adbox.vm.box_url = "http://files.vagrantup.com/lucid64.box"
    adbox.ssh.forward_agent = true
    adbox.vm.network "private_network", ip: "192.168.56.101"
    adbox.vm.hostname = settings['hostname']
    adbox.vm.synced_folder settings['src_folder'], "/var/www", {:mount_options => ['dmode=777','fmode=777']}

    # Ports
    adbox.vm.network :forwarded_port, guest: 3306, host: 8890, auto_correct: true
    adbox.vm.network :forwarded_port, guest: 5432, host: 5434, auto_correct: true
    adbox.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true # livereload port

    adbox.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "512"]
    end

    adbox.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "default.pp"
      puppet.module_path = "modules"
      #puppet.options = "--verbose --debug"
    end

    adbox.vm.provision :shell, :path => "scripts/enable_remote_mysql_access.sh"
  end
end

