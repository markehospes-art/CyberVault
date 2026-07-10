# FAQ - Frequently Asked Questions

## General

### Q: What is CyberVault?
**A:** CyberVault is a personal knowledge base for ethical hacking and cybersecurity learning. It contains cheat sheets, in-depth guides, and scripts for practicing penetration testing and security hardening—all in a legal, authorized way.

### Q: Is this for beginners or advanced users?
**A:** Both. Start with the **Learning Paths (MOCs)** if you're new. If you're experienced, jump straight to **Cheat Sheets** and **Scripts**.

### Q: Can I use this for a real penetration test?
**A:** Yes, *if you have written authorization*. Always get explicit permission before testing any system you don't own.

---

## Learning & Practice

### Q: Where should I start?
**A:** 
1. Pick a **Learning Path (MOC)** that interests you
2. Work through the fundamentals
3. Practice on **TryHackMe** or **HackTheBox**
4. Reference **Cheat Sheets** when needed

### Q: Which practice platform is best for me?
| If you want | Try |
|------------|-----|
| Guided tutorials | TryHackMe |
| Real-world machines | HackTheBox |
| Web security focus | PortSwigger Academy |
| Competitive CTF | PicoCTF or RootMe |

### Q: How long does it take to learn this material?
**A:** It depends on your background. Budget:
- **Fundamentals:** 4-8 weeks (casual study)
- **Intermediate topics:** 3-6 months
- **Mastery:** 1-2 years of consistent practice

---

## Tools & Setup

### Q: Do I need special hardware?
**A:** No. A laptop with 8GB RAM and 50GB free space is enough. Use VirtualBox (free) to create a home lab.

### Q: Is Kali Linux required?
**A:** Not for learning fundamentals, but it's helpful for practicing tools. You can use any Linux distro.

### Q: Which tools are most important to learn first?
1. **Nmap** — reconnaissance
2. **Burp Suite** — web testing
3. **Metasploit** — exploitation framework
4. **Linux CLI** — everything uses the command line

---

## Legal & Ethical

### Q: Is it illegal to learn hacking?
**A:** No. Learning is legal. *Using it without authorization is illegal.*

### Q: How do I get authorization to test systems?
**A:** 
- Use **practice platforms** (TryHackMe, HackTheBox, CTF competitions)
- Set up your own **home lab**
- Get **written permission** from system owners before testing their infrastructure
- Work with a company that hired you as a **pentester**

### Q: What if I find a vulnerability on a website?
**A:** Follow **responsible disclosure**:
1. Document what you found (don't exploit further)
2. Contact the company's security team
3. Give them time to patch (typically 90 days)
4. Don't share details publicly until patched
5. Many companies offer bug bounty rewards

### Q: Can I sell the content from this vault?
**A:** It's licensed under MIT, so you can modify and distribute it—but you must include the original license and copyright.

---

## Content

### Q: Is this content accurate?
**A:** It's accurate to the best of my knowledge, but cybersecurity evolves fast. If you find errors:
1. Check the **last updated date** at the top of files
2. Verify with official documentation
3. Submit corrections via pull requests

### Q: Can I contribute?
**A:** Absolutely! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. We welcome:
- New guides & cheat sheets
- Corrections & clarifications
- Updated examples
- Links to better resources

### Q: Why isn't there a guide on [topic]?
**A:** This vault is actively maintained. If you know something that should be here, contribute it!

---

## Troubleshooting

### Q: I'm stuck on a lab/CTF. What do you recommend?
**A:** 
1. **Don't skip fundamentals** — understanding concepts matters more than the answer
2. **Enumerate everything** — scan ports, find services, check for misconfigurations
3. **Use the cheat sheets** — you might have missed a tool or technique
4. **Search online** — community walkthroughs exist for most platforms
5. **Take a break** — fresh perspective often helps

### Q: The commands in the cheat sheets don't work. Why?
**A:** Possible reasons:
- **Different OS** — commands vary between Linux, Windows, macOS
- **Tool not installed** — install the tool first (apt install, brew install, etc.)
- **Wrong permissions** — some commands need sudo
- **Outdated documentation** — tools change. Check the tool's official docs

### Q: How do I report an issue?
**A:** Open a GitHub issue with:
- What you tried
- What happened
- What you expected
- Screenshots (if relevant)
- Your environment (OS, tool versions, etc.)

---

## Advanced

### Q: What's the difference between a cheat sheet and a script?
- **Cheat sheets** = Quick reference, one-liners, options explained
- **Scripts** = Step-by-step methodology, walkthroughs, how to combine tools

### Q: Should I memorize all these commands?
**A:** No. Learn the *concepts*. Keep cheat sheets handy for command syntax.

### Q: How do I stay current with new exploits and tools?
**A:** 
- Follow security blogs & podcasts
- Watch exploit demonstrations
- Participate in CTF competitions
- Join infosec communities (Reddit, Discord, Twitter)
- Read CVE announcements

### Q: What certifications should I pursue?
**A:** Popular paths:
- **CEH** (Certified Ethical Hacker)
- **OSCP** (Offensive Security Certified Professional)
- **Security+** (CompTIA)
- **eJPT** (eLearnSecurity Junior Penetration Tester)

---

## Community

### Q: How can I get help?
- **GitHub Issues** — Report bugs or suggest improvements
- **Discussions** — Ask questions about content
- **Pull Requests** — Contribute improvements

### Q: Can I share CyberVault with others?
**A:** Yes! It's open source. Share the link, fork it, modify it—just include the license.

---

## Still have questions?

1. **Search existing issues** — your question might already be answered
2. **Check related cheat sheets** — the answer might be nearby
3. **Open a GitHub issue** — describe what you're trying to do

---

*Last Updated: July 10, 2026*
