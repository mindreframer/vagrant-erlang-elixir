# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  #config.vm.synced_folder "data/", "/vagrant_data"

  config.vm.provision :shell, :path => "shell/bootstrap.sh"
end