#!/bin/bash

yum install -y vim sshpass
useradd ansible
echo "ansible" | passwd --stdin ansible
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
systemctl restart sshd