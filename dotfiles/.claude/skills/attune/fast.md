# Attune — fast path (`diff` and `N` modes)

Reached from `SKILL.md` for `diff` (default) and `N` modes. First follow `procedure.md` →
**Discover the doc files**.

## Capture the change signal

This is what tells you which doc claims may have gone stale and which systems may have
changed:

- `diff` mode:
  ```
  git diff HEAD                              # staged + unstaged tracked changes
  git ls-files --others --exclude-standard   # untracked file paths
  ```
  Read the diff and the untracked files. If the working tree is clean, tell the user and fall
  back to the full path (`full.md`).
- `N` commits mode: `git diff HEAD~N HEAD` plus `git log --oneline HEAD~N..HEAD`.

Note which code paths, symbols, commands, versions, ports, and config keys changed or were
added — this is the surface that routing and verification key off.

## The fast path

The diff is usually small and touches few systems, so do not read every doc file or fan out
blind. Route first, then edit only what the diff implicates.

1. **Route.** Do *not* read the skill bodies yet. Read only `.claude/CLAUDE.md` (its
   `## System Skills` section and any other claims) and the frontmatter `description` of each
   `.claude/skills/*/SKILL.md`. From the change signal plus those descriptions, decide which
   doc files the diff makes actionable — a file is actionable if the diff could have
   invalidated a claim it makes (a cited code path, symbol, command, version, port, config key,
   or described behaviour), or if it documents a system the diff materially changed. Include
   `CLAUDE.md` itself if the diff touches anything it references. The diff is the primary
   signal; descriptions only help you guess which skill owns the changed surface.
2. **Always reconcile required sections.** Independent of the diff, on every run:
   - `.claude/CLAUDE.md` must have a `## System Skills` section listing every enumerated skill
     — if it is missing or incomplete, treat `CLAUDE.md` as actionable.
   - `.claude/CLAUDE.md` and every `.claude/skills/*/SKILL.md` must have a `## Context Sources`
     section. `grep -L '## Context Sources'` the doc files to find any missing it, and add the
     section (empty, with a `_None._` placeholder) to each. This structural insert is a minimal
     edit — it does not count toward the file-count threshold in step 4 and needs no content
     review of an otherwise-untouched file.
3. **Nothing implicated.** If no doc file is actionable, report that and skip to Step 3.
4. **Edit the actionable files**, following the **Per-file edit procedure** in `procedure.md`:
   - **≤2 files** — edit them inline in this agent.
   - **3+ files** — spawn one `attune-doc-editor` subagent per file in a single message (they
     run concurrently). Each spawn prompt is self-contained: the absolute path of the target
     doc file, the absolute path of attune's `procedure.md`, and the relevant excerpt of the
     change signal.
5. **Consistency check.** If 2 or more files were edited, re-read just those files and check
   they did not introduce a contradiction or duplicate a fact between them. Resolve by editing
   the file further from the code it governs.

The fast path skips the whole-codebase duplication sweep and the system survey — `attune all`
covers those. It will not catch pre-existing drift in doc files the diff does not touch; run
`attune all` periodically for that.

## Then

- **Step 3** — run `procedure.md` → Step 3 inline (fast-path note): judge skill and context
  candidates from the change signal, no subagent, scoped to systems the diff touches.
- **Steps 4–5** — run `procedure.md` → Step 4 (propose to user and apply) and Step 5 (done).
