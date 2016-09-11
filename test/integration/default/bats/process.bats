#!/usr/bin/env bats

setup() {
    apt-get install -y curl >/dev/null || yum -y install curl >/dev/null
}

## NOK on ubuntu xenial, reviewed in serverspec
#@test "process rabbitmq should be running" {
#    run pgrep rabbitmq
#    [ "$status" -eq 0 ]
#    [[ "$output" != "" ]]
#}

@test "rabbitmq answering cmd - sudo -u rabbitmq rabbitmqctl status" {
    run sudo -u rabbitmq rabbitmqctl status
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "rabbitmq answering cmd - sudo -u rabbitmq rabbitmqctl eval 'node().'" {
    run sudo -u rabbitmq rabbitmqctl eval 'node().'
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

#wget https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/rabbitmq_v3_6_5/bin/rabbitmqadmin
#$ ./rabbitmqadmin -H 192.168.101.51 -P 5671 -u admin -p xxx list vhosts
#$ ./rabbitmqadmin -H 192.168.101.51 -P 5671 -u agent -p xxx -V /mig list queues
##  socket.error: [Errno 104] Connection reset by peer
#$ ./rabbitmqadmin -H 192.168.101.51 -P 5672 --ssl --ssl-key-file=/etc/mig/agent.key --ssl-cert-file=/etc/mig/agent.crt --ssl-ca-cert-file=/etc/mig/ca.crt -u agent -p xxx list vhosts
##  SSLError: [SSL: UNKNOWN_PROTOCOL] unknown protocol (_ssl.c:590)

