# Ansible 2.4 on RHEL 9

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Mar-29</div>

## Table of Contents
- [Chapter 1: Installation](#chapter-1-installation-setup)

---

## Prepairation

| Host           | IP Address      | Subnet        | Gateway     | DNS             |
|----------------|-----------------|---------------|-------------|----------------|
| server.ansible | 10.211.55.50/24 | 255.255.255.0 | 10.211.55.1 | 8.8.8.8,8.8.4.4 |
| vm1.ansible    | 10.211.55.51/24 | 255.255.255.0 | 10.211.55.1 | 8.8.8.8,8.8.4.4 |

## Installation

```SHELL
yum install ansible -y
```

Ansible Invetroy
```SHELL
vi /etc/ansible/hosts
	> [ansible_client]
	> 192.168.2.11 ansible_ssh_user=root ansible_ssh_pass=root
```

Ansible Playbook
```SHELL
vi sample.yml
---
- name: sample book
  hosts: ansible_client
  remote_user: root
  become: true
  tasks:
  	- name: install httpd
  	  yum:
  	  	name: httpd
  	  	state: latest
  	- name: run httpd
  	  service:
  	  	name: httpd
  	  	state: started
  	- name: create content
  	  copy:
  	  	content: "Congrats on installing ansible"
  	  	dest: /var/www/html/index.html
```

Ansible Run
```SHELL
ansible-playbook sample.yml --syntax-check

ansible-playbook sample.yml
	> Check OK, Changed, Unreachable, Failed
```
	