#!/bin/bash

################################################################################
# DEFENSIVE SECURITY & HARDENING
# Detect attacks, harden systems, prevent compromise
################################################################################

echo "========================================"
echo "DEFENSIVE SECURITY TECHNIQUES"
echo "========================================"
echo ""

# ============================================================================
# SECURITY HARDENING
# ============================================================================

echo "[*] SYSTEM HARDENING - LINUX"
echo "---"

echo "1. Firewall configuration (UFW):"
echo "   sudo ufw enable"
echo "   sudo ufw default deny incoming"
echo "   sudo ufw default allow outgoing"
echo "   sudo ufw allow 22/tcp"
echo "   sudo ufw allow 80/tcp"
echo "   sudo ufw allow 443/tcp"
echo ""

echo "2. Firewall with iptables:"
echo "   iptables -A INPUT -p tcp --dport 22 -j ACCEPT"
echo "   iptables -A INPUT -p tcp --dport 80 -j ACCEPT"
echo "   iptables -A INPUT -p tcp --dport 443 -j ACCEPT"
echo "   iptables -P INPUT DROP"
echo ""

echo "3. Disable unnecessary services:"
echo "   sudo systemctl disable telnet"
echo "   sudo systemctl disable ftp"
echo "   sudo systemctl stop telnet"
echo ""

echo "4. Update system regularly:"
echo "   sudo apt update && sudo apt upgrade -y"
echo "   sudo apt autoremove"
echo ""

echo "5. SSH hardening:"
echo "   # Edit /etc/ssh/sshd_config"
echo "   - PermitRootLogin no"
echo "   - PasswordAuthentication no"
echo "   - PubkeyAuthentication yes"
echo "   - Port 2222  (non-standard)"
echo "   - MaxAuthTries 3"
echo "   - ClientAliveInterval 300"
echo ""

echo "6. File permissions:"
echo "   chmod 600 ~/.ssh/id_rsa"
echo "   chmod 644 ~/.ssh/id_rsa.pub"
echo "   chmod 700 ~/.ssh"
echo ""

echo "7. Sudo security:"
echo "   # Edit /etc/sudoers (use visudo)"
echo "   - Require password for sudo"
echo "   - Use NOPASSWD sparingly"
echo "   - Log all sudo commands"
echo ""

# ============================================================================
# INTRUSION DETECTION
# ============================================================================

echo "[*] INTRUSION DETECTION SYSTEMS (IDS)"
echo "---"

echo "1. Fail2Ban (Bruteforce protection):"
echo "   sudo apt-get install fail2ban"
echo "   # Monitors /var/log/auth.log"
echo "   # Auto-bans IPs after failed login attempts"
echo ""

echo "2. OSSEC (Host-based IDS):"
echo "   # Monitors file changes, logs, system activity"
echo "   sudo apt-get install ossec-hids"
echo ""

echo "3. Snort (Network-based IDS):"
echo "   # Real-time traffic analysis"
echo "   sudo apt-get install snort"
echo ""

echo "4. Suricata (IDS/IPS):"
echo "   sudo apt-get install suricata"
echo ""

# ============================================================================
# LOG MONITORING & ANALYSIS
# ============================================================================

echo "[*] LOG MONITORING & THREAT DETECTION"
echo "---"

echo "1. Monitor authentication logs:"
echo "   tail -f /var/log/auth.log | grep 'Failed password'"
echo ""

echo "2. Find suspicious login attempts:"
echo "   grep 'Invalid user' /var/log/auth.log | cut -d' ' -f12 | sort | uniq -c | sort -rn"
echo ""

echo "3. Monitor network connections:"
echo "   netstat -tulpn"
echo "   ss -tulpn"
echo ""

echo "4. Check for open ports:"
echo "   sudo nmap -p- 127.0.0.1"
echo ""

echo "5. ELK Stack (Elasticsearch, Logstash, Kibana):"
echo "   # Centralized logging and analysis"
echo "   # Visualize security events"
echo ""

echo "6. Splunk:"
echo "   # Enterprise security monitoring"
echo ""

# ============================================================================
# MALWARE DETECTION
# ============================================================================

echo "[*] MALWARE DETECTION & PREVENTION"
echo "---"

echo "1. ClamAV (Antivirus):"
echo "   sudo apt-get install clamav"
echo "   clamscan -r /home/user/"
echo ""

echo "2. YARA rules (Malware identification):"
echo "   # Install YARA"
echo "   yara rules.yar /suspicious/file"
echo ""

echo "3. File integrity monitoring:"
echo "   # With aide"
echo "   sudo aideinit"
echo "   sudo aide --check"
echo ""

echo "4. Check for rootkits:"
echo "   rkhunter --check"
echo "   chkrootkit"
echo ""

# ============================================================================
# VULNERABILITY SCANNING
# ============================================================================

echo "[*] VULNERABILITY ASSESSMENT"
echo "---"

echo "1. OpenVAS (Vulnerability scanner):"
echo "   # Web-based vulnerability scanner"
echo ""

echo "2. Nessus:"
echo "   # Commercial vulnerability assessment"
echo ""

echo "3. Tripwire (File integrity):"
echo "   tripwire --init"
echo "   tripwire --check"
echo ""

echo "4. Lynis (Security audit):"
echo "   lynis audit system"
echo ""

# ============================================================================
# INCIDENT RESPONSE
# ============================================================================

echo "[*] INCIDENT RESPONSE PROCEDURES"
echo "---"

echo "1. Detect anomalies:"
echo "   - Monitor CPU/Memory usage"
echo "   - Check for unexpected processes"
echo "   - Review recent logins"
echo "   - Check for open ports"
echo ""

echo "2. Isolate affected system:"
echo "   - Disconnect from network if necessary"
echo "   - Preserve evidence"
echo "   - Don't shut down (lose RAM data)"
echo ""

echo "3. Forensic investigation:"
echo "   # Collect evidence"
echo "   dd if=/dev/sda of=/mnt/external/drive.img"
echo "   # Analyze with Autopsy/Sleuth Kit"
echo ""

echo "4. Recovery:"
echo "   - Change all passwords"
echo "   - Patch vulnerabilities"
echo "   - Remove malware"
echo "   - Restore from clean backup"
echo ""

# ============================================================================
# SECURITY MONITORING CHECKLIST
# ============================================================================

echo "[*] SECURITY MONITORING CHECKLIST"
echo "---"

echo "Daily:"
echo "  [ ] Review authentication logs"
echo "  [ ] Check for failed login attempts"
echo "  [ ] Monitor open network connections"
echo "  [ ] Check disk usage"
echo ""

echo "Weekly:"
echo "  [ ] Review system logs"
echo "  [ ] Check for rootkits"
echo "  [ ] Verify firewall rules"
echo "  [ ] Review sudo commands executed"
echo ""

echo "Monthly:"
echo "  [ ] Vulnerability scan"
echo "  [ ] Security update check"
echo "  [ ] Access control review"
echo "  [ ] Incident review"
echo ""

echo "========================================"
echo "Security is ongoing, not one-time!"
echo "========================================"
