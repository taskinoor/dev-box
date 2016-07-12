#!/usr/bin/env bash

set -e

sudo apt-get update
sudo apt-get -y install python-dev python-pip sshpass libffi-dev libssl-dev

sudo pip install -U ansible==1.9.3

ssh_dir=/home/vagrant/.ssh
ssh_identity_file=$ssh_dir/id_rsa
ansible_config_dir=/etc/ansible

if [ ! -f $ssh_identity_file ]; then
    ssh-keygen -N "" -f $ssh_identity_file
    ssh-keyscan -H 192.168.31.11 > $ssh_dir/known_hosts
    sshpass -p "vagrant" ssh-copy-id -i $ssh_identity_file vagrant@192.168.31.11
fi

[ -d $ansible_config_dir ] || sudo mkdir $ansible_config_dir

sudo bash -c "cat > $ansible_config_dir/hosts" << EOF
[dev-box]
192.168.31.11
EOF
