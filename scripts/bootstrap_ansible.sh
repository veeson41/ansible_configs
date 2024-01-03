#! /bin/sh

arch(){
export LC_ALL=C.UTF-8
sudo pacman -Syu ansible openssh --noconfirm
sudo systemctl enable sshd
sudo systemctl start sshd
}

debian(){
sudo apt update && sudo apt upgrade -y && sudo apt install ansible -y
}

os_package_update(){
	os=$(cat /etc/os-release | grep -w NAME | sed 's/NAME="//g' | sed 's/"//g' | cut -d " " -f1)
	[ "$os" = "Ubuntu" ]  && debian
	[ "$os" = "Arch" ]  && arch
	[ "$os" = "Debian" ]  && debian
}

playbook(){
wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && 
ansible-vault decrypt raptor_secret && 
ansible-pull $1.yml --vault-pass-file --user veeson raptor_secret --ask-become-pass -U  https://github.com/veeson41/ansible_configs
}

#machine_type(){
#  case $1 in
#    server)
#      echo "Bootstrapping Server machine"
#      server_config ;;
#    workstation)
#      echo "Bootstrapping workstation";;
#    *) 
#      echo "Not a configuration type";;
#   esac
#}

os_package_update
playbook $1
sudo rm -rf *raptor_secret*
#wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && 
#ansible-vault decrypt raptor_secret && 
#ansible-pull  --vault-pass-file raptor_secret -U https://github.com/veeson41/ansible_configs 
#sudo rm -rf *raptor_secret*
