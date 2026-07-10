# Knowledge Structure Guide

This document explains how content is organized in CyberVault.

## Directory Structure

```
CyberVault/
├── README.md                 # Home page & quick navigation
├── LICENSE                   # MIT License
├── CONTRIBUTING.md          # How to contribute
├── REPO_GUIDELINES.md       # Repository policies
├── STRUCTURE.md             # This file
│
├── CheatSheets/             # Quick reference guides
│   ├── Nmap.md
│   ├── Burp-Suite.md
│   ├── Reverse-Shells.md
│   ├── SQL-Injection-Quick-Ref.md
│   ├── Privilege-Escalation-Checklist.md
│   ├── Metasploit.md
│   ├── Active-Directory-Quick-Ref.md
│   ├── Pivoting-Port-Forwarding.md
│   ├── Buffer-Overflow.md
│   └── Home-Lab-Setup.md
│
├── Knowledge/               # Deep learning & detailed guides
│   ├── Networking/
│   │   ├── OSI-Model.md
│   │   ├── IP-Addressing.md
│   │   ├── Subnetting.md
│   │   ├── TCP-UDP.md
│   │   ├── DNS.md
│   │   └── HTTPS-TLS.md
│   ├── Linux/
│   │   └── Linux-Fundamentals.md
│   ├── Web-Security/
│   │   └── Web-Application-Security.md
│   ├── Password-Attacks/
│   │   └── Password-Attacks.md
│   ├── Active-Directory/
│   │   └── Active-Directory.md
│   ├── Cryptography/
│   │   └── Cryptography-Basics.md
│   ├── Wireless/
│   │   └── Wireless-Security.md
│   └── CTF/
│       └── CTF-Methodology.md
│
├── Scripts/                 # Techniques & methodologies
│   ├── advanced-recon.md
│   ├── exploitation-techniques.md
│   ├── privilege-escalation.md
│   ├── post-exploitation.md
│   └── defensive-hardening.md
│
└── MOCs/                    # Maps of Contents (Learning paths)
    └── Networking.md       # Structured learning path
```

## Content Types Explained

### 📋 CheatSheets/
**Purpose:** Quick reference during active work
- Bulleted lists and tables
- Command examples ready to copy
- Minimal explanation (assume familiarity)
- Perfect for "I know what I need, just give me the command"
- 1-3 pages typical

**Example:** "I'm running Nmap, what flags do I need?"

### 📚 Knowledge/
**Purpose:** Deep learning and understanding concepts
- Comprehensive explanations
- Visual examples and diagrams
- Build foundational knowledge
- Multiple sections with clear progression
- 5-15 pages typical

**Example:** "I want to understand how DNS really works"

### 🛠️ Scripts/
**Purpose:** Methodologies and practical workflows
- Step-by-step procedures
- Multi-tool workflows
- Real-world scenarios
- Tool combinations and chaining
- 3-8 pages typical

**Example:** "What's my full workflow for post-exploitation?"

### 🗺️ MOCs/
**Purpose:** Structured learning journeys (Maps of Contents)
- Prerequisites and learning order
- Time estimates per topic
- Links to relevant content
- Progress checkpoints
- Success criteria

**Example:** "I'm new to networking, what should I learn first and in what order?"

## File Naming Conventions

```
CheatSheets/
├── Tool-Name.md              # Tool name with title case
├── Technique-Quick-Ref.md    # Technique with -Quick-Ref suffix
└── Topic-Checklist.md        # Checkbox list with -Checklist suffix

Knowledge/Category/
├── Topic.md                  # Simple topic name
└── Topic-Basics.md           # Fundamentals with -Basics suffix

Scripts/
├── methodology-focus.md      # lowercase with hyphens
└── technique-category.md

MOCs/
└── Topic.md                  # Topic name for learning path
```

## Content Standards

### Every File Should Have

✅ **Header** — Title with emoji + clear description
```markdown
# 🛠️ Tool Name

Brief description of what this is about.
```

✅ **Overview** — What will you learn?
```markdown
## Overview
- What this covers
- When to use it
- Prerequisites (if any)
```

✅ **Main Content** — Organized sections
```markdown
## Topic 1
## Topic 2
## Examples
## Related Resources
```

✅ **Links** — Internal references to related content
```markdown
[Related Topic](../path/to/file.md)
```

✅ **Updated Date** — At the bottom for tracking
```markdown
Last Updated: July 2026
```

### Formatting Standards

| Element | Format | Example |
|---------|--------|---------|
| Key terms | **bold** | **authentication** |
| Code | backticks | `nmap -A` |
| Warnings | `> ⚠️` | > ⚠️ Requires root access |
| Tips | `> 💡` | > 💡 Pro tip: use -v for verbose |
| Comparisons | Tables | Tool name \| Pros \| Cons |
| Commands | Code blocks | \`\`\`bash |
| Results | Code blocks | \`\`\`output |

## How to Add New Content

### Adding a New Cheat Sheet
1. Create file in `CheatSheets/` with name `Topic-Quick-Ref.md`
2. Add header with emoji
3. Include quick commands/tables (minimal text)
4. Keep it scannable — bullets and tables preferred
5. Link from README.md CheatSheets section

### Adding Knowledge Content
1. Create directory in `Knowledge/Category/`
2. Create comprehensive markdown file
3. Include Overview, multiple sections, examples
4. Add "Related Resources" section at bottom
5. Update Knowledge section links in README.md

### Adding a New MOC (Learning Path)
1. Create in `MOCs/` directory
2. Define learning prerequisites
3. Organize topics with time estimates
4. Include success criteria
5. Link to Knowledge/CheatSheet content

### Adding to Scripts
1. Create file in `Scripts/` directory
2. Start with clear use case/scenario
3. Break into numbered steps
4. Include tool alternatives where applicable
5. End with related techniques

## Linking Best Practices

```markdown
# Relative links (preferred)
[DNS Basics](../Knowledge/Networking/DNS.md)
[Nmap Cheat Sheet](../CheatSheets/Nmap.md)
[External Tool](https://example.com)

# Anchors for sections
[See DNS Resolution](../Knowledge/Networking/DNS.md#dns-query-process)
```

## Review Checklist Before Adding Content

- [ ] File name follows naming conventions
- [ ] Content type is correct (CheatSheet vs Knowledge vs Scripts)
- [ ] Header with emoji is present
- [ ] Links are relative and test correctly
- [ ] No credentials, keys, or sensitive info
- [ ] Code examples are tested or clearly hypothetical
- [ ] Ethical guidelines mentioned where needed
- [ ] Last Updated date is current
- [ ] README.md updated with new content links

---

*Last Updated: July 2026*
