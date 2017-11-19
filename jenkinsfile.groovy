job("Environment-provisioning") {
		 scm {
            git("https://github.com/sumitgupta21/Vikings.git")
        } 
        steps {
          ansiblePlaybook('provision.yml') {
			inventoryPath('inventory')
			ansibleName('Ansible-2.4.1.0')
			}
        }
    }