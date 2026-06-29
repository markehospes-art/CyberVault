# 🔍 Advanced Reconnaissance & OSINT

> Professional-grade information gathering techniques.
> ⚠️ **Authorized testing only!**

---

## Passive OSINT — No Traffic to Target

### 1. Shodan

Search for internet-connected devices and services:

```
https://www.shodan.io/
```

Useful search filters:
```
country:US
city:"New York"
port:3306
Apache
```

### 2. Censys

Certificate transparency search — find subdomains from SSL certs:

```
https://censys.io/
```

### 3. GreyNoise

Identify malicious or scanning IPs:

```
https://www.greynoise.io/
```

### 4. Google Dorking

Advanced search operators to find exposed data:

```
site:example.com filetype:pdf
site:example.com "password"
inurl:admin
intitle:"index of"
cache:example.com
```

### 5. Wayback Machine

Browse old versions of websites and discover archived endpoints:

```
https://web.archive.org/
```

---

## Advanced Subdomain Enumeration

### 1. Certificate Transparency Logs

```bash
ctfr.py -d example.com     # CTFR tool
certsh -d example.com      # Alternative
```

### 2. Subfinder

```bash
subfinder -d example.com -all -recursive
```

### 3. Amass (Most Comprehensive)

```bash
amass enum -d example.com
amass enum -d example.com -src all
```

### 4. Combine Multiple Tools

```bash
cat domains.txt | while read d; do
  subfinder -d $d -silent
  amass enum -d $d -src crt
done | sort -u
```

### 5. Subdomain Brute Force

```bash
ffuf -w subdomains.txt -u https://FUZZ.example.com -c
massdns -r resolvers.txt -w subdomains.txt example.com
```

---

## Technology Fingerprinting

### 1. Wappalyzer — Detect Tech Stack

```bash
wappalyzer https://example.com
```

### 2. HTTP Header Analysis

```bash
curl -I https://example.com | grep -i 'server\|x-powered\|x-asp\|x-aspnet'
```

### 3. JavaScript Source Analysis

```bash
# Download all JS files and collect them
curl -s https://example.com | grep -oP 'src="\K[^"]+\.js' | while read js; do
  curl -s https://example.com$js >> collected.js
done
```

Look for:
- API endpoints
- Private keys / tokens
- Internal IP addresses
- Backend URLs

### 4. Source Code Comment Mining

```bash
grep -r '// TODO\|FIXME\|HACK\|XXX' *.js
```

---

## Vulnerability Research

### 1. CVE Databases

| Resource | URL |
|----------|-----|
| NVD (NIST) | [nvd.nist.gov](https://nvd.nist.gov/) |
| CVE Details | [cvedetails.com](https://www.cvedetails.com/) |
| Exploit DB | [exploit-db.com](https://www.exploit-db.com/) |

### 2. Search for Known Vulnerabilities in Identified Software

```bash
# Example: target running Apache 2.4.49
searchsploit Apache 2.4.49
```

### 3. Vulnerability Scanners

| Tool | Type |
|------|------|
| Nessus | Commercial |
| OpenVAS | Open source |
| Qualys | Cloud-based |

---

## Network-Level Reconnaissance

### 1. AS Number Lookup

```bash
whois -h whois.radb.net -- '-i origin AS15169'
```

### 2. Find All IP Ranges

```bash
whois example.com | grep -i 'inetnum\|cidr'
```

### 3. BGP Hijacking Research

```
https://bgpstream.com/
```

### 4. Passive DNS Queries (SecurityTrails API)

```bash
curl -H 'apikey: YOUR_API_KEY' https://api.securitytrails.com/v1/domain/example.com/dns
```

---

## Email & User Discovery

### 1. Employee Finder Tools

| Tool | Purpose |
|------|---------|
| [hunter.io](https://hunter.io) | Find company emails |
| [email-format.com](https://email-format.com) | Email pattern detection |
| [clearbit.com](https://clearbit.com) | Company & person data |

### 2. LinkedIn OSINT

```bash
linkedin2username.py -c "Company Name"
```

### 3. Username Enumeration

Common patterns to test: `firstname.lastname`, `firstnamelastname`, `f.lastname`

Check across platforms:
- GitHub
- Twitter / X
- Instagram
- Facebook
- Company email

### 4. Breach Database Queries

| Resource | URL |
|----------|-----|
| Have I Been Pwned | [haveibeenpwned.com](https://haveibeenpwned.com/) |
| Breach Directory | [breachdirectory.com](https://breachdirectory.com/) |

---

## Active Reconnaissance (Requires Authorization)

### 1. Comprehensive Nmap Scan

```bash
nmap -A -sV -sC -O -p- --script vuln 192.168.1.100 -oA report
```

### 2. UDP Service Discovery

```bash
nmap -sU --top-ports 100 192.168.1.100
```

### 3. Service Version Scripts

```bash
nmap --script='*-version' 192.168.1.100
```

---

> ⚠️ Authorization is mandatory before any active reconnaissance.
