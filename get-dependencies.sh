#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/Mayeu.RabbitMQ ] && git clone https://github.com/juju4/ansible-playbook-rabbitmq.git $rolesdir/Mayeu.RabbitMQ
[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.mig-rabbitmq ] && ln -s ansible-mig-rabbitmq $rolesdir/juju4.mig-rabbitmq
[ ! -e $rolesdir/juju4.mig-rabbitmq ] && cp -R $rolesdir/ansible-mig-rabbitmq $rolesdir/juju4.mig-rabbitmq

## don't stop build on this script return code
true

