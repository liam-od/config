---
paths:
  - "**/*.py"
---

# Python Rules

- Follow the Google Python style guide
- Prefer docstrings over inline comments; in docstrings, briefly cover purpose and any non-trivial algorithmic or design choices
- **Inline comments** (`#`): only for genuinely non-obvious one-liners; the comment must explain *why*, never restate what the code already says
- **Never** use section-marker comments (`# --- Section ---`, `# ===`, `# ####`, etc.); structure code so it doesn't need a table of contents
- A comment that could be deleted without losing any information should be deleted
- Follow SOLID principles:
  - **Single Responsibility**: each function and class should do one thing and have one reason to change
  - **Open/Closed**: open for extension, closed for modification
  - **Liskov Substitution**: subclasses must be substitutable for their parent without breaking behaviour
  - **Interface Segregation**: prefer many small, specific interfaces over one large general one
  - **Dependency Inversion**: depend on abstractions, not concrete implementations
