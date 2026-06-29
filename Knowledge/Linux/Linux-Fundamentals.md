# 🐧 Linux Fundamentals

> Essential Linux skills every ethical hacker needs before anything else.

---

## Navigating the File System

```bash
pwd               # Print current directory
ls -la            # List files (including hidden) with details
cd /etc           # Change directory
cd ~              # Go to home directory
cd ..             # Go up one level
find / -name "file.txt" 2>/dev/null   # Search for a file
locate passwd     # Fast search using index
```

## File Operations

```bash
cp file.txt /tmp/         # Copy file
mv file.txt newname.txt   # Move / rename
rm file.txt               # Delete file
rm -rf /tmp/folder/       # Delete folder recursively
mkdir -p /tmp/new/dir     # Create nested directories
cat file.txt              # Print file contents
less file.txt             # Scroll through file
head -20 file.txt         # First 20 lines
tail -20 file.txt         # Last 20 lines
grep "password" file.txt  # Search inside file
```

## Users & Permissions

```bash
whoami            # Current user
id                # User ID, group ID
su - username     # Switch user
sudo command      # Run as root
adduser username  # Add a new user
passwd username   # Change password
```

### File Permissions

```
-rwxr-xr--  1  owner  group  size  date  filename
 |||||||
 ||||||└── Others: read only (r--)
 |||└───── Group:  read + execute (r-x)
 └──────── Owner:  read + write + execute (rwx)
```

```bash
chmod 755 script.sh       # rwxr-xr-x
chmod 600 secret.txt      # rw------- (private file)
chmod +x script.sh        # Add execute permission
chown user:group file     # Change ownership
```

### SUID / SGID / Sticky Bit

```bash
chmod u+s binary    # Set SUID (runs as owner)
chmod g+s binary    # Set SGID (runs as group)
chmod +t /tmp       # Sticky bit (only owner can delete)
```

---

## Processes & Services

```bash
ps aux                    # List all running processes
ps aux | grep apache      # Find specific process
kill -9 PID               # Force kill a process
top                       # Live process monitor
htop                      # Better live monitor

systemctl start apache2   # Start a service
systemctl stop apache2    # Stop a service
systemctl status apache2  # Check service status
systemctl enable ssh      # Start on boot
```

---

## Networking Commands

```bash
ip a                          # Show IP addresses (modern)
ifconfig                      # Show interfaces (old)
ip route                      # Show routing table
netstat -tulpn                # Open ports and listeners
ss -tulpn                     # Same, faster alternative
ping 8.8.8.8                  # Test connectivity
traceroute google.com         # Trace network path
nslookup domain.com           # DNS lookup
dig domain.com                # Detailed DNS lookup
curl -I https://example.com   # Fetch HTTP headers
wget https://example.com/file # Download a file
```

---

## Text Processing

```bash
grep -r "keyword" /etc/       # Recursive search
grep -i "Password" file.txt   # Case-insensitive search
grep -v "comment" file.txt    # Exclude lines matching
cut -d: -f1 /etc/passwd       # Extract column 1 (delimiter :)
awk '{print $1}' file.txt     # Print first column
sort file.txt                 # Sort lines
uniq -c file.txt              # Count unique lines
wc -l file.txt                # Count lines
sed 's/old/new/g' file.txt    # Find and replace
```

---

## Package Management

### Debian / Ubuntu (apt)
```bash
sudo apt update
sudo apt install nmap
sudo apt remove nmap
sudo apt upgrade
```

### Red Hat / CentOS (yum/dnf)
```bash
sudo yum install nmap
sudo dnf install nmap
```

---

## Environment & Shell

```bash
echo $PATH                    # Current PATH variable
export MYVAR="value"          # Set environment variable
env                           # List all env variables
history                       # Command history
alias ll='ls -la'             # Create a shortcut
~/.bashrc                     # Persistent aliases go here

# Redirection
command > output.txt          # Redirect stdout to file
command >> output.txt         # Append stdout
command 2> errors.txt         # Redirect stderr
command 2>/dev/null           # Discard errors
command | another_command     # Pipe output
```

---

## Important Directories

| Path | Contents |
|------|----------|
| `/etc/passwd` | User accounts |
| `/etc/shadow` | Hashed passwords (root only) |
| `/etc/hosts` | Local DNS entries |
| `/etc/crontab` | Scheduled tasks |
| `/var/log/` | System logs |
| `/tmp/` | Temporary files (world-writable) |
| `/home/` | User home directories |
| `/root/` | Root's home directory |
| `/usr/bin/` | Standard binaries |
| `/sbin/` | System binaries |

---

## Bash Scripting Basics

```bash
#!/bin/bash

# Variables
NAME="world"
echo "Hello, $NAME"

# If statement
if [ $USER == "root" ]; then
  echo "Running as root"
else
  echo "Not root"
fi

# For loop
for i in {1..5}; do
  echo "Number: $i"
done

# While loop
while read line; do
  echo "$line"
done < file.txt

# Functions
greet() {
  echo "Hello, $1"
}
greet "hacker"
```

---

> 💡 Tip: Practice every command in a VM or TryHackMe before using it on a real target.
