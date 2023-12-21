#! /bin/sh

wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && /
ansible-vault decrypt raptor_secret && /
sudo ansible-pull --vault-pass-file raptor_secret -U https://github.com/veeson41/ansible_configs && /
sudo rm -rf raptor_secret
