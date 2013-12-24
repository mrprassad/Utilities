#! /bin/sh

source $PWD/$1

create_tab () {
## Arguments: $1: name
    WID=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| awk '{print $5}')
    xdotool windowfocus $WID
    xdotool key ctrl+shift+t
    xdotool key alt+t
    xdotool key Return
    xdotool type "$1"
    xdotool key Return
    sleep 1
}

open_ssh_session () {
## Arguments: $1: host_ip, $2: password
    xdotool type --delay 1 --clearmodifiers "sshpass -p $2 ssh -o StrictHostKeyChecking=no root@$1"
    xdotool key Return
    sleep 1
}


create_tab "Openstack"
open_ssh_session $OPENSTACK_NODE $SSHPASS
create_tab "Network"
open_ssh_session $VM_HOST_CTRL $SSHPASS
open_ssh_session $NETWORK_NODE $SSHPASS
create_tab "Compute-1"
open_ssh_session $COMPUTE_NODE_1 $SSHPASS
create_tab "Compute-2"
open_ssh_session $COMPUTE_NODE_2 $SSHPASS
create_tab "Common"
open_ssh_session $COMMON_NODE $SSHPASS

