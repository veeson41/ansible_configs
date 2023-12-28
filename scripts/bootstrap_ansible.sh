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

os_specific_package(){
	os=$(cat /etc/os-release | grep -w NAME | sed 's/NAME="//g' | sed 's/"//g' | cut -d " " -f1)
	[ "$os" = "Ubuntu" ]  && debian
	[ "$os" = "Arch" ]  && arch
	[ "$os" = "Debian" ]  && debian
}

os_specific_package
wget https://raw.githubusercontent.com/veeson41/ansible_configs/master/vars/raptor_secret && 
ansible-vault decrypt raptor_secret && 
sudo ansible-pull --vault-pass-file raptor_secret -U https://github.com/veeson41/ansible_configs 
sudo rm -rf raptor_secret.*
