[![Build Status](https://travis-ci.org/juju4/ansible-mig-rabbitmq.svg?branch=master)](https://travis-ci.org/juju4/ansible-mig-rabbitmq)

# MIG-Rabbitmq ansible role

Ansible role to setup MIG aka Mozilla InvestiGator - RabbitMQ server
Refer to [mig master role](https://github.com/juju4/ansible-mig) for complete integration.
http://mig.mozilla.org/

Agents packages build is done on rabbitmq server as it use its certificates.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0

### Operating systems

Tested with vagrant and kitchen mostly on ubuntu trusty or xenial and centos7

## Example Playbook

Just include this role in your list.
For example

```
- hosts: migserver
  roles:
    - Mayeu.RabbitMQ
    - mig-rabbitmq

```

Currently, I used a slightly modified version of Mayeu.RabbitMQ as normally, this role is expecting to have rabbitmq certificates available on orchestrator and I'm generating them on mig role if not existing.


## Variables

There is a good number of variables to set the different settings of MIG. Both API and RabbitMQ hosts should be accessible to clients.
Some like password should be stored in ansible vault for production systems at least.

```
mig_user: root
mig_home: /var/lib/rabbitmq

mig_rabbitmq_host: localhost
mig_rabbitmq_port: 5672
mig_rabbitmq_vhost: mig
mig_rabbitmq_adminpass: xxx
mig_rabbitmq_schedpass: xxx
mig_rabbitmq_agentpass: xxx
mig_rabbitmq_workrpass: xxx
## for reference, not really useful for production obviously: http://serverfault.com/questions/235669/how-do-i-make-rabbitmq-listen-only-to-localhost

mig_rabbitmq_certinfo: '/C=US/ST=CA/L=San Francisco/O=MIG Ansible'
mig_rabbitmq_certduration: 1095
mig_rabbitmq_rsakeysize: 2048
mig_rabbitmq_cadir: "{{ mig_home }}/ca"
mig_rabbitmq_cakey: "{{ mig_rabbitmq_cadir }}/ca.key"
mig_rabbitmq_cacertcrt: "{{ mig_rabbitmq_cadir }}/ca.crt"
#mig_rabbitmq_cacert: "{{ mig_rabbitmq_cadir }}/cacert.cert"
mig_rabbitmq_serverdir: "{{ mig_home }}/server"
mig_rabbitmq_serverkey: "{{ mig_rabbitmq_serverdir }}/server-{{ ansible_hostname }}.key"
mig_rabbitmq_servercsr: "{{ mig_rabbitmq_serverdir }}/server-{{ ansible_hostname }}.csr"
mig_rabbitmq_servercrt: "{{ mig_rabbitmq_serverdir }}/server-{{ ansible_hostname }}.crt"
mig_rabbitmq_clientdir: "{{ mig_home }}/client"

#mig_rabbitmq_serverp12: "{{ mig_rabbitmq_serverdir }}/server-{{ ansible_hostname }}-keycert.p12"
#mig_rabbitmq_clientkey: "{{ mig_rabbitmq_clientdir }}/client-{{ ansible_hostname }}.key"
#mig_rabbitmq_clientreq: "{{ mig_rabbitmq_clientdir }}/client-{{ ansible_hostname }}-req.pem"
#mig_rabbitmq_clientcert: "{{ mig_rabbitmq_clientdir }}/client-{{ ansible_hostname }}-cert.pem"
#mig_rabbitmq_clientp12: "{{ mig_rabbitmq_clientdir }}/client-{{ ansible_hostname }}-keycert.p12"
#mig_rabbitmq_keypass: MySecretPassword

```

## Continuous integration


This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/mig-rabbitmq
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/mig-rabbitmq/test/vagrant
$ vagrant up
$ vagrant ssh
```


## Troubleshooting & Known issues

* Idempotence: NOK because of 
 - go get (x2)
 - some rabbitmq module tasks (x4) 
 - force restart of some service else handlers seems to miss it (x3)

* memory
Ensure you have enough memory and swap available. On vagrant 512M+swap or 1024M seems to be fine.


## License

BSD 2-clause



