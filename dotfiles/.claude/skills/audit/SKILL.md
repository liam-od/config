---
name: audit
description: Audit the .claude/ docs against the code. Two jobs — (1) clean up CLAUDE.md, SKILL.md, and agent docs for clarity, conciseness, and accuracy; (2) grow and maintain per-system expert skills so each system has a skill describing how it works, why, and how to modify it. Applies edits directly; proposes new/changed system skills for approval first.
argument-hint: [diff | all | N | path]
---

## Purpose

A codebase is a set of **systems** — coherent units of code or tooling (rendering, lighting,
auth, the build pipeline, the deploy flow) that get modified and added over time. Audit keeps
the `.claude/` docs in step with those systems. It has two jobs:

1. **Keep the docs accurate and lean** — `.claude/` markdown (CLAUDE.md, SKILL.md, agent docs)
   is what a future Claude reads to decide *how to edit this codebase*. It drifts and bloats.
   Audit makes it clear, concise, deduplicated, and true to the current code.
2. **Grow and maintain system skills** — each meaningful system should have a dedicated
   **system skill** at `.claude/skills/<system>/SKILL.md`: an instructional expert that says how
   the system works, why it is built that way, and how to use and modify it. These are
   registered in `CLAUDE.md` so a future agent invokes `Skill: <system>` before touching that
   area. Audit proposes new and changed system skills, then applies the ones the user approves.

Goal of every edit: a future agent reading the file should know exactly how to use and modify
the system it describes. Cut anything that does not serve that. The set of system skills must
stay lean — audit reduces bloat in them as readily as it adds to them.

## Step 1 — Resolve mode and discover scope

`$ARGUMENTS` selects the change signal that drives the audit. Parse it as:

- **`diff` (default, also when `$ARGUMENTS` is empty)** — audit against the current
  working-tree changes only.
- **`all`** (or `full`) — proper check against everything: audit every discovered doc file
  regardless of what changed, and survey the whole codebase for systems with no skill yet.
- **An integer `N`** (or `N` / `HEAD~N`) — audit against the last `N` commits.
- **A path** — restrict the doc-file scope to that path; mode stays `diff` unless one of the
  keywords above is also given.

Enumerate the doc files from the repo root:

```
git ls-files 'CLAUDE.md' '.claude/**/*.md' '**/CLAUDE.md'
```

(or `find . -type f \( -name 'CLAUDE.md' -o -path '*/.claude/*.md' \)` if not a git repo).
If a path argument was given, restrict to it. Exclude `node_modules/`, build dirs.

Also enumerate the **existing system skills** — `.claude/skills/*/SKILL.md` — and read each
one's frontmatter `name` and `description`. This is the list of systems already covered;
Steps 3–4 need it. Locate the repo's `CLAUDE.md` (root preferred) and note whether it has a
`## System Skills` section.

Then capture the change signal for the resolved mode — this is what tells you which doc claims
may have gone stale and which systems may have changed:

- `diff` mode:
  ```
  git diff HEAD                              # staged + unstaged tracked changes
  git ls-files --others --exclude-standard   # untracked file paths
  ```
  Read the diff and the untracked files. If the working tree is clean, tell the user and fall
  back to `all`.
- `N` commits mode: `git diff HEAD~N HEAD` plus `git log --oneline HEAD~N..HEAD`.
- `all` mode: no diff; every discovered doc file gets the full verification pass, and Step 3
  surveys the whole codebase.

For `diff`/`N` modes, note which code paths, symbols, commands, versions, ports, and config
keys changed or were added. Doc claims that touch this changed surface are the highest-priority
targets below.

## Step 2 — Cleanup fan-out (parallel, single message)

Spawn all of these in one message so they run concurrently. Use `general-purpose` agents (they
can edit). Each prompt must be self-contained — the agent has not seen this conversation.
Existing system-skill `SKILL.md` files are in scope here: they get bloat-reduced and
code-checked like any other doc.

### A) One agent per file — fix clarity, conciseness, code accuracy

For each discovered `.md` file, launch one agent with this brief:

- Absolute path to the markdown file.
- In `diff`/`N` modes: the relevant excerpt of the Step 1 change signal (diff + untracked file
  contents). Tell the agent any doc claim that touches a changed/added code path, symbol,
  command, version, port, or config key is the top priority — verify those against the new code
  first. In `all` mode: omit this; the agent verifies every cited reference with equal priority.
- Read the file. Then read every code path, symbol, command, version, port, config key, or file
  reference it cites — verify each one still matches the current tree.
- Apply edits directly to the file. Fix in this priority:
  1. **Claims that no longer match the code** — update to current truth, or delete.
  2. **Bloat** — sentences that restate what the code/naming already says, motivational
     framing, repeated points, hedges. Cut.
  3. **Unclear instructions** — passages that don't say *when they apply* or *what to do*.
     Rewrite to one concrete sentence.
  4. **Rules without a how-to** — every stated decision/convention needs a line on how to apply
     it during a code edit. Add the missing how-to, or delete the rule if it has no actionable
     consequence.
- Preserve frontmatter (`---` block, `name`, `description`, `argument-hint`) unless the
  `description` itself is inaccurate.
- Do not invent claims, examples, or rationale. If a claim cannot be verified, delete it or
  leave a single TODO line — do not guess.
- Do not touch any file other than the one assigned.
- Return a one-line summary of what changed. No detailed report.

### B) One cross-cutting agent — duplication + contradiction

Single agent, given the full list of files. Brief:

- Read all the files. Find:
  - **Duplication**: the same rule/fact stated in two or more files.
  - **Contradiction**: files that disagree (version, path, convention).
- Resolve by editing directly:
  - For duplication, keep the fact in the file closest to the code it governs; in the other
    files, either delete or replace with a one-line pointer.
  - For contradictions, the file closer to the code wins. If the code itself is silent, prefer
    the more recently edited file. Update the loser.
- Do not introduce new content. Only delete, shorten, or redirect.
- Return a one-line summary.

## Step 3 — Identify system-skill candidates

Spawn one `general-purpose` analysis agent (read-only — it must not create or edit anything).
Brief it with:

- The list of existing system skills from Step 1 (each `name` + `description`).
- The input to analyse:
  - `diff`/`N` modes: the Step 1 change signal.
  - `all` mode: instruct it to survey the whole codebase — directory layout, major modules,
    build/deploy/test tooling — and find major systems that have no skill yet.

It classifies what it finds into **candidates**, each tagged with one category:

1. **New system** — a system with no existing skill (introduced by the change, or, in `all`
   mode, long-undocumented) → propose a new `.claude/skills/<system>/SKILL.md`.
2. **Extend existing** — a change materially grows a system that already has a skill → propose
   amending that skill.
3. **No-op** — the change is additive content owned by an existing system and needs no
   instructional update (e.g. one more asset of a kind the system already handles) → record as
   a no-op so the user sees it was considered.
4. **Obsolete** — a system was removed or gutted → propose deleting its skill and its CLAUDE.md
   entry.

A "system" is worth a skill when an agent would benefit from a dedicated expert before working
on it. Scope includes build, deploy, and test infrastructure. A one-off bug fix is not a
system; do not propose skills for trivial changes.

The agent returns a concise candidate list — category, system name, one-line rationale,
proposed action. It creates and edits nothing.

## Step 4 — Propose to user and apply

Present the candidate list to the user. No-ops are shown for transparency only. For each
actionable candidate (categories 1, 2, 4), the user approves, rejects, or edits it. Apply only
the approved ones, in this run:

- **New system** — create `.claude/skills/<system>/SKILL.md` with frontmatter (`name: <system>`
  in kebab-case, an instructional `description`) so it is invocable via the `Skill` tool. Write
  the body instructionally: **how the system works**, **why it is built that way**, **how to
  use and modify it**. Ground every statement in the actual code — no invention, no aspiration.
- **Extend existing** — amend the named system skill with the new behaviour, then re-trim it for
  bloat.
- **Obsolete** — delete the skill directory and remove its CLAUDE.md entry.

Then register every new or changed system skill in the repo's `CLAUDE.md` under a
`## System Skills` section. Add the section if missing; if `CLAUDE.md` itself is missing, create
a minimal one to host it. Each entry is one line — brief, but with a clear *when to invoke*
trigger:

```
## System Skills

Invoke the matching skill before working on the area it covers.

- **lighting** — light sources, shadows, and render passes; see `src/render/light/`.
- **assets** — loading, packing, or adding models/textures/audio.
- **deploy** — the release and deployment pipeline.
```

Keep entries to one line — enough for an agent to decide relevance, not a summary of the skill.

## Step 5 — Done

Print:
- One line per doc file touched: `path — <what changed>`.
- One line per system skill created, amended, or deleted.
- The `CLAUDE.md` registration changes.
- The Step 3 no-op candidates, briefly, so the user sees what was considered and skipped.

If a per-file agent flagged a claim it could not verify and could not safely delete, surface
that single item and ask the user.

## Anti-scope

- Do not touch `.md` files outside `.claude/` and the root `CLAUDE.md` unless an explicit path
  argument selects them.
- Do not edit code to match the docs. Code wins; docs update.
- Do not rewrite a file end-to-end when targeted edits suffice.
- Do not create or delete a system skill without explicit user approval of that candidate.
- A system skill must describe a real system grounded in the current code — never speculative
  or aspirational.
- The Step 2 cleanup agents introduce no new content. Only Step 4 adds content, and only from
  approved candidates verified against real code.
