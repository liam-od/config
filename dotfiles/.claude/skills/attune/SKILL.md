---
name: attune
description: Attune the .claude/ docs to the code. Two jobs — (1) clean up CLAUDE.md and skill docs for clarity, conciseness, accuracy, and context sources; (2) grow and maintain per-system expert skills so each system has a skill describing how it works, why, and how to modify it. Applies edits directly; proposes new/changed system skills for approval first.
argument-hint: [diff | all | N | path | init]
---

## Purpose

A codebase is a set of **systems** — coherent units of code or tooling (rendering, lighting,
auth, the build pipeline, the deploy flow) that get modified and added over time. Attune keeps
the `.claude/` docs in step with those systems. It has two jobs:

1. **Keep the docs accurate and lean** — `.claude/CLAUDE.md` and the skill docs are what a
   future Claude reads to decide *how to edit this codebase*. They drift and bloat. Attune
   makes them clear, concise, deduplicated, and true to the current code.
2. **Grow and maintain system skills** — each meaningful system should have a dedicated
   **system skill** at `.claude/skills/<system>/SKILL.md`: an instructional expert that says how
   the system works, why it is built that way, and how to use and modify it. These are
   registered in `CLAUDE.md` so a future agent invokes `Skill: <system>` before touching that
   area. Attune proposes new and changed system skills, then applies the ones the user approves.

Goal of every edit: a future agent reading the file should know exactly how to use and modify
the system it describes. Cut anything that does not serve that. The set of system skills must
stay lean — Attune reduces bloat in them as readily as it adds to them.

**Context sources.** `CLAUDE.md` and every skill MUST have a `## Context Sources` section —
structured pointers to authoritative external context an agent should pull before non-trivial
work, because training data lags. The section is required even when empty: a system with no
external source carries the heading with a single `_None._` placeholder, so a future agent
sees it was considered. Each real entry is one line: a **type tag**, a **locator**, and
**when to pull it**.

```
## Context Sources

Pull the authoritative source before non-trivial work — training data lags.

- **context7** `/babylonjs/documentation` — materials, MaterialPlugin hooks, ShadowGenerator.
- **url** https://example.com/spec — the wire-protocol spec.
- **cmd** `cj --help` — current CLI subcommands and flags; do not trust docs for CLI surface.
```

Types: `context7` (a context7 library ID), `url` (a web page or spec), `cmd` (a command an
agent runs to get *live* state instead of stale docs). Project-wide sources live in
`CLAUDE.md`; a source specific to one system lives in that system's skill, scoped tight (the
`lighting` skill points at Babylon's *materials* docs, not all of Babylon). Attune keeps these
accurate and flags **context gaps** — a system leaning on an external library, CLI, API, or
service with no source declared.

## Resolve mode and dispatch

This `SKILL.md` is the router. `$ARGUMENTS` selects the mode; read and follow the matching
stream file from this skill's directory, then act on it:

- **`diff` (default, also when `$ARGUMENTS` is empty)** — check the current working-tree
  changes → read and follow **`fast.md`**.
- **An integer `N`** (or `HEAD~N`) — check the last `N` commits → read and follow **`fast.md`**.
- **`all`** (or `full`) — proper check against everything → read and follow **`full.md`**.
- **A path** — restrict the doc-file scope to that path; mode stays `diff` unless a keyword
  above is also given → read and follow **`fast.md`**.
- **`init`** — scaffold a new `.claude/CLAUDE.md`, or migrate an existing `.claude/` tree to
  the canonical structure → read and follow **`init.md`**.

`fast.md` and `full.md` both also use **`procedure.md`** — the shared doc-file discovery,
per-file edit procedure, and Steps 3–5. Read the stream file fully before acting; it tells
you when to read `procedure.md`.

## Anti-scope

- Attune's doc scope is exactly `.claude/CLAUDE.md` and `.claude/skills/*/SKILL.md`. Do not
  touch any other `.md` file unless an explicit path argument selects it.
- Do not edit code to match the docs. Code wins; docs update.
- Do not rewrite a file end-to-end when targeted edits suffice.
- Do not create or delete a system skill without explicit user approval of that candidate.
- A system skill must describe a real system grounded in the current code — never speculative
  or aspirational.
- Editing introduces no new content beyond what Step 4 adds from approved candidates verified
  against real code.
