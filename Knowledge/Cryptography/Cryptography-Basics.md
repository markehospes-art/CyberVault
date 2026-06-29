# 🔐 Cryptography Basics

> Understanding crypto is essential — it underpins encryption, hashing, authentication, and more.

---

## Encoding vs Encryption vs Hashing

| | Encoding | Encryption | Hashing |
|---|----------|-----------|---------|
| **Reversible?** | Yes (no key) | Yes (with key) | No |
| **Purpose** | Data format | Confidentiality | Integrity |
| **Key needed?** | No | Yes | No |
| **Examples** | Base64, URL encoding | AES, RSA | MD5, SHA256 |

---

## Encoding

Encoding transforms data into a different format — **not** for security, just for compatibility.

### Base64

```bash
# Encode
echo "hello world" | base64
# Output: aGVsbG8gd29ybGQ=

# Decode
echo "aGVsbG8gd29ybGQ=" | base64 -d
# Output: hello world

# Detect: ends with = or ==, uses A-Z a-z 0-9 +/
```

### URL Encoding

```
Space → %20
/ → %2F
= → %3D
& → %26
# → %23
```

```bash
# Python
python3 -c "import urllib.parse; print(urllib.parse.quote('hello world'))"
python3 -c "import urllib.parse; print(urllib.parse.unquote('hello%20world'))"
```

### Hex Encoding

```bash
echo "hello" | xxd          # Show hex
echo "hello" | xxd -p       # Plain hex only
echo "68656c6c6f" | xxd -r -p  # Decode hex back to ASCII
```

---

## Hashing

A hash is a **one-way** fixed-length fingerprint of data. The same input always produces the same output.

### Common Hash Algorithms

| Algorithm | Output Length | Status |
|-----------|--------------|--------|
| MD5 | 128 bits (32 hex) | Broken — don't use |
| SHA1 | 160 bits (40 hex) | Weak — avoid |
| SHA256 | 256 bits (64 hex) | Secure |
| SHA512 | 512 bits (128 hex) | Very secure |
| bcrypt | 60 chars | Best for passwords |
| Argon2 | Variable | Best modern choice |

### Generating Hashes

```bash
echo -n "password" | md5sum
echo -n "password" | sha1sum
echo -n "password" | sha256sum
echo -n "password" | sha512sum
```

### Why MD5 Is Broken

MD5 is vulnerable to **collision attacks** — two different inputs can produce the same hash.

```bash
# These two different files have the same MD5 hash
md5sum file1.txt  # d41d8cd98f00b204e9800998ecf8427e
md5sum file2.txt  # d41d8cd98f00b204e9800998ecf8427e  ← same!
```

### Salting

A **salt** is random data added to a password before hashing to prevent rainbow table attacks.

```
salt = "x7kQ"
hash(password + salt) = hash("passwordx7kQ")
```

bcrypt automatically handles salting — each hash includes the salt.

---

## Symmetric Encryption

Same key for encryption and decryption.

### AES (Advanced Encryption Standard)

The standard today. Used in TLS, file encryption, VPNs.

```
Key sizes: 128-bit, 192-bit, 256-bit
Modes: ECB (weak), CBC, CTR, GCM (recommended)
```

```bash
# Encrypt a file with AES-256-CBC
openssl enc -aes-256-cbc -salt -in plaintext.txt -out encrypted.bin -k 'mysecretpassword'

# Decrypt
openssl enc -aes-256-cbc -d -in encrypted.bin -out decrypted.txt -k 'mysecretpassword'
```

### Why ECB Mode Is Weak

ECB encrypts each block independently — identical plaintext blocks produce identical ciphertext blocks. This leaks patterns.

```
ECB: [BLOCK1][BLOCK2][BLOCK3] → [ENC1][ENC2][ENC3]
CBC: Each block XOR'd with previous → no patterns leaked
```

---

## Asymmetric Encryption

Two keys: **public key** (encrypt / verify) and **private key** (decrypt / sign).

### RSA

Most common asymmetric algorithm. Used in HTTPS, SSH, email.

```bash
# Generate RSA key pair
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -pubout -out public.pem

# Encrypt with public key
openssl rsautl -encrypt -pubin -inkey public.pem -in plain.txt -out encrypted.bin

# Decrypt with private key
openssl rsautl -decrypt -inkey private.pem -in encrypted.bin -out decrypted.txt
```

### How HTTPS Uses Both

```
1. Client requests server's public key
2. Client encrypts a "session key" with server's public key
3. Server decrypts session key with its private key
4. Both now use the session key (AES) for fast symmetric encryption
```

This is called **hybrid encryption** — RSA for key exchange, AES for the data.

---

## Digital Signatures

Prove authenticity and integrity. Signed with **private key**, verified with **public key**.

```bash
# Sign a file
openssl dgst -sha256 -sign private.pem -out signature.bin file.txt

# Verify the signature
openssl dgst -sha256 -verify public.pem -signature signature.bin file.txt
# Output: Verified OK
```

---

## TLS / SSL

TLS secures connections (HTTPS, email, VPNs). It uses:

1. **Certificates** — prove server identity (signed by a CA)
2. **Asymmetric crypto** — for key exchange (RSA or ECDH)
3. **Symmetric crypto** — AES for actual data transfer
4. **HMAC** — integrity check on each packet

```bash
# Inspect a site's TLS certificate
openssl s_client -connect example.com:443

# Check certificate details
openssl s_client -connect example.com:443 | openssl x509 -text

# Check for weak ciphers
nmap --script ssl-enum-ciphers -p 443 example.com
```

---

## Common Crypto Attacks

| Attack | Target | Description |
|--------|--------|-------------|
| **Brute force** | Passwords, keys | Try all combinations |
| **Rainbow table** | Unsalted hashes | Pre-computed hash lookups |
| **Birthday attack** | Hash collisions | Find two inputs with same hash |
| **Padding oracle** | CBC mode | Leak plaintext via padding errors |
| **Timing attack** | Comparisons | Measure response time to infer data |
| **Weak RNG** | Key generation | Predictable randomness → predictable keys |
| **Downgrade attack** | TLS | Force client to use older, weaker protocol |

---

## Quick CTF Crypto Toolkit

```bash
# Identify unknown encoding
file mystery.bin
xxd mystery.bin | head

# Try Base64
echo "..." | base64 -d

# Try hex decode
echo "68656c6c6f" | xxd -r -p

# Identify hash type
hashid 'hash_value_here'

# ROT13 (Caesar cipher with shift 13)
echo "uryyb" | tr 'A-Za-z' 'N-ZA-Mn-za-m'

# XOR analysis (Python)
python3 -c "print(bytes([a ^ 0x41 for a in b'\x29\x2c\x2c\x2f']))"
```

---

> 💡 Start at [CryptoHack](https://cryptohack.org/) for hands-on cryptography challenges designed for hackers.
