#!/bin/bash

# Created by Anushan Rajakulasinga, (anushan@hubub.com)
# SSH Proxy Menu
# 2014/10/17

menu_options=($(awk '{print $2}' /tmp/hosts))
server_options=($(awk '{print $1}' /tmp/hosts))
hostname=`hostname`


MENULIST=()
for ((i=0; i<${#menu_options[@]}; i++))
do
    MENULIST+=("$i" "${menu_options[$i]} - ${server_options[$i]}")
done

choice=$(whiptail --title "$hostname - BASTION GATEWAY SSH PROXY" --ok-button "Login" --menu "Choose a server" 0 0 5 "${MENULIST[@]}"  2>&1 >/dev/tty)

exitstatus=$?
if [ $exitstatus = 0 ]; then
        echo "Connecting to ${menu_options[$choice]} - ${server_options[$choice]} ..."
        ssh -A ${server_options[$choice]}
else
    echo "Exiting..."
    exit
fi

