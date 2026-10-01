# 🔍 Nmap Cheat Sheet

## What is Nmap?

Nmap is a network mapping and host discovery tool used for port scanning, service enumeration, and OS detection.

---

## Basic Syntax

```bash
nmap [options] target
```

---

## Common Scan Types

### Host Discovery

```bash
# Ping sweep to find live hosts
nmap -sn 192.168.1.0/24

# No ping (treat all as online)
nmap -Pn 192.168.1.0/24
```

### Port Scanning

```bash
# TCP SYN scan (stealth)
nmap -sS target.com

# TCP connect scan
nmap -sT target.com

# UDP scan
nmap -sU target.com

# ACK scan (firewall detection)
nmap -sA target.com

# Null/FIN/Xmas scans
nmap -sN target.com
nmap -sF target.com
nmap -sX target.com
```

### Port Selection

```bash
# Specific ports
nmap -p 80,443,22 target.com

# Port range
nmap -p 1-1000 target.com

# All ports
nmap -p- target.com

# Top 100 ports
nmap --top-ports 100 target.com
```

### Service Detection

```bash
# Service version detection
nmap -sV target.com

# OS detection
nmap -O target.com

# Aggressive scan (all)
nmap -A target.com
```

---

## Output Options

```bash
# Normal output
nmap -oN output.txt target.com

# XML output
nmap -oX output.xml target.com

# Grepable output
nmap -oG output.gnmap target.com

# All formats
nmap -oA output target.com
```

---

## NSE Scripts

```bash
# Default scripts
nmap --script default target.com

# Vulnerability scripts
nmap --script vuln target.com

# SMB enumeration
nmap --script smb-enum-shares target.com

# SSH version detection
nmap --script ssh-hostkey target.com

# HTTP title grabbing
nmap --script http-title target.com
```

---

## Timing and Performance

```bash
# Timing templates (-T0 to -T5, higher = faster)
nmap -T4 target.com

# Parallel scans
nmap --max-parallelism 10 target.com

# Timeout
nmap --host-timeout 1h target.com
```

---

## Evasion Techniques

```bash
# Fragment packets
nmap -f target.com

# Use decoys
nmap -D RND:10 target.com

# Spoofed source port
nmap -g 53 target.com

# Idle scan
nmap -sI zombie_ip target.com
```

---

## Common Workflows

### Quick Scan
```bash
nmap -sn 10.10.10.0/24
```

### Full Service Enumeration
```bash
nmap -sS -sV -A -p- 10.10.10.10
```

### Save Results for Analysis
```bash
nmap -sS -sV -A -p- -oA scan_results 10.10.10.10
```

### Aggressive Scan
```bash
nmap -A -Pn --top-ports 1000 target.com
```

---

## Tips

- Use `-sS` for stealth
- Use `-sV` to detect service versions
- Use `-O` for OS fingerprinting (requires root)
- Use `--script vuln` to check for known vulns
- Save output in XML for import into other tools

