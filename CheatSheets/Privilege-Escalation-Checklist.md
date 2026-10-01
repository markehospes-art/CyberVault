# ⬆️ Privilege Escalation Checklist

## Linux Privilege Escalation

### Information Gathering

```bash
whoami
id
uname -a
uname -r
lsb_release -a
cat /proc/version
hostname
```

### Sudo Permissions

```bash
sudo -l
sudo -l -U username
```

### SUID Binaries

```bash
find / -perm -4000 2>/dev/null
find / -type f -perm -u=s 2>/dev/null
```

### SGID Binaries

```bash
find / -perm -2000 2>/dev/null
find / -type f -perm -g=s 2>/dev/null
```

### World-Writable Files

```bash
find / -writable 2>/dev/null | head
find / -type f -perm -o+w 2>/dev/null
```

### Cron Jobs

```bash
crontab -l
cat /etc/crontab
ls -la /etc/cron*
grep -r "" /var/spool/cron/
```

### Capabilities

```bash
getcap -r / 2>/dev/null
```

### Environment Variables

```bash
env
echo $PATH
echo $LD_LIBRARY_PATH
```

### Services Running as Root

```bash
ps aux | grep root
ps -ef | grep root
```

### Installed Software

```bash
apt list --installed 2>/dev/null
rpm -qa
yum list installed
```

### Network Connections

```bash
netstat -tulpn
ss -tulpn
ss -tan
```

### File Permissions

```bash
ls -la /etc/passwd
ls -la /etc/shadow
ls -la /root
```

### Kernel Exploits

```bash
uname -r
searchsploit kernel
```

---

## Windows Privilege Escalation

### System Information

```powershell
whoami
whoami /priv
whoami /groups
systeminfo
net user
net localgroup administrators
```

### Hot Fixes (Patches)

```powershell
wmic qfe list full
wmic qfe list full format=list
```

### Installed Software

```powershell
wmic product list brief
wmic product get name
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
```

### Running Services

```powershell
wmic service list brief
tasklist /svc
Get-Service
```

### Weak File Permissions

```powershell
icacls C:\Program Files\*
icacls C:\ProgramData\*
```

### Unquoted Service Paths

```powershell
wmic service get name,displayname,pathname,startmode
sc qc servicename
```

### Registry

```powershell
reg query HKLM\Software\Microsoft\Windows\Run
reg query HKCU\Software\Microsoft\Windows\Run
```

### Scheduled Tasks

```powershell
tasklist /v
Get-ScheduledTask
```

### Network Configuration

```powershell
ipconfig /all
route print
netstat -ano
```

### UAC Status

```powershell
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System
Get-MpComputerStatus
```

### Credential Manager

```powershell
credman.exe
vaultcmd.exe /list
```

### Active Directory Enumeration

```powershell
net user /domain
net group /domain
net group "Domain Admins" /domain
Get-ADUser -Filter *
Get-ADGroup -Filter *
```

---

## Common Exploitation Methods

### Linux

1. Sudo misconfiguration (NOPASSWD)
2. SUID binaries (strings, find, nano, vim, less)
3. Cron job manipulation
4. Library injection
5. Capabilities abuse
6. Kernel exploits
7. Docker/Container escape
8. Weak file permissions

### Windows

1. Unquoted service paths
2. Weak service permissions
3. DLL hijacking
4. Registry manipulation
5. UAC bypass
6. Token impersonation
7. Kerberoasting
8. Potato exploits (Hot/Rotten)
9. Scheduled task abuse
10. Weak file permissions

---

## Automated Tools

### Linux

- LinPEAS
- linuxprivchecker.py
- Unix-privesc-check
- peass-ng

### Windows

- WinPEAS
- PowerUp.ps1
- Privesc
- WindowsEnum

---

## Tips

- Always check sudo permissions first
- Look for recently modified files
- Check kernel version for known exploits
- Document findings with evidence
- Test exploits in safe lab environment
- Use multiple tools for verification

