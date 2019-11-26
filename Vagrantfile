Vagrant.configure("2") do |config|
  config.vm.box = "LillianPhyoe/lillianCent7"
  config.vm.box_version = "1"

  config.vm.define "web" do |web|
    web.vm.network :private_network, ip: "192.168.33.13"
    web.vm.hostname = "web"
    web.vm.synced_folder ".", "/vagrant", disabled: true
    web.vm.provision :shell, privileged: true, path: "AnsibleManagedNodes.sh"
  end

  config.vm.define "db" do |db|
    db.vm.network :private_network, ip: "192.168.33.14"
    db.vm.hostname = "db"
    db.vm.synced_folder ".", "/vagrant", disabled: true
    db.vm.provision :shell, privileged: true, path: "AnsibleManagedNodes.sh"
  end

  #
  # this is ansible controller VM
  #
  config.vm.define "controller" do |controller|
    controller.vm.network :private_network, ip: "192.168.33.15"
    controller.vm.hostname = "controller"
    controller.vm.synced_folder ".", "/vagrant", disabled: true
    controller.vm.provision :shell, privileged: true, path: "install_ansible.sh"
    #controller.vm.provision "ansible" do |ansible|
      #ansible.playbook = "playbook.yml" 
    #end
  end

end
