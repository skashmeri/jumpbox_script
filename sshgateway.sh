#!/bin/bash
TEST=/var/log/wtmp
TEMPLATE=/etc/hosts.template
HOSTS=/etc/hosts
HOSTFILE=/tmp/hosts
export AWS_CREDENTIAL_FILE=/root/.aws_cred
#export SSH_CLIENT
#export SSH_TTY
#export SSH_AUTH_SOCK
#export SSH_CONNECTION

if [ `whoami` != 'root' ]
then
    sudo $0
    exit
fi
# Only update if there has been a login more recently than the last update
#if [ $TEST -nt $HOSTS ]
#then
    TEMP=(`mktemp`)
#    cat $TEMPLATE >> $TEMP
    list_instances --headers PrivateIP,T:Name | grep internal | awk '{print $1,$2"."$4}' >> $TEMP
#    list_instances --headers PrivateIP,T:Name | grep -v "^\(Private\|None\|IP\|T:Name\|-\)" | awk '{print $1,$2"."$4}'|sort -k 2 >> $TEMP
    chmod 644 $TEMP
    mv $TEMP /tmp/hosts
#fi


#arr1=(`aws ec2 describe-instances | grep Name | awk '{ print $3 }'`)
#arr1=(`aws ec2 describe-instances | grep Name | grep internal | awk '{if (!$3) {print "Un-named-Instance"} else {print $3}}'`)
#arr2=(`aws ec2 describe-instances --query 'Reservations[].Instances[].[PrivateIpAddress]' --output text`)

