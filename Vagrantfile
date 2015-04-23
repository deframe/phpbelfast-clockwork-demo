Vagrant.configure("2") do |config|

    config.vm.hostname = "vagrant.local"
    config.vm.network "private_network", ip: "172.16.1.5"

    config.vm.box = "ubuntu/trusty64"

    config.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    end

    config.vm.synced_folder "./", "/vagrant", :mount_options => ["dmode=777", "fmode=777"]
    config.vm.provision "shell", path: "support/vagrant/provision.sh"

    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
    end

    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end

end