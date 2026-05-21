# Attune — canonical CLAUDE.md structure

Read this whenever you create or edit `.claude/CLAUDE.md` — from `init.md` (to scaffold a new
one) or from `procedure.md`'s per-file edit procedure (to check an existing one).

`CLAUDE.md` is an **index**, not a manual: it states what the project is, what it is built on,
and which skill to load for an area. How a system works belongs in that system's skill, never
here.

It has eight sections, in this order:

1. **About** — the title plus one paragraph: what the project is, what it is for, and the
   single most important constraint or goal.
2. **Stack** — a table of the technology choices (`Layer | Choice | Notes`).
3. **Version Pins** — a table of the packages whose *exact* version is load-bearing
   (`Package | Pin | Why`). Not every dependency.
4. **Layout** — the major directories and what each holds; orientation only — detailed wiring
   belongs in a skill.
5. **System Skills** — the skill registry: the `You MUST invoke...` header plus one line per
   skill. Reconciled on every run (see `procedure.md`'s per-file edit procedure).
6. **Context Sources** — project-wide authoritative external sources; required even when
   empty (`_None._`).
7. **Conventions** — project-wide rules that belong to no single system. System-specific
   rules live in that system's skill.
8. **Quality Gate** — the commands to run before reporting any work done.

When editing an existing `CLAUDE.md`, check it against this structure: flag missing sections
and structural drift (a sprawling topical section that should be a skill, content that
belongs in `Conventions`, etc.). On a **fast run** (`diff`/`N`) only note the drift to the
user — do not aggressively restructure. A full **`attune all`** run is the place for a
structural rework.

## Blank scaffold

`init` mode writes a new `.claude/CLAUDE.md` from this template, populating only what the repo
already states and leaving the rest as the placeholder lines:

````
# <Project Name>

<One paragraph: what this project is, what it is for, and the single most important
constraint or goal. No more.>

## Stack

| Layer | Choice | Notes |
|---|---|---|
| | | |

## Version Pins

Only packages whose exact version is load-bearing — not every dependency.

| Package | Pin | Why |
|---|---|---|
| | | |

## Layout

<The major directories and what each holds — a short tree or bullet list, orientation only.
Detailed wiring belongs in a skill.>

## System Skills

You MUST invoke the matching skill before working on the area it covers — do not act on the
summaries in this file alone.

_None yet — run `/attune all` to discover and propose system skills._

## Context Sources

Pull the authoritative source before non-trivial work — training data lags.

_None yet._

## Conventions

Project-wide rules that belong to no single system. System-specific rules live in that
system's skill.

_None yet._

## Quality Gate

Run before reporting any work done; all must pass.

_None yet._
````
