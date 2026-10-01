# 🌐 Web Application Security

## OWASP Top 10

### 1. Injection (SQL, Command, LDAP)
- Input validation
- Parameterized queries
- Least privilege

### 2. Broken Authentication
- Weak password policies
- Session management issues
- Credential stuffing

### 3. Sensitive Data Exposure
- Unencrypted transmission
- Weak encryption
- Inadequate key management

### 4. XML External Entities (XXE)
- Disable XXE parsing
- Validate XML input
- Use safer XML parsers

### 5. Broken Access Control
- Insecure direct object references (IDOR)
- Missing authorization checks
- Privilege escalation

### 6. Security Misconfiguration
- Default credentials
- Unnecessary services
- Missing security headers

### 7. Cross-Site Scripting (XSS)
- Input validation
- Output encoding
- Content Security Policy

### 8. Insecure Deserialization
- Validate serialized objects
- Avoid untrusted deserialization
- Use safe libraries

### 9. Using Components with Known Vulnerabilities
- Dependency scanning
- Regular updates
- Version pinning

### 10. Insufficient Logging & Monitoring
- Comprehensive logging
- Centralized log management
- Alert triggers

---

## Testing Methodology

1. Reconnaissance
2. Scanning
3. Enumeration
4. Vulnerability assessment
5. Exploitation
6. Post-exploitation
7. Reporting

