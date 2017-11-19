Vagrant.configure(2) do |config|

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_check_update = false
  config.vm.hostname = "vikings-vagrant"
  config.vm.define "vikings-vagrant"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 4444, host: 4444
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  #config.vm.network :forwarded_port, guest: 22, host: 2322, id: "ssh"
   if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=700,fmode=600"]
    config.vm.synced_folder "../", "/home/vagrant/repos", mount_options: ["dmode=777,fmode=666"]
  else
    config.vm.synced_folder "./", "/vagrant"
    config.vm.synced_folder "../", "/home/vagrant/repos", mount_options: ["dmode=777,fmode=666"]
  end

  # Configuration of
  config.vm.provider :virtualbox do |v|
    v.name = "vikings-vagrant"
    v.customize ["modifyvm", :id, "--cableconnected1", "on"]
    v.customize ["modifyvm", :id, "--memory", "10096"]
    v.customize ["modifyvm", :id, "--cpus", "2"]

  end

  # SSH settings
  config.ssh.forward_agent = "True"

  # Fix no tty error
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Run bootstrap and then ansible
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "ansible_local" do |ansible|
   ansible.playbook = "jenkins.yml"
   ansible.limit = "localhost"
   ansible.inventory_path = "/etc/ansible/hosts"
  end
  config.vm.provision "shell", inline: "sudo usermod -a -G sudo jenkins"
  config.vm.provision "shell", path: "set_jenkins_user.sh", privileged: true
  config.vm.provision "shell", inline: "sudo systemctl restart jenkins"

end
