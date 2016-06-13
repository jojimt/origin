#!/bin/bash
top_dir=$PWD
invFile=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
cleanupFile=openshift-ansible/roles/contiv/tasks/cleanup.yml
ansible-playbook --inventory-file=$top_dir/$invFile $top_dir/../$cleanupFile -e "ansible_ssh_user=vagrant"
