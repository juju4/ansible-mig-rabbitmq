#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/Mayeu.RabbitMQ ] && git clone https://github.com/juju4/ansible-playbook-rabbitmq.git $rolesdir/Mayeu.RabbitMQ
[ ! -d $rolesdir/redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/redhat-epel

