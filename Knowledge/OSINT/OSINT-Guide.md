# 🔎 OSINT Guide

This guide covers ethical and authorized OSINT workflows for identifying public-facing information, infrastructure, and exposure without violating scope, privacy, or legal boundaries.

---

## What OSINT Is

Open-Source Intelligence (OSINT) is the collection and analysis of publicly available data to answer questions such as:

- What domains and subdomains belong to a target?
- What services are exposed online?
- What email addresses, usernames, or infrastructure details are discoverable?
- What historical or archived information is publicly available?

This repository focuses on responsible use in controlled environments, authorized testing, and educational labs.

---

## Core OSINT Workflow

1. Define the target and scope.
2. Gather passive data from public sources.
3. Validate findings with minimal probing.
4. Correlate infrastructure, identities, and exposure.
5. Document evidence and stop at the authorized boundary.

---

## Common OSINT Sources

### Search Engines

- Google and Bing advanced operators
- DuckDuckGo and other privacy-focused search engines
- GitHub code and repository search
- Public docs, PDFs, and developer portals

### Passive Infrastructure Discovery

- Certificate Transparency logs
- DNS and subdomain enumeration
- Public IP and service discovery
- Archive and web history tools

### Social and Identity Data

- Public profiles and staff pages
- Press releases and company docs
- GitHub and LinkedIn public metadata
- Public contact and support pages

---

## Useful Tools

```bash
# Subdomain discovery
subfinder -d example.com
amass enum -d example.com

# DNS lookups
dig example.com
nslookup example.com

# Web enumeration
curl -I https://example.com
wget --spider https://example.com

# Email / username discovery
theHarvester -d example.com -b all

# Public web archives
https://web.archive.org/
```

---

## Example Queries

```text
site:example.com
site:example.com filetype:pdf
inurl:admin example.com
"admin@example.com" site:example.com
```

---

## Good Practice

- Only collect data relevant to the approved scope.
- Prefer passive collection over intrusive probing.
- Correlate results carefully before drawing conclusions.
- Keep notes and findings organized and evidence-based.
- Stop if the target or the scope changes.

---

## Related Topics in This Repository

- [Networking](../Networking/README.md)
- [Web-Security](../Web-Security/Web-Application-Security.md)
- [CTF](../CTF/CTF-Methodology.md)
- [Command Reference](../../CheatSheets/Command-Reference.md)
- [CyberVault README](../../README.md)

---

[Back to Knowledge Index](../README.md)
