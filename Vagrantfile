Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  config.vm.define "dev-box", primary: true do |dev_box|
	dev_box.vm.hostname = "dev-box"
	dev_box.vm.network "private_network", ip: "192.168.31.11"

    dev_box.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 4
    end

    _synced_folders = [
        ["../eBooks/Flask Web Development - Miguel Grinberg/flasky", "/mnt/flasky"],
        ["../Works/Self/misc-codes/utils", "/mnt/utils"],
        ["../Works/Self/algorithms", "/mnt/algorithms"]
    ]

    _synced_folders.each do |host_path, guest_path|
        if File.directory?(host_path)
            dev_box.vm.synced_folder host_path, guest_path
        end
    end

  end

  config.vm.define "ansible-control-box", autostart: false do |control_box|
    control_box.vm.hostname = "ansible-control-box"
    control_box.vm.network "private_network", ip: "192.168.31.13"
    control_box.vm.provision "shell", path: "provision_control_box.sh", privileged: false

    control_box.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 2
    end
  end

end
