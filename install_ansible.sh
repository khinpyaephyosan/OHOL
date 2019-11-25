#!/bin/bash

sed -i "2i192.168.33.13 web" /etc/hosts
sed -i "2i192.168.33.14 db" /etc/hosts

if [ ! -f /home/ansible/.ssh ]; then   
        useradd ansible
        echo "ansible" | passwd --stdin ansible
        echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible

        mkdir /home/ansible/.ssh -m 700        
        wget --no-check-certificate https://raw.githubusercontent.com/khinpyaephyosan/OHOL/master/openssh/config -O /home/ansible/.ssh/config
        ssh-keygen -f /home/ansible/.ssh/id_rsa -t rsa -b 1024 -P "" -C "ansible@controller"
        chown -R ansible:ansible /home/ansible/.ssh
        chmod -R 600 /home/ansible/.ssh/*
        runuser -c -u ansible "sshpass -p ansible ssh-copy-id -f web"
        runuser -c -u ansible "sshpass -p ansible ssh-copy-id -f db"
fi

if ! command -v ansible >/dev/null; then
        yum install -y python3 python3-pip vim sshpass 
        alternatives --set python /usr/bin/python3
        pip3 install ansible==2.9.0
fi

wget --no-check-certificate https://raw.githubusercontent.com/khinpyaephyosan/OHOL/master/ansible/ansible.cfg -O /home/ansible/ansible.cfg
wget --no-check-certificate https://raw.githubusercontent.com/khinpyaephyosan/OHOL/master/ansible/inventory -O /home/ansible/inventory
