# DNS - Domain Name System

## Overview
DNS is a distributed system that translates human-readable domain names (like google.com) into IP addresses (like 142.250.185.46) that computers can use.

## How DNS Works

### The DNS Query Process
1. **User enters URL** in browser (www.example.com)
2. **Recursive Resolver** (ISP DNS) receives query
3. **Root Nameserver** responds with TLD nameserver address
4. **TLD Nameserver** (for .com) responds with authoritative nameserver
5. **Authoritative Nameserver** provides the IP address
6. **IP returned** to user's browser
7. **Browser connects** to the IP address

## DNS Record Types

| Record Type | Purpose | Example |
|-------------|---------|----------|
| **A** | Maps domain to IPv4 | example.com → 192.168.1.1 |
| **AAAA** | Maps domain to IPv6 | example.com → 2001:db8::1 |
| **CNAME** | Canonical name (alias) | www.example.com → example.com |
| **MX** | Mail exchange server | example.com → mail.example.com |
| **NS** | Nameserver | example.com → ns1.example.com |
| **TXT** | Text records | SPF, DKIM verification |
| **SOA** | Start of authority | Primary DNS info |
| **PTR** | Reverse DNS lookup | 192.168.1.1 → example.com |

## DNS Components

### 1. DNS Resolver (Recursive Resolver)
- Usually provided by ISP
- Queries on behalf of client
- Returns final answer to client

### 2. Root Nameserver
- 13 root nameservers worldwide
- Points to TLD nameservers
- Maintained by ICANN

### 3. TLD Nameserver
- Handles top-level domains (.com, .org, .edu, etc.)
- Points to authoritative nameserver

### 4. Authoritative Nameserver
- Holds actual DNS records for domain
- Final authority on domain information

## DNS Caching

- Results cached at multiple levels (resolver, browser, OS)
- Reduces DNS queries and speeds up resolution
- TTL (Time To Live) determines how long cache lasts
- Typical TTL: 300-3600 seconds

## Common DNS Tools (Educational)

### nslookup
```bash
nslookup example.com
```

### dig
```bash
dig example.com
dig example.com MX  # Look for mail records
```

### host
```bash
host example.com
```

## DNS Security Concerns

- **DNS Spoofing**: Attacker returns false IP
- **DNS Poisoning**: Cache receives false records
- **DNS Amplification**: DDoS attacks using DNS
- **DNSSEC**: Security extension using cryptography

## DNS Best Practices

- Use trusted DNS resolvers (Google 8.8.8.8, Cloudflare 1.1.1.1)
- Enable DNSSEC where possible
- Monitor DNS queries for anomalies
- Keep DNS records updated