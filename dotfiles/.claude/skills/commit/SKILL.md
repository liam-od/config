---
name: commit
description: Stage all changes and commit with a generated 1-line commit message based on the diff and recent history
model: sonnet
effort: medium
---

## Steps

1. Run `git diff HEAD` and `git diff --cached` to see all staged and unstaged changes.
2. Run `git log --oneline -10` to see recent commit messages and match the style.
3. Analyse the diff and draft a concise 1-line commit message:
   - Format: `<type>: <short imperative description>` (conventional commits style)
   - Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`
   - Max ~72 characters
   - Match the tone and style of recent commits in the log
4. Run `git add -A` to stage all changes.
5. Run `git commit -m "<message>"` with the drafted message.
6. Output the final commit message and the short commit hash.
