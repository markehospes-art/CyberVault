#!/usr/bin/env python3
"""
Password Strength Checker - EDUCATIONAL

Analyzes password security based on best practices.
Shows what makes a strong password and how to improve weak ones.

Purpose: Educate users on password security principles
License: Educational Use Only
"""

import re
import sys

# ============================================================================
# CONSTANTS - PASSWORD REQUIREMENTS
# ============================================================================

# Minimum requirements for each strength level
MIN_LENGTH = 8
STRONG_LENGTH = 12
VERY_STRONG_LENGTH = 16

# Regular expressions for pattern matching
PATTERN_LOWERCASE = re.compile(r'[a-z]')
PATTERN_UPPERCASE = re.compile(r'[A-Z]')
PATTERN_DIGIT = re.compile(r'\d')
PATTERN_SPECIAL = re.compile(r'[!@#$%^&*()_+\-=\[\]{};:'",.<>?/\\|`~]')
PATTERN_SPACE = re.compile(r'\s')

# Common weak passwords to check against
COMMON_WEAK_PASSWORDS = {
    'password', '123456', '12345678', 'qwerty', 'abc123',
    'monkey', '1234567', 'letmein', 'trustno1', 'dragon',
    'baseball', '111111', 'iloveyou', 'master', 'sunshine',
    'ashley', 'bailey', 'shadow', '123123', '654321',
    'superman', 'qazwsx', 'michael', 'football', 'pass',
}

# ============================================================================
# CLASSES - PASSWORD ANALYSIS
# ============================================================================

class PasswordAnalyzer:
    """
    Analyzes password strength and provides feedback.
    """
    
    def __init__(self, password):
        """
        Initialize with a password to analyze.
        
        Args:
            password (str): The password to analyze
        """
        self.password = password
        self.length = len(password)
        self.has_lowercase = bool(PATTERN_LOWERCASE.search(password))
        self.has_uppercase = bool(PATTERN_UPPERCASE.search(password))
        self.has_digit = bool(PATTERN_DIGIT.search(password))
        self.has_special = bool(PATTERN_SPECIAL.search(password))
        self.has_space = bool(PATTERN_SPACE.search(password))
        self.score = 0
        self.issues = []
    
    def calculate_score(self):
        """
        Calculate password strength score (0-100).
        
        Returns:
            int: Score from 0 to 100
        """
        self.score = 0
        self.issues = []
        
        # LENGTH CHECKS (0-30 points)
        if self.length == 0:
            self.issues.append("Password is empty")
        elif self.length < MIN_LENGTH:
            self.issues.append(f"Too short (< {MIN_LENGTH} characters)")
            self.score += 10 * (self.length / MIN_LENGTH)
        elif self.length >= VERY_STRONG_LENGTH:
            self.score += 30  # Bonus for very long passwords
        elif self.length >= STRONG_LENGTH:
            self.score += 25
        else:
            self.score += 15
        
        # CHARACTER VARIETY (0-40 points)
        variety_count = 0
        if self.has_lowercase:
            self.score += 10
            variety_count += 1
        else:
            self.issues.append("Missing lowercase letters")
        
        if self.has_uppercase:
            self.score += 10
            variety_count += 1
        else:
            self.issues.append("Missing uppercase letters")
        
        if self.has_digit:
            self.score += 10
            variety_count += 1
        else:
            self.issues.append("Missing numbers")
        
        if self.has_special:
            self.score += 10
            variety_count += 1
        else:
            self.issues.append("Missing special characters")
        
        # SEQUENCE & PATTERN CHECKS (0-30 points)
        if not self._has_sequential_characters():
            self.score += 15
        else:
            self.issues.append("Contains sequential characters (abc, 123)")
        
        if not self._has_repeated_characters():
            self.score += 15
        else:
            self.issues.append("Contains too many repeated characters")
        
        # COMMON PASSWORDS CHECK (penalty)
        if self.password.lower() in COMMON_WEAK_PASSWORDS:
            self.score = 10  # Very low score for common passwords
            self.issues.insert(0, "This is a commonly used weak password!")
        
        # Ensure score is between 0-100
        self.score = max(0, min(100, int(self.score)))
        
        return self.score
    
    def _has_sequential_characters(self):
        """
        Check if password contains sequential characters (abc, 123, etc).
        
        Returns:
            bool: True if sequential patterns found
        """
        sequential_patterns = [
            'abc', 'bcd', 'cde', 'def', 'efg', 'fgh', 'ghi', 'hij', 'ijk',
            '123', '234', '345', '456', '567', '678', '789',
        ]
        
        password_lower = self.password.lower()
        return any(pattern in password_lower for pattern in sequential_patterns)
    
    def _has_repeated_characters(self):
        """
        Check if password has too many repeated characters (aaa, 222).
        
        Returns:
            bool: True if excessive repetition found
        """
        for char in set(self.password):
            if self.password.count(char) >= 3:
                return True
        return False
    
    def get_strength_label(self):
        """
        Get human-readable strength label.
        
        Returns:
            str: Strength label (Very Weak, Weak, Fair, Good, Strong, Very Strong)
        """
        if self.score < 20:
            return "Very Weak"
        elif self.score < 40:
            return "Weak"
        elif self.score < 60:
            return "Fair"
        elif self.score < 80:
            return "Good"
        elif self.score < 95:
            return "Strong"
        else:
            return "Very Strong"
    
    def get_color_code(self):
        """
        Get ANSI color code for terminal display.
        
        Returns:
            str: ANSI color code
        """
        if self.score < 40:
            return "\033[91m"  # Red
        elif self.score < 60:
            return "\033[93m"  # Yellow
        elif self.score < 80:
            return "\033[92m"  # Green
        else:
            return "\033[94m"  # Blue
    
    def print_report(self):
        """
        Print a detailed password strength report.
        """
        # Calculate score
        self.calculate_score()
        
        # Get formatting codes
        color = self.get_color_code()
        reset = "\033[0m"
        
        # Header
        print("\n" + "="*70)
        print("PASSWORD STRENGTH ANALYZER - EDUCATIONAL")
        print("="*70)
        
        # Password info (masked)
        print(f"\n[*] Password length: {self.length} characters")
        print(f"[*] Character composition:")
        print(f"    - Lowercase letters: {'✓' if self.has_lowercase else '✗'}")
        print(f"    - Uppercase letters: {'✓' if self.has_uppercase else '✗'}")
        print(f"    - Digits: {'✓' if self.has_digit else '✗'}")
        print(f"    - Special characters: {'✓' if self.has_special else '✗'}")
        
        # Strength score
        print(f"\n[*] Strength Score: {color}{self.score}/100{reset}")
        print(f"[*] Strength Level: {color}{self.get_strength_label()}{reset}")
        
        # Progress bar
        bar_length = 50
        filled = int(bar_length * self.score / 100)
        bar = "█" * filled + "░" * (bar_length - filled)
        print(f"[*] [{color}{bar}{reset}]")
        
        # Issues and recommendations
        if self.issues:
            print(f"\n[!] Issues found:")
            for issue in self.issues:
                print(f"    - {issue}")
        else:
            print(f"\n[+] No issues found! This is a strong password.")
        
        # Recommendations
        print(f"\n[*] Recommendations:")
        if self.length < VERY_STRONG_LENGTH:
            print(f"    - Make password longer (aim for {VERY_STRONG_LENGTH}+ characters)")
        if not self.has_uppercase:
            print(f"    - Add uppercase letters (A-Z)")
        if not self.has_lowercase:
            print(f"    - Add lowercase letters (a-z)")
        if not self.has_digit:
            print(f"    - Add numbers (0-9)")
        if not self.has_special:
            print(f"    - Add special characters (!@#$%^&*)")
        if self.has_space:
            print(f"    - Avoid spaces in passwords")
        
        print("\n" + "="*70 + "\n")

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def get_password_input():
    """
    Securely get password input from user (masked input).
    
    Returns:
        str: Password entered by user
    """
    try:
        import getpass
        password = getpass.getpass("Enter password to analyze (will not be displayed): ")
        return password
    except ImportError:
        # Fallback if getpass not available
        password = input("Enter password to analyze: ")
        return password

def print_usage():
    """
    Display usage instructions.
    """
    print("\nUsage: python3 password_strength_checker.py [password]")
    print("\nExamples:")
    print("  python3 password_strength_checker.py                        # Interactive mode")
    print("  python3 password_strength_checker.py MyP@ssw0rd123          # Check specific password")
    print("  python3 password_strength_checker.py -h                     # Show this help\n")

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

if __name__ == "__main__":
    # Handle help flag
    if len(sys.argv) > 1 and sys.argv[1] in ["-h", "--help"]:
        print_usage()
        sys.exit(0)
    
    # Get password from arguments or prompt user
    if len(sys.argv) > 1:
        password = sys.argv[1]
    else:
        password = get_password_input()
    
    # Analyze and display report
    if password:
        analyzer = PasswordAnalyzer(password)
        analyzer.print_report()
    else:
        print("[!] No password provided.")
        print_usage()
