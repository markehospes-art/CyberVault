#!/bin/bash

################################################################################
# ADVANCED RECONNAISSANCE & OSINT
# Professional-grade information gathering techniques
# AUTHORIZED TESTING ONLY!
################################################################################

echo "========================================"
echo "ADVANCED RECONNAISSANCE TECHNIQUES"
echo "========================================"
echo ""

# ============================================================================
# PASSIVE RECONNAISSANCE - NO TRAFFIC TO TARGET
# ============================================================================

echo "[*] PASSIVE OSINT - Information gathering without touching target"
echo "---"

echo "1. Using Shodan (must have API key):"
echo "   # Find devices/services online"
echo "   https://www.shodan.io/"
echo "   # Search filters:"
echo "   - country:US"
echo "   - city:'New York'"
echo "   - port:3306"
echo "   - Apache"
echo ""

echo "2. Using Censys:"
echo "   # Certificate transparency search"
echo "   https://censys.io/"
echo "   # Find all subdomains from certs"
echo ""

echo "3. Using GreyNoise:"
echo "   # Identify malicious IPs"
echo "   https://www.greynoise.io/"
echo ""

echo "4. Google dorking (advanced search):"
echo "   site:example.com filetype:pdf"
echo "   site:example.com 'password'"
echo "   inurl:admin"
echo "   intitle:'index of'"
echo "   cache:example.com"
echo ""

echo "5. Wayback Machine:"
echo "   https://web.archive.org/"
echo "   # Find old versions of websites"
echo "   # Discover old endpoints & functionality"
echo ""

# ============================================================================
# ADVANCED SUBDOMAIN ENUMERATION
# ============================================================================

echo "[*] ADVANCED SUBDOMAIN DISCOVERY"
echo "---"

echo "1. Certificate transparency logs:"
echo "   # Use tools to parse CT logs"
echo "   ctfr.py -d example.com  # CTFR tool"
echo "   certsh -d example.com   # Alternative"
echo ""

echo "2. Advanced subfinder:"
echo "   subfinder -d example.com -all -recursive"
echo ""

echo "3. Amass (most comprehensive):"
echo "   amass enum -d example.com"
echo "   amass enum -d example.com -src all"
echo ""

echo "4. Combine multiple tools:"
echo "   cat domains.txt | while read d; do"
echo "     subfinder -d \$d -silent"
echo "     amass enum -d \$d -src crt"
echo "   done | sort -u"
echo ""

echo "5. Subdomain brute force (if needed):"
echo "   ffuf -w subdomains.txt -u https://FUZZ.example.com -c"
echo "   massdns -r resolvers.txt -w subdomains.txt example.com"
echo ""

# ============================================================================
# TECHNOLOGY FINGERPRINTING
# ============================================================================

echo "[*] ADVANCED TECHNOLOGY DISCOVERY"
echo "---"

echo "1. Wappalyzer (detect tech stack):"
echo "   wappalyzer https://example.com"
echo ""

echo "2. HTTP header analysis:"
echo "   curl -I https://example.com | grep -i 'server\|x-powered\|x-asp\|x-aspnet'"
echo ""

echo "3. JavaScript source analysis:"
echo "   # Download all JS files"
echo "   curl -s https://example.com | grep -oP 'src=\"\K[^\"]+\.js' | while read js; do"
echo "     curl -s https://example.com\$js >> collected.js"
echo "   done"
echo "   # Analyze for:"
echo "   - API endpoints"
echo "   - Private keys/tokens"
echo "   - Internal IP addresses"
echo "   - Backend URLs"
echo ""

echo "4. Source code comment mining:"
echo "   grep -r '// TODO\|FIXME\|HACK\|XXX' *.js"
echo ""

# ============================================================================
# VULNERABILITY DATABASE RECONNAISSANCE
# ============================================================================

echo "[*] VULNERABILITY RESEARCH"
echo "---"

echo "1. Search CVE databases:"
echo "   https://nvd.nist.gov/"
echo "   https://www.cvedetails.com/"
echo "   https://www.exploit-db.com/"
echo ""

echo "2. Check for known vulnerabilities in identified software:"
echo "   # If running Apache 2.4.49, check:"
echo "   searchsploit Apache 2.4.49"
echo ""

echo "3. Use vulnerability scanners:"
echo "   nessus"
echo "   openvas"
echo "   qualys"
echo ""

# ============================================================================
# NETWORK RECONNAISSANCE
# ============================================================================

echo "[*] NETWORK-LEVEL RECONNAISSANCE"
echo "---"

echo "1. AS number lookup:"
echo "   whois -h whois.radb.net -- '-i origin AS15169'"
echo ""

echo "2. Find all IP ranges:"
echo "   whois example.com | grep -i 'inetnum\|cidr'"
echo ""

echo "3. BGP hijacking research:"
echo "   https://bgpstream.com/"
echo ""

echo "4. Passive DNS queries:"
echo "   # Using SecurityTrails API"
echo "   curl -H 'apikey: YOUR_API_KEY' https://api.securitytrails.com/v1/domain/example.com/dns"
echo ""

# ============================================================================
# EMAIL & USER RECONNAISSANCE
# ============================================================================

echo "[*] EMAIL & USER DISCOVERY"
echo "---"

echo "1. Employee finder:"
echo "   hunter.io - Find company emails"
echo "   email-format.com - Email pattern detection"
echo "   clearbit.com - Company & person data"
echo ""

echo "2. LinkedIn OSINT:"
echo "   # Scrape public profiles (carefully)"
echo "   linkedin2username.py -c 'Company Name'"
echo ""

echo "3. Username enumeration:"
echo "   # Common patterns: firstname.lastname, firstnamelastname, etc"
echo "   # Test against:"
echo "   - GitHub"
echo "   - Twitter"
echo "   - Instagram"
echo "   - Facebook"
echo "   - Company email"
echo ""

echo "4. Breach database queries:"
echo "   https://haveibeenpwned.com/ (API available)"
echo "   https://breachdirectory.com/"
echo ""

# ============================================================================
# ADVANCED SCANNING
# ============================================================================

echo "[*] ACTIVE RECONNAISSANCE (With Authorization)"
echo "---"

echo "1. Comprehensive nmap enumeration:"
echo "   nmap -A -sV -sC -O -p- --script vuln 192.168.1.100 -oA report"
echo ""

echo "2. UDP service discovery:"
echo "   nmap -sU -top-ports 100 192.168.1.100"
echo ""

echo "3. Service version exploitation:"
echo "   nmap --script='*-version' 192.168.1.100"
echo ""

echo "========================================"
echo "Remember: Authorization is mandatory!"
echo "========================================"
