---
paths:
  - "**/*.py"
---

# Python Rules

- Follow the Google Python style guide
- Prefer docstrings over inline comments; only use inline comments for non-obvious one-liners
- In docstrings, briefly motivate non-trivial algorithmic or design choices
- Follow SOLID principles:
  - **Single Responsibility**: each function and class should do one thing and have one reason to change
  - **Open/Closed**: open for extension, closed for modification
  - **Liskov Substitution**: subclasses must be substitutable for their parent without breaking behaviour
  - **Interface Segregation**: prefer many small, specific interfaces over one large general one
  - **Dependency Inversion**: depend on abstractions, not concrete implementations
