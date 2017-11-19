job("Environment-provisioning") {
        steps {
          ansiblePlaybook('/home/vagrant/repos/vagrantmachine/provision.yml') {
			inventoryPath('/home/vagrant/repos/vagrantmachine/inventory')
			ansibleName('Ansible-2.4.1.0')
			}
        }
    }