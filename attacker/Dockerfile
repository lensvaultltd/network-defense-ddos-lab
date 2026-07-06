FROM alpine:latest
RUN apk add --no-cache bash hping3 curl apache2-utils python3
WORKDIR /attacker
COPY simulate_attacks.sh .
RUN chmod +x simulate_attacks.sh
CMD ["bash"]
