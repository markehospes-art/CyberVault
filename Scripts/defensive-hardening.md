# 🛡️ Defensive Security & Hardening

> Detect attacks, harden systems, and prevent compromise.

---

## System Hardening — Linux

### 1. Firewall Configuration (UFW)

```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### 2. Firewall with iptables

```bash
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -P INPUT DROP
```

### 3. Disable Unnecessary Services

```bash
sudo systemctl disable telnet
sudo systemctl disable ftp
sudo systemctl stop telnet
```

### 4. Update System Regularly

```bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove
```

### 5. SSH Hardening

Edit `/etc/ssh/sshd_config`:

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
MaxAuthTries 3
ClientAliveInterval 300
```

### 6. File Permissions

```bash
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh
```

### 7. Sudo Security

Edit `/etc/sudoers` using `visudo`:
- Require password for sudo
- Use `NOPASSWD` sparingly
- Log all sudo commands

---

## Intrusion Detection Systems (IDS)

### 1. Fail2Ban — Bruteforce Protection

```bash
sudo apt-get install fail2ban
# Monitors /var/log/auth.log
# Auto-bans IPs after failed login attempts
```

### 2. OSSEC — Host-Based IDS

```bash
sudo apt-get install ossec-hids
# Monitors file changes, logs, system activity
```

### 3. Snort — Network-Based IDS

```bash
sudo apt-get install snort
# Real-time traffic analysis
```

### 4. Suricata — IDS/IPS

```bash
sudo apt-get install suricata
```

---

## Log Monitoring & Threat Detection

### 1. Monitor Authentication Logs

```bash
tail -f /var/log/auth.log | grep 'Failed password'
```

### 2. Find Suspicious Login Attempts

```bash
grep 'Invalid user' /var/log/auth.log | cut -d' ' -f12 | sort | uniq -c | sort -rn
```

### 3. Monitor Network Connections

```bash
netstat -tulpn
ss -tulpn
```

### 4. Check for Open Ports

```bash
sudo nmap -p- 127.0.0.1
```

### 5. Centralised Logging Tools

| Tool | Purpose |
|------|---------|
| ELK Stack | Centralised logging + visualisation |
| Splunk | Enterprise security monitoring |

---

## Malware Detection & Prevention

### 1. ClamAV — Antivirus

```bash
sudo apt-get install clamav
clamscan -r /home/user/
```

### 2. YARA Rules — Malware Identification

```bash
yara rules.yar /suspicious/file
```

### 3. File Integrity Monitoring (AIDE)

```bash
sudo aideinit
sudo aide --check
```

### 4. Rootkit Detection

```bash
rkhunter --check
chkrootkit
```

---

## Vulnerability Assessment

### 1. OpenVAS
Web-based vulnerability scanner — open source.

### 2. Nessus
Commercial vulnerability assessment tool.

### 3. Tripwire — File Integrity

```bash
tripwire --init
tripwire --check
```

### 4. Lynis — Security Audit

```bash
lynis audit system
```

---

## Incident Response Procedures

### 1. Detect Anomalies
- Monitor CPU/memory usage
- Check for unexpected processes
- Review recent logins
- Check for open ports

### 2. Isolate the Affected System
- Disconnect from network if necessary
- Preserve evidence
- Don't shut down (you'll lose RAM data)

### 3. Forensic Investigation

```bash
# Collect disk image
dd if=/dev/sda of=/mnt/external/drive.img
# Analyse with Autopsy / Sleuth Kit
```

### 4. Recovery
- Change all passwords
- Patch vulnerabilities
- Remove malware
- Restore from a clean backup

---

## ✅ Security Monitoring Checklist

### Daily
- [ ] Review authentication logs
- [ ] Check for failed login attempts
- [ ] Monitor open network connections
- [ ] Check disk usage

### Weekly
- [ ] Review system logs
- [ ] Check for rootkits
- [ ] Verify firewall rules
- [ ] Review sudo commands executed

### Monthly
- [ ] Vulnerability scan
- [ ] Security update check
- [ ] Access control review
- [ ] Incident review

---

> ⚠️ Security is ongoing, not a one-time task.
