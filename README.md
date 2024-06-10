# Full Automated Ansible Lab, with Vagrant+Virtualbox

This repository creates 5 nodes for [Ansible](https://www.ansible.com/) lab using Vagrant and Virtualbox.
You can define the number of nodes in "vars.rf" and also you can change IP range.

## Installation
Clone Project Repository


```bash
$ git clone git@github.com:raeis-i/Full-Automated-Ansible-Lab-with-Vagrant-Virtualbox.git

$ cd Full-Automated-Ansible-Lab-with-Vagrant-Virtualbox

$ vagrant up
Bringing machine 'node1' up with 'virtualbox' provider...
Bringing machine 'node2' up with 'virtualbox' provider...
Bringing machine 'node3' up with 'virtualbox' provider...
Bringing machine 'node4' up with 'virtualbox' provider...
Bringing machine 'node5' up with 'virtualbox' provider...

....



```
It takes some minutes to be up and ready, after that you can check status:

```bash
$ vagrant status
node1                     running (virtualbox)
node2                     running (virtualbox)
node3                     running (virtualbox)
node4                     running (virtualbox)
node5                     running (virtualbox)

```

SSH from host terminal to node1
```bash
$ vagrant ssh node1
Welcome to Ubuntu 23.10 (GNU/Linux 6.5.0-28-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun May 12 09:12:15 UTC 2024

  System load:  0.08              Processes:               94
  Usage of /:   3.7% of 38.70GB   Users logged in:         0
  Memory usage: 20%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%


0 updates can be applied immediately.


vagrant@node1:~$

```

Install Ansible and generate ssh key and copy in all node. 
```bash
vagrant@node1:~$ bash ansible.sh
```
Run uptime command in all nodes.
```bash
vagrant@node1:~$ ansible all -i ansible/inventory -m "shell" -a "uptime"
node2 | CHANGED | rc=0 >>
 09:55:41 up 7 min,  1 user,  load average: 0.06, 0.10, 0.08
node5 | CHANGED | rc=0 >>
 09:55:41 up 5 min,  1 user,  load average: 0.03, 0.26, 0.16
node1 | CHANGED | rc=0 >>
 09:55:41 up 8 min,  2 users,  load average: 0.49, 0.30, 0.15
node3 | CHANGED | rc=0 >>
 09:55:41 up 6 min,  1 user,  load average: 0.00, 0.14, 0.11
node4 | CHANGED | rc=0 >>
 09:55:41 up 6 min,  1 user,  load average: 0.07, 0.18, 0.12
vagrant@node1:~$
```

Install nginx on node5 and test.
```bash
vagrant@node1:~$ ansible node5 -i ansible/inventory -m "shell" -a "sudo apt update && sudo apt install -y nginx"

vagrant@node1:~$ curl -I node5
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Date: Sun, 12 May 2024 09:58:29 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Sun, 12 May 2024 09:57:49 GMT
Connection: keep-alive
ETag: "6640929d-267"
Accept-Ranges: bytes

vagrant@node1:~$
```

Destroy the lab, run this command in your host terminal and confirm.
```bash
$ vagrant destroy
```

## Introduction to each file
1-Vagrantfile : 
Configurations related to the VM are stored in this file, you can change CPU and Ram.

2-bootstrap.sh : Change SSH config in all nodes and Add all nodes to hosts file in all servers.

3-vars.rb : You can use image name or download it, and define the number of total nodes and Network range.

4- ansible.sh : This file will copy only to node1 as an Ansible node to manage other nodes. This file will Install Ansible, Generate SSH key ,copy Key to all nodes, and create an inventory file.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update the tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
