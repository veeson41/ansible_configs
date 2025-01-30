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
	# os=$(cat /etc/os-release | grep -w NAME | sed 's/NAME="//g' | sed 's/"//g' | cut -d " " -f1)
	os=$(cat /etc/os-release | grep -w NAME | sed 's/NAME=//g')
	# [ "$os" = "Ubuntu" ]  && debian
	[ "$os" = "Arch" ]  && arch
	[ "$os" = "EndeavourOS" ]  && arch
	[ "$os" = "Arch Linux" ]  && arch
	[ "$os" = "arch" ]  && arch
	[ "$os" = "Debian" ]  && debian
	[ "$os" = "Ubuntu" ]  && debian
}

playbook(){
wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && 
ansible-vault decrypt raptor_secret && 
ansible-pull $1.yml --vault-password-file raptor_secret -U  https://github.com/veeson41/ansible_configs
}

playbook_tags(){
wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && 
ansible-vault decrypt raptor_secret && 
ansible-pull $1.yml --tags $2 --vault-password-file raptor_secret -U  https://github.com/veeson41/ansible_configs
}

os_package_update

if [ $# -lt 2 ]; then
  playbook $1
else
  playbook_tags $1 $2
fi

sudo rm -rf *raptor_secret*
