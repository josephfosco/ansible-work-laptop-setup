#!/bin/bash

# To use this to run plays for a single tag or tags use
# --tags "<comma seperated list of tags to run>"
cd ~/sys/ansible/
export ANSIBLE_INVENTORY=~/sys/ansible/setup/ansible_hosts
source ~/sys/ansible/ansible/hacking/env-setup
source ~/sys/ansible/env/bin/activate
cd ansible
ansible-playbook ../setup/setup.yml -K $@
