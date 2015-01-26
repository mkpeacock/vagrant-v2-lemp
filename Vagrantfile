# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder ".", "/var/www/project", type: "nfs"

  config.vm.provision "shell", inline: "apt-get update"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "provision/manifests"
    puppet.module_path = "provision/modules"
    puppet.manifest_file  = "vagrant.pp"
  end

end
