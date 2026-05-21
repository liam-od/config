# Attune — full path (`all` mode)

Reached from `SKILL.md` for `all` (or `full`) mode. First follow `procedure.md` →
**Discover the doc files**.

There is no diff: every doc file gets the full verification pass, and the survey covers the
whole codebase.

## Fan out

Spawn all of the following in one message so they run concurrently. Each spawn prompt must be
self-contained — the agent has not seen this conversation.

- **One `attune-doc-editor` per doc file** — each spawn prompt gives the absolute path of the
  target doc file, the absolute path of attune's `procedure.md`, and the instruction that in
  `all` mode there is no diff, so it verifies every cited reference with equal priority.

- **One cross-cutting `general-purpose` agent** for duplication and contradiction, given the
  full doc-file list. Brief it:
  - Read all the files. Find **duplication** (the same rule/fact in two or more files) and
    **contradiction** (files that disagree on a version, path, or convention).
  - Resolve by editing directly. For duplication, keep the fact in the file closest to the
    code it governs; elsewhere delete it or replace it with a one-line pointer. For
    contradictions, the file closer to the code wins; if the code is silent, prefer the more
    recently edited file. Update the loser.
  - Do not introduce new content. Only delete, shorten, or redirect. Return a one-line summary.

- **One `attune-surveyor`** — spawn prompt gives the absolute path of attune's `procedure.md`
  and the list of existing system skills (each `name` + `description`). It runs `procedure.md`
  → Step 3 across the whole codebase and returns the candidate list. It is read-only —
  enforced by its agent definition.

## Then

Collect the agents' returns. Then, in this main skill:

- **Step 4** — run `procedure.md` → Step 4: present the surveyor's candidate list to the user,
  get approval, and apply. This is interactive and stays in the main skill, never a subagent.
- **Step 5** — run `procedure.md` → Step 5: print the summary.
