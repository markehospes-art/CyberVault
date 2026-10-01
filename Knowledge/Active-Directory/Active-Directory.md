# 🏢 Active Directory Fundamentals

## What is Active Directory?

Active Directory (AD) is Microsoft's centralized directory service for managing users, computers, and resources in Windows networks.

## Components

- **Domain Controller (DC)** - Manages AD database
- **Domain** - Container for users, computers, groups
- **Organizational Unit (OU)** - Logical grouping
- **Group Policy** - Centralized management
- **Trust Relationships** - Inter-domain authentication

## AD Objects

```
user
computer
group
groupPolicy
orgUnit
printer
share
contact
```

## Enumeration Tools

### PowerShell
```powershell
Get-ADUser -Filter *
Get-ADComputer -Filter *
Get-ADGroup -Filter *
Get-ADGroupMember -Identity "Domain Admins"
```

### BloodHound
- Visualize AD relationships
- Find privilege escalation paths
- Map attack chains

### PowerView
```powershell
Import-Module .\PowerView.ps1
Get-NetUser
Get-NetComputer
Get-NetGroup
```

## Common Attacks

1. **Kerberoasting** - Extract TGS tickets from Kerberos
2. **AS-REP Roasting** - Extract TGT for users without preauthentication
3. **Pass-the-Hash** - Use NTLM hash for lateral movement
4. **DCSync** - Extract password hashes from DC
5. **Constrained Delegation** - Abuse service delegation
6. **Golden Ticket** - Create forged Kerberos ticket

