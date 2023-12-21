#! /bin/sh

git clone https://github.com/veeson41/ansible_configs /
&& ansible-vault decrypt ansible_configs/vars/raptor_secret /
&& sudo ansible-pull --vault-pass-file ~/ansible_configs/vars/raptor_secret -U https://github.com/veeson41/ansible_configs /
&& sudo rm -rf ansible_configs
