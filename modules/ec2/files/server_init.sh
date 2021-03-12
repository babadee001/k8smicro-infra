#!/bin/sh

sudo apt update -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
mkdir /home/ubuntu/ansible /home/ubuntu/ansible/roles /home/ubuntu/ansible/roles/ec2-role /home/ubuntu/ansible/roles/ec2-role/tasks

cat <<EOF >/home/ubuntu/ansible/playbook.yml
---
- name: Setup required libraries
  hosts: localhost
  gather_facts: no
  become: yes
  become_method: sudo


  tasks:
  - include_role:
      name: ec2-role
EOF

cat <<EOF >/home/ubuntu/ansible/roles/ec2-role/tasks/main.yml

- name: Update APT package manager repositories cache
  apt:
    update_cache: yes

- name: Add Docker apt Key
  apt_key:
    url: https://download.docker.com/linux/ubuntu/gpg
    state: present

- name: Add Docker Repository
  apt_repository:
    repo: deb https://download.docker.com/linux/ubuntu bionic stable
    state: present

- name: Update apt and install docker-ce  docker-compose
  apt:
    update_cache: yes
    name: "{{ item }}"
    state: latest
  loop:
    - docker-ce
    - docker-compose


- name: Add user to docker group
  user:
    name: ubuntu
    group: docker
    append: yes


- name: Update APT package manager repositories cache
  apt:
    update_cache: yes

- name: install openjdk for jenkins
  apt:
    name: openjdk-8-jdk
    state: present

- name: ensure jenkins apt repository key
  apt_key: 
    url: https://pkg.jenkins.io/debian-stable/jenkins.io.key
    state: present

- name: connfigure repo
  apt_repository:
    repo: 'deb https://pkg.jenkins.io/debian-stable binary/'
    state: present


- name: install jenkins
  apt:
    name: jenkins
    update_cache: yes

- name: start jenkins
  service: 
    name: jenkins
    state: started


- name: Add jenkins user to docker group
  user:
    name: jenkins
    group: docker
    append: yes
EOF

ansible-playbook /home/ubuntu/ansible/playbook.yml

cat /var/lib/jenkins/secrets/initialAdminPassword > jenkinspassword.txt

