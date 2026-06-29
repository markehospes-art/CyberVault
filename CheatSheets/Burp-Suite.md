# 🕷️ Burp Suite Guide

> The #1 tool for web app hacking. Every web challenge needs this.

---

## Setup (First Time)

1. Download from [portswigger.net/burp](https://portswigger.net/burp/communitydownload) (free Community edition)
2. Open Burp → Proxy → Open Browser (built-in Chromium, already configured)
3. Or configure your own browser:
   - Firefox → Settings → Network → Manual proxy
   - HTTP Proxy: `127.0.0.1` Port: `8080`
4. Install Burp CA certificate (for HTTPS):
   - Go to `http://burpsuite` in the proxied browser
   - Download CA cert → Import into browser

---

## Core Tools

| Tool | What it does |
|------|-------------|
| **Proxy** | Intercept & modify requests between browser and server |
| **Repeater** | Resend & tweak individual requests manually |
| **Intruder** | Automate attacks — brute force, fuzzing, SQLi |
| **Scanner** | Find vulnerabilities automatically (Pro only) |
| **Decoder** | Encode/decode Base64, URL, HTML, hex |
| **Comparer** | Diff two responses |

---

## Proxy — Intercept Requests

```
Proxy tab → Intercept ON
→ Browse to target
→ Request appears in Burp
→ Modify it → Forward
→ Or Drop to cancel
```

**Keyboard shortcuts:**
- `Ctrl+F` — Forward request
- `Ctrl+A` — Select all
- `Right-click → Send to Repeater` — Most used action

---

## Repeater — Modify & Resend

```
1. Intercept a request
2. Right-click → Send to Repeater
3. Go to Repeater tab
4. Modify request
5. Click Send
6. Compare responses on the right
```

**Best for:** Testing SQLi payloads, changing parameters, auth bypass

---

## Intruder — Automated Attacks

```
1. Send request to Intruder (right-click → Send to Intruder)
2. Positions tab → Clear § → highlight what to fuzz → Add §
3. Payloads tab → add your wordlist
4. Start Attack
5. Sort by Status or Length to spot anomalies
```

**Attack types:**
| Type | Use when |
|------|---------|
| Sniper | One payload position, one list |
| Battering Ram | Same payload in multiple positions |
| Pitchfork | Different list per position (user+pass) |
| Cluster Bomb | All combos of multiple lists (brute force login) |

> ⚠️ Intruder is rate-limited in Community edition. Use **ffuf** or **hydra** for fast brute forcing.

---

## Common Workflows

### Test for SQLi
```
1. Intercept a request with a parameter (e.g. ?id=1)
2. Send to Repeater
3. Change id=1 to id=1' → check response for errors
4. Try id=1 OR 1=1-- → check if response changes
5. If yes → go deeper with sqlmap
```

### Brute Force Login
```
1. Intercept login POST request
2. Send to Intruder
3. Mark username and password fields as positions
4. Attack type: Cluster Bomb
5. Load wordlists for both
6. Look for different response length/status
```

### Find Hidden Parameters
```
1. Intercept any request
2. Right-click → Engagement tools → Discover content
3. Or use Param Miner extension (add via BApp Store)
```

### IDOR Testing
```
1. Log in as user A, do an action (e.g. view profile /user?id=12)
2. Intercept request → Send to Repeater
3. Change id=12 to id=11, 13, etc.
4. Different user's data appearing = IDOR vulnerability
```

---

## Decoder Tab

```
# Quick conversions
Base64 encode/decode
URL encode/decode (%20, %3D, etc.)
HTML encode/decode
Hex encode/decode

# Useful for:
- Cookie manipulation
- JWT token inspection
- Encoded payload creation
```

---

## Useful Extensions (BApp Store — free)

| Extension | Use |
|-----------|-----|
| **Param Miner** | Find hidden parameters |
| **JWT Editor** | Modify JWT tokens |
| **Autorize** | Test broken access control |
| **HackBar** | Quick payload injection |
| **Logger++** | Enhanced request logging |

Install via: Extender tab → BApp Store

---

## FoxyProxy (Browser Setup — Recommended)

```
1. Install FoxyProxy extension in Firefox
2. Add proxy: 127.0.0.1:8080
3. Toggle on/off with one click instead of going into settings
```

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Send to Repeater |
| `Ctrl+I` | Send to Intruder |
| `Ctrl+Shift+B` | Send to Scanner |
| `Ctrl+U` | URL encode selection |
| `Ctrl+Shift+U` | URL decode selection |
