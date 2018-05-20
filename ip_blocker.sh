#!/bin/bash/

function block_port {
	printf "Blocking port "
	printf $1
	printf " from the outside\n"
	#iptables -I INPUT -p udp -s 10.8.0.0/24 --dport $1 -j ACCEPT
	#iptables -I INPUT -p tcp -s 10.8.0.0/24 --dport $1 -j ACCEPT

	#iptables -I INPUT -p udp -s 192.168.1.0/24 --dport $1 -j ACCEPT
	#iptables -I INPUT -p tcp -s 192.168.1.0/24 --dport $1 -j ACCEPT

	#allow localhost
        iptables -I INPUT -p tcp -s 127.0.0.1 -j ACCEPT
        iptables -I INPUT -p udp -s 127.0.0.1 -j ACCEPT
	#allow LAN
	iptables -I INPUT -p tcp -m iprange --src-range 192.168.1.1-192.168.1.254 -j ACCEPT
	iptables -I INPUT -p udp -m iprange --src-range 192.168.1.1-192.168.1.254 -j ACCEPT

	#allow VPN
	iptables -I INPUT -p udp -m iprange --src-range 10.8.0.1-10.8.0.254 -j ACCEPT
	iptables -I INPUT -p tcp -m iprange --src-range 10.8.0.1-10.8.0.254 -j ACCEPT

	iptables -I INPUT -p udp -s 0.0.0.0/0 --dport $1 -j DROP
	iptables -I INPUT -p tcp -s 0.0.0.0/0 --dport $1 -j DROP
}

#clear chains
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

#call for all ports
block_port 80
block_port 53
block_port 139
block_port 445
block_port 5050
block_port 8080
block_port 8081
block_port 8181
block_port 9091
block_port 8443
block_port 8333
