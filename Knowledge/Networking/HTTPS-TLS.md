# HTTPS/TLS - Secure Web Communication

## Overview
HTTPS (HTTP Secure) is HTTP wrapped in encryption using TLS (Transport Layer Security). TLS ensures data confidentiality, integrity, and authentication.

## HTTPS vs HTTP

| Feature | HTTP | HTTPS |
|---------|------|-------|
| Encryption | None (plaintext) | TLS/SSL encrypted |
| Port | 80 | 443 |
| Speed | Slightly faster | Minimal overhead (modern) |
| Security | Low | High |
| Authentication | None | Certificate-based |
| SEO | Penalized | Preferred |

## TLS Handshake (HTTPS Connection)

### Step-by-Step Process

1. **Client Hello**
   - Client sends supported TLS versions
   - Supported cipher suites
   - Random number (client random)

2. **Server Hello**
   - Server chooses TLS version
   - Chooses cipher suite
   - Sends random number (server random)
   - Sends SSL certificate

3. **Certificate Verification**
   - Client verifies certificate validity
   - Checks if signed by trusted CA (Certificate Authority)
   - Validates domain name matches

4. **Key Exchange**
   - Client generates pre-master secret
   - Encrypts with server's public key
   - Sends to server

5. **Session Key Generation**
   - Both sides generate same session key
   - Using: pre-master secret + client random + server random

6. **Finished Messages**
   - Both sides send encrypted "Finished" message
   - Proves possession of session key

7. **Secure Communication**
   - All data now encrypted with session key
   - HTTPS connection established ✅

## SSL vs TLS

- **SSL (Secure Sockets Layer)**: Older protocol (deprecated)
  - SSL 1.0, 2.0, 3.0 - all insecure
  - Do not use

- **TLS (Transport Layer Security)**: Modern replacement
  - TLS 1.0, 1.1 - legacy (being phased out)
  - TLS 1.2 - current standard
  - TLS 1.3 - latest, fastest, most secure

## SSL/TLS Certificates

### Certificate Components
- **Subject**: Domain/Organization name
- **Issuer**: Signing Certificate Authority
- **Validity**: Start and expiration dates
- **Public Key**: Used for encryption
- **Signature**: Proof from CA

### Certificate Types

1. **Domain Validated (DV)**
   - Only domain ownership verified
   - Cheapest option
   - Green lock in browser

2. **Organization Validated (OV)**
   - Domain + Organization verified
   - More trust than DV

3. **Extended Validation (EV)**
   - Extensive verification process
   - Shows organization name in green bar
   - Most expensive, highest trust

### Wildcard Certificates
- Cover domain and all subdomains
- Example: *.example.com covers www, mail, ftp

### Self-Signed Certificates
- Created without CA authority
- Useful for local/lab testing only
- Browser shows security warning

## Cipher Suites

Combination of algorithms:
1. **Key Exchange**: How keys are exchanged (RSA, ECDHE)
2. **Authentication**: Verify identity (RSA, ECDSA)
3. **Encryption**: Encrypt data (AES, ChaCha20)
4. **Hash/MAC**: Verify integrity (SHA, MD5)

Example: `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`

## Certificate Chain

```
Root CA (Self-signed, trusted)
    ↓
Intermediate CA (Signed by Root)
    ↓
Server Certificate (Your domain, signed by Intermediate)
```

## Common TLS Issues

- **Expired Certificate**: Update certificate before expiration
- **Self-Signed Certificate**: Only for testing, not production
- **Mismatched Domain**: Certificate domain ≠ requested domain
- **Weak Cipher Suites**: Use modern, strong encryption
- **Mixed Content**: HTTP resources loaded from HTTPS page

## Certificate Verification Tools (Educational)

### Check certificate expiration
```bash
openssl s_client -connect example.com:443 -showcerts
```

### View certificate details
```bash
openssl x509 -in certificate.pem -text -noout
```

## Best Practices

✅ Always use HTTPS for production websites
✅ Use TLS 1.2 or higher
✅ Keep certificates updated
✅ Use strong cipher suites
✅ Implement HSTS (HTTP Strict Transport Security)
✅ Regularly audit SSL/TLS configuration