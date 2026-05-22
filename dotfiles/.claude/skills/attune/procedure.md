# Attune — shared procedure

Read by the fast path (`fast.md`), the full path (`full.md`), and the `attune-doc-editor`
and `attune-surveyor` agents. It defines doc-file discovery, the per-file edit procedure, and
Steps 3–5.

## Discover the doc files

Doc files are scoped to `.claude/CLAUDE.md` and `.claude/skills/*/SKILL.md` — nothing else
under `.claude/`. Enumerate them from the repo root:

```
git ls-files '.claude/CLAUDE.md' '.claude/skills/*/SKILL.md'
```

(or `find .claude/skills -name SKILL.md` plus `.claude/CLAUDE.md` if not a git repo). If a
path argument was given, restrict to it.

Note whether `.claude/CLAUDE.md` has a `## System Skills` section. The existing system skills
are the `.claude/skills/<system>/SKILL.md` files; Steps 3–4 need to know which systems are
already covered.

## Per-file edit procedure

Whoever edits a doc file — the main agent inline, or a spawned `attune-doc-editor` — does
this:

- Read the file. Then read every code path, symbol, command, version, port, config key, or
  file reference it cites and verify each still matches the current tree. In `diff`/`N` modes,
  verify the claims touching the changed surface first.
- Apply edits directly to the file, in this priority:
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
- **If the file is `.claude/CLAUDE.md`:** ensure it has a `## System Skills` section that
  registers every enumerated `.claude/skills/*/SKILL.md` skill, with the
  "You MUST invoke..." header from the Step 4 template. Add the section if missing, add any
  unregistered skill, and drop entries for skills that no longer exist. This reconciliation
  runs regardless of whether any skill changed this run — it is not gated on Step 4.
  Also check the file against the canonical eight-section structure in `claude-md.md`: flag
  missing sections and structural drift. On a fast run (`diff`/`N`) only note the drift; a
  full `attune all` run is where a structural rework happens — and `attune init` migrates a
  legacy file wholesale.
- **`## Context Sources` section — required in every doc file.** Ensure the file has one; add
  it if missing, empty with a `_None._` placeholder. For each existing entry, confirm the
  library, tool, API, or service it points at is still used by the project; drop dead entries,
  fix malformed locators, and ensure every entry states when to pull it. Verify relevance and
  format only — do not network-check URL liveness.
- A spawned `attune-doc-editor` touches only its assigned file and returns a one-line summary.

## Step 3 — Identify skill and context candidates

Find systems whose skill coverage or context sources Attune should change, each tagged with
one category:

1. **New system** — a system with no existing skill (introduced by the change, or, in `all`
   mode, long-undocumented) → propose a new `.claude/skills/<system>/SKILL.md`.
2. **Extend existing** — a change materially grows a system that already has a skill → propose
   amending that skill.
3. **No-op** — the change is additive content owned by an existing system and needs no
   instructional update (e.g. one more asset of a kind the system already handles) → record as
   a no-op so the user sees it was considered.
4. **Obsolete** — a system was removed or gutted → propose deleting its skill and its CLAUDE.md
   entry.
5. **Context gap** — a system (new or changed) leans on an external library, CLI, API, or
   service that has no entry in any `## Context Sources` section → propose adding one.

A "system" is worth a skill when an agent would benefit from a dedicated expert before working
on it. Scope includes build, deploy, and test infrastructure. A one-off bug fix is not a
system; do not propose skills for trivial changes.

Record each candidate as: category, system name, one-line rationale, proposed action.

How this step runs depends on the path:

- **Fast path (`diff`/`N`)** — the main agent makes this judgement inline from the change
  signal and the list of existing system skills. No subagent. Only consider systems the diff
  itself introduces or changes; do not hunt for unrelated undocumented systems. Context-gap
  detection (category 5) runs inline here too, scoped to the systems the diff touches.
- **Full path (`all`)** — the `attune-surveyor` agent runs this survey across the whole
  codebase (directory layout, major modules, build/deploy/test tooling); `full.md` spawns it.

## Step 4 — Propose to user and apply

Run by the main `attune` skill — never a subagent, because it is interactive.

Present the candidate list to the user. No-ops are shown for transparency only. For each
actionable candidate (categories 1, 2, 4, 5), the user approves, rejects, or edits it. Apply
only the approved ones, in this run:

- **New system** — create `.claude/skills/<system>/SKILL.md` with frontmatter — `name: <system>`
  (kebab-case), an instructional `description`, and `user-invocable: false` (system skills are
  agent-invoked only, never shown in the user's `/` menu; the agent still auto-invokes them).
  Write the body instructionally: **how the system works**, **why it is built that way**,
  **how to use and modify it**. Include a `## Context Sources` section (empty with a `_None._`
  placeholder if the system needs none). Ground every statement in the actual code — no
  invention, no aspiration.
- **Extend existing** — amend the named system skill with the new behaviour, then re-trim it for
  bloat.
- **Obsolete** — delete the skill directory and remove its CLAUDE.md entry.
- **Context gap** — add the proposed entry to the `## Context Sources` section of the relevant
  file: the system's skill for a system-specific source, `CLAUDE.md` for a project-wide one.
  Before proposing a `context7` entry, resolve the real library ID via the context7 resolve
  tool so the user approves a concrete locator, not a guess.

Then register every new or changed system skill in `.claude/CLAUDE.md` under a
`## System Skills` section. Add the section if missing; if `CLAUDE.md` itself is missing, create
a minimal one to host it. Each entry is one line — brief, but with a clear *when to invoke*
trigger:

```
## System Skills

You MUST invoke the matching skill before working on the area it covers — including before
finalizing a plan that touches it. In plan mode, the Explore/Plan subagent does not see this
file or these skills; once exploration reveals which systems are in scope, invoke their skills
before writing the plan. Do not act on the topical summaries in this file alone.

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

If an edit flagged a claim that could not be verified and could not safely be deleted, surface
that single item and ask the user.
