# 🐧 Linux Fundamentals

## File System

```bash
/
├── bin/          # Essential commands
├── etc/          # Configuration files
├── home/         # User home directories
├── root/         # Root home directory
├── usr/          # User programs and data
├── var/          # Variable data (logs, cache)
├── tmp/          # Temporary files
├── opt/          # Optional software
├── proc/         # Process information
├── sys/          # System information
└── dev/          # Device files
```

## User and Permissions

### Users and Groups

```bash
id                           # Current user info
whoami                       # Current username
who                          # Logged in users
w                            # Detailed login info
```

### Permissions

```bash
chmod 755 file               # rwxr-xr-x
chmod 644 file               # rw-r--r--
chown user:group file        # Change owner
chgrp group file             # Change group
```

### Sudo

```bash
sudo -l                      # List sudoers
sudo command                 # Run as root
sudo -u user command         # Run as specific user
```

## Essential Commands

### Navigation

```bash
pwd                          # Print working directory
cd /path                     # Change directory
ls -la                       # List files with details
find / -name file            # Search for file
```

### File Operations

```bash
cat file                     # Display file
less file                    # Paginated view
head -n 10 file              # First 10 lines
tail -n 10 file              # Last 10 lines
grep pattern file            # Search in file
```

### Process Management

```bash
ps aux                       # List processes
top                          # Real-time processes
kill -9 PID                  # Kill process
bg                           # Background job
fg                           # Foreground job
```

### Network

```bash
ip addr                      # IP configuration
ifconfig                     # Network interfaces
netstat -tulpn               # Network connections
ss -tulpn                    # Socket statistics
ping target                  # ICMP test
nslookup domain              # DNS lookup
```

## System Administration

```bash
uname -a                     # System information
uptime                       # System uptime
df -h                        # Disk usage
du -sh /path                 # Directory size
mount                        # Mounted filesystems
free -h                      # Memory usage
```

## Bash Scripting Basics

```bash
#!/bin/bash

# Variables
VAR="value"
echo $VAR

# Conditionals
if [ $VAR = "value" ]; then
    echo "Match"
fi

# Loops
for i in {1..10}; do
    echo $i
done

# Functions
function myfunction() {
    echo "Hello"
}
```

