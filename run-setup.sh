cd ~/py/ansible/
source ~/py/ansible/ansible/hacking/env-setup
source ~/py/ansible/env/bin/activate
cd ansible
ansible-playbook ../setup/setup.yml -K
