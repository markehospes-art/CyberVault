# 🗺️ Nmap Cheat Sheet

> Run this on every machine first. Always.

---

## Basic Scans

```bash
nmap IP                          # Top 1000 ports, default scan
nmap -p- IP                      # All 65535 ports (slow but thorough)
nmap -p 80,443,22 IP             # Specific ports only
nmap -p 1-1000 IP                # Port range
```

---

## Speed Settings

```bash
nmap -T0 IP   # Paranoid — slowest, stealthiest
nmap -T1 IP   # Sneaky
nmap -T2 IP   # Polite
nmap -T3 IP   # Normal (default)
nmap -T4 IP   # Aggressive — faster, good for CTFs
nmap -T5 IP   # Insane — fastest, may miss results
```

> Use **-T4** on CTF machines. Use **-T2** or lower when trying to avoid detection.

---

## Scan Types

```bash
nmap -sS IP   # SYN scan (stealth, requires root) — default with sudo
nmap -sT IP   # TCP connect scan (no root needed)
nmap -sU IP   # UDP scan (slow, finds DNS/SNMP/DHCP)
nmap -sV IP   # Version detection — what software is running
nmap -sC IP   # Default scripts — extra info, vuln checks
nmap -O IP    # OS detection
nmap -A IP    # Everything: -sV -sC -O + traceroute
```

---

## The Two Commands You'll Use 90% of the Time

```bash
# Quick — find open ports fast
nmap -T4 -p- IP

# Full — after finding ports, get details
nmap -T4 -sC -sV -p 22,80,443 IP
```

---

## Output & Saving Results

```bash
nmap -oN output.txt IP      # Save as normal text
nmap -oX output.xml IP      # Save as XML (for tools)
nmap -oG output.gnmap IP    # Greppable format
nmap -oA output IP          # Save all 3 formats at once
```

---

## Useful Scripts (-sC runs these automatically)

```bash
nmap --script=vuln IP              # Check for common vulns
nmap --script=http-enum IP         # Enumerate web directories
nmap --script=smb-vuln-ms17-010 IP # Check for EternalBlue (MS17-010)
nmap --script=ftp-anon IP          # Check anonymous FTP login
nmap --script=ssh-brute IP         # SSH brute force
nmap --script=default IP           # Same as -sC
```

---

## Scan Multiple Targets

```bash
nmap 192.168.1.1 192.168.1.2      # Multiple IPs
nmap 192.168.1.0/24               # Whole subnet
nmap 192.168.1.1-20               # IP range
nmap -iL targets.txt              # Read IPs from file
```

---

## Firewall / IDS Evasion

```bash
nmap -f IP                  # Fragment packets
nmap -D RND:10 IP           # Decoy scan (fake source IPs)
nmap --source-port 53 IP    # Spoof source port (DNS port often allowed)
nmap -sS --data-length 25 IP  # Add random data to packets
```

---

## Common Port Reference

| Port | Service | What to check |
|------|---------|---------------|
| 21 | FTP | Anonymous login, version exploits |
| 22 | SSH | Version, weak creds |
| 23 | Telnet | Clear-text, weak creds |
| 25 | SMTP | Open relay, user enum |
| 53 | DNS | Zone transfer |
| 80/443 | HTTP/HTTPS | Web app vulns |
| 139/445 | SMB | EternalBlue, enum shares |
| 3306 | MySQL | Default creds, remote access |
| 3389 | RDP | BlueKeep, brute force |
| 5900 | VNC | No auth, weak password |

---

## Full Recon One-Liner

```bash
nmap -T4 -A -p- -oN scan.txt IP
```
