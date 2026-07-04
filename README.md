# Network Defense & DDoS Mitigation Lab

![Security](https://img.shields.io/badge/Security-Blue-blue)
![Networking](https://img.shields.io/badge/Networking-Linux-yellow)
![Firewall](https://img.shields.io/badge/Firewall-iptables-red)

A controlled laboratory environment showcasing the execution of simulated Distributed Denial of Service (DDoS) attacks and the implementation of robust mitigation strategies.

## Overview
This repository contains scripts, firewall configurations, and documentation used to defend network infrastructure against volumetric and protocol-based attacks. 

### Core Concepts Demonstrated:
- **Rate Limiting:** Throttling incoming connections to prevent service exhaustion.
- **Firewall Tuning:** Implementing aggressive drop rules for malformed or suspicious packets using `iptables`.
- **Packet Inspection:** Utilizing tools like Snort to identify malicious traffic signatures in real-time.
- **SYN Flood Protection:** Enabling SYN cookies to mitigate TCP SYN flood attacks.

## Contents
- `iptables_mitigation.sh`: A comprehensive bash script to configure iptables rules designed to drop invalid packets, limit connection rates, and mitigate SYN floods.
- `sysctl_hardening.conf`: Kernel parameters to harden the Linux network stack against various network attacks.

## Usage
**Warning:** Only run these scripts in an isolated, controlled lab environment. Applying these rules to a production server without proper testing could result in being locked out.

```bash
# Make the script executable
chmod +x iptables_mitigation.sh

# Run as root to apply mitigation rules
sudo ./iptables_mitigation.sh
```

## Disclaimer
This project is for educational and portfolio demonstration purposes only. Unauthorized DDoS attacks against infrastructure you do not own are illegal.
