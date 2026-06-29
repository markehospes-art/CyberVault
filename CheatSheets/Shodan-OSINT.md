# 🔍 Shodan OSINT Cheat Sheet

> Shodan is a search engine for internet-connected devices. Everything here is passive — you're reading their public index, not touching any system.

---

## Basic Search Syntax

```
search term                  → keyword search
"exact phrase"               → exact match
filter:value                 → apply a filter
filter1:value filter2:value  → combine filters
```

---

## Most Useful Filters

| Filter | What it does | Example |
|--------|-------------|---------|
| `country:` | Filter by country code | `country:NL` |
| `city:` | Filter by city | `city:"Amsterdam"` |
| `port:` | Filter by open port | `port:22` |
| `org:` | Organisation/company | `org:"AT&T"` |
| `isp:` | ISP name | `isp:"KPN"` |
| `product:` | Software/device name | `product:nginx` |
| `os:` | Operating system | `os:"Windows 10"` |
| `http.title:` | Page title | `http.title:"Admin"` |
| `http.status:` | HTTP status code | `http.status:200` |
| `ssl.cert.subject.cn:` | SSL certificate domain | `ssl.cert.subject.cn:"example.com"` |
| `hostname:` | Hostname contains | `hostname:".nl"` |
| `has_screenshot:true` | Has a screenshot | `has_screenshot:true` |
| `vuln:` | Known CVE | `vuln:CVE-2021-44228` |

---

## Find Specific Things

### Defaced Websites
```
http.title:"hacked by"
http.title:"owned by"
http.title:"defaced"
```

### Exposed Admin Panels
```
http.title:"admin" port:80
http.title:"dashboard" http.status:200
http.title:"phpMyAdmin"
http.title:"Webmin"
```

### Exposed Cameras
```
product:"Hikvision"
product:"Dahua"
http.title:"IP Camera"
http.title:"Network Camera" has_screenshot:true
```

### Exposed Routers
```
product:"MikroTik"
http.title:"RouterOS"
http.title:"Zyxel"
http.title:"TP-LINK"
```

### Misconfigured Databases (exposed to internet)
```
port:27017        → MongoDB (no auth)
port:6379         → Redis
port:9200         → Elasticsearch
port:5432         → PostgreSQL
```

### Industrial Control Systems (ICS/SCADA)
```
product:"Modbus"
port:102          → Siemens S7
port:502          → Modbus
```

### Find Things by Country
```
country:NL port:22          → SSH servers in Netherlands
country:NL http.title:"login" → Login pages in Netherlands
country:US product:"Apache"  → Apache servers in USA
```

### Specific Vulnerabilities
```
vuln:CVE-2021-44228          → Log4Shell vulnerable systems
vuln:CVE-2021-26855          → Exchange ProxyLogon
vuln:CVE-2019-19781          → Citrix vulnerability
```

---

## Shodan Dorks (Research Only)

```
# Open MongoDB databases
port:27017 -authentication

# Jenkins (CI/CD panels)
http.title:"Dashboard [Jenkins]"

# Jupyter Notebooks (no password)
http.title:"Jupyter Notebook" -"login"

# Printers exposed to internet
http.title:"Brother" port:80
http.title:"HP LaserJet"

# VNC servers
port:5900 has_screenshot:true

# RDP exposed
port:3389 country:NL
```

---

## Shodan CLI (Command Line)

```bash
# Install
pip install shodan

# Set API key (free account gets limited results)
shodan init YOUR_API_KEY

# Search
shodan search "http.title:admin country:NL"

# Info about specific IP
shodan host 1.2.3.4

# Count results
shodan count "port:3389 country:NL"

# Download results
shodan download results "country:NL port:22"
```

---

## Free vs Paid

| Feature | Free | Paid ($69/yr) |
|---------|------|---------------|
| Search results | 2 pages | Unlimited |
| Filters | Basic | All filters |
| vuln: filter | ❌ | ✅ |
| API access | Limited | Full |
| Exports | ❌ | ✅ |

---

## Similar Tools

| Tool | Best for |
|------|---------|
| [Censys.io](https://censys.io) | Certificates, TLS, deeper scan data |
| [FOFA](https://fofa.info) | Chinese alternative, huge index |
| [ZoomEye](https://zoomeye.org) | Another Shodan alternative |
| [GreyNoise](https://greynoise.io) | Distinguish scanners from real traffic |
| [BinaryEdge](https://binaryedge.io) | Real-time threat intelligence |

---

## Rules

✅ Looking at Shodan results = fine (passive)  
✅ Checking public WHOIS / IP info = fine  
✅ Visiting a public webpage = fine  
❌ Scanning the IP yourself = not fine  
❌ Logging into anything = not fine  
❌ Running tools against it = not fine  
