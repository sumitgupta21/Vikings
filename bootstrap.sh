#!/bin/bash

printf "Running boostrap...\n"

# Check if Ansible is already installed
if ! dpkg -l | grep -q ansible ; then
  # Add ansible repo
  printf "Adding Ansible PPA..."
  add-apt-repository -y ppa:ansible/ansible &> /dev/null && printf "OK\n" || { printf "FAILED!\n"; exit 1; }

  # Update and install prereqs
  printf "Updating apt..."
  apt-get update &> /dev/null && printf "OK\n" || { printf "FAILED!\n"; exit 1; }
  printf "Installing prereqs..."
  apt-get install -y ansible &> /dev/null && printf "OK\n" || { printf "FAILED!\n"; exit 1; }

  # Setup ansible
  printf "Setting up ansible conf..."
  printf "localhost\tansible_connection=local\n" > /etc/ansible/hosts && \
  printf "OK\n" || { printf "FAILED!\n"; exit 1; }
else
  printf "Already installed\n"
fi

#printf "Installing Ansible requirements..."
#rm -rf /etc/ansible/roles/*
#ansible-galaxy install -r /vagrant/roles/requirements.yml &> /dev/null && printf "OK\n" || { printf "FAILED!\n"; exit 1; }

printf "Bootstrap done!\n"
exit 0
