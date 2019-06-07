cd ~/sys/ansible/
export ANSIBLE_INVENTORY=~/sys/ansible/setup/ansible_hosts
source ~/sys/ansible/ansible/hacking/env-setup
source ~/sys/ansible/env/bin/activate
cd ansible
ansible-playbook ../setup/setup.yml -K
