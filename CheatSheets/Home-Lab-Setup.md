# 🏠 Home Lab Setup Guide

> Practice hacking legally on your own machines. No risk, full control.

---

## What You Need

| Thing | Free? | Link |
|-------|-------|------|
| VirtualBox | ✅ Free | [virtualbox.org](https://www.virtualbox.org/) |
| VMware Workstation Player | ✅ Free | [vmware.com](https://www.vmware.com/products/workstation-player.html) |
| Kali Linux (attacker) | ✅ Free | [kali.org/get-kali](https://www.kali.org/get-kali/) |
| Vulnerable VMs (targets) | ✅ Free | [vulnhub.com](https://www.vulnhub.com/) |

**Minimum specs:** 8GB RAM, 50GB free disk, any modern CPU with virtualization enabled

---

## Step 1 — Install VirtualBox

1. Download from [virtualbox.org](https://www.virtualbox.org/wiki/Downloads)
2. Install normally
3. Also install the **Extension Pack** (same page) — enables USB, better display

---

## Step 2 — Set Up Kali Linux (Your Attacker Machine)

```
Option A — Pre-built VM (easiest):
1. Go to kali.org/get-kali → Virtual Machines
2. Download VirtualBox 64-bit image (.ova file)
3. VirtualBox → File → Import Appliance → select .ova
4. Done — Kali is ready to boot

Option B — Install from ISO:
1. Download Kali ISO from kali.org
2. VirtualBox → New → Linux → Debian 64-bit
3. 2 CPU cores, 4GB RAM, 40GB disk
4. Boot from ISO → install normally
```

**Default Kali credentials:** `kali` / `kali`

---

## Step 3 — Get a Vulnerable Target VM

### Best Beginner VMs from VulnHub

| VM | Difficulty | What you'll practice |
|----|-----------|---------------------|
| **Metasploitable 2** | Very Easy | Everything — designed to be broken |
| **DVWA** | Easy | Web app vulns (SQLi, XSS, etc.) |
| **Mr. Robot** | Easy-Medium | Real CTF-style machine |
| **Basic Pentesting 1** | Easy | Full pentest workflow |
| **Kioptrix Level 1** | Easy | Classic beginner machine |

```
Download .ova or .vmdk → Import into VirtualBox → Boot it up
```

---

## Step 4 — Network Configuration

> Both VMs must be on the same network to attack each other.

```
VirtualBox → Settings → Network for BOTH machines:
→ Adapter 1 → Attached to: Host-Only Adapter
→ Select vboxnet0 (create it first if not there)
→ File → Host Network Manager → Create)
```

**Why Host-Only?**
- Your VMs can talk to each other
- They CANNOT reach the internet
- The internet CANNOT reach them
- Your main machine can connect to them

---

## Step 5 — Find Your Target's IP

```bash
# On Kali
arp-scan --localnet
netdiscover -r 192.168.56.0/24
nmap -sn 192.168.56.0/24
```

---

## Metasploitable 2 — Quick Start

The easiest target. Already has everything vulnerable.

```bash
# After importing and booting Metasploitable 2:
# Login: msfadmin / msfadmin (on the VM screen)
# Find its IP with arp-scan from Kali

# Then from Kali:
nmap -sV 192.168.56.X        # See all the services
msfconsole                    # Start Metasploit
use exploit/unix/ftp/vsftpd_234_backdoor   # Classic first exploit
set RHOSTS 192.168.56.X
run
```

---

## DVWA (Web App Practice)

```bash
# DVWA runs in browser — find the IP then:
http://192.168.56.X/dvwa/

# Default login: admin / password
# Set Security Level to Low first (DVWA Security tab)
# Practice: SQLi, XSS, CSRF, File Upload, Command Injection
```

---

## Snapshot — Save Your Progress

```
VirtualBox → Machine → Take Snapshot
Name it "Clean state" or "Before exploit"
→ If you break something, restore to snapshot
```

---

## Recommended Lab Setup

```
┌─────────────────────────────────┐
│         Host Machine            │
│   (your actual Windows/Mac)     │
│                                 │
│  ┌──────────┐  ┌─────────────┐  │
│  │  Kali    │  │ Metasploit- │  │
│  │ (Attack) │  │ able / THM  │  │
│  │          │◄►│  (Target)   │  │
│  └──────────┘  └─────────────┘  │
│        Host-Only Network        │
└─────────────────────────────────┘
```

---

## Online Alternatives (No Download Needed)

| Platform | What it is |
|----------|-----------|
| [TryHackMe](https://tryhackme.com) | Browser-based — machines spin up in seconds |
| [HackTheBox](https://hackthebox.com) | More realistic, need VPN |
| [PwnTillDawn](https://online.pwntilldawn.com) | Free labs |

> For absolute beginners: **TryHackMe first**, then build a local lab once you know what you're doing.
