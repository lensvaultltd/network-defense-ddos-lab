#!/bin/bash
# DDoS Mitigation & Network Hardening Script using iptables
# Author: Fatima Umar

echo "[+] Applying Network Defense Rules..."

# 1. Drop invalid packets
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
echo "[-] Dropping invalid packets"

# 2. Drop new packets that do not have the SYN flag set
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP
echo "[-] Dropping TCP connections not starting with SYN"

# 3. Drop fragmented packets
iptables -t mangle -A PREROUTING -f -j DROP

# 4. Limit connections per source IP to prevent resource exhaustion
iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 20 -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp --syn --dport 443 -m connlimit --connlimit-above 20 -j REJECT --reject-with tcp-reset
echo "[+] Rate limiting HTTP/HTTPS connections"

# 5. Prevent SSH Brute Force Attacks (Rate Limiting)
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
echo "[+] Protecting SSH from brute force attacks"

# 6. Mitigate UDP floods (e.g., DNS amplification)
iptables -A INPUT -p udp -m limit --limit 10/s -j ACCEPT
iptables -A INPUT -p udp -j DROP
echo "[+] Mitigating UDP floods"

echo "[+] Network Defense Rules Applied Successfully."
