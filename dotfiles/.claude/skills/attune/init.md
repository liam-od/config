# Attune — init mode (`attune init`)

`attune init` brings a project's `.claude/` directory to the canonical structure. It does
**not** review content against the code or propose new skills — that is `attune all`. Init is
purely structural.

Read `claude-md.md` first — the canonical CLAUDE.md structure and the blank scaffold. Then
pick the mode by what already exists.

## Mode A — no `.claude/CLAUDE.md`: scaffold

1. Create the directory structure if missing: `.claude/` and an empty `.claude/skills/`
   (leave `skills/` empty — `attune all` populates it later).
2. Write `.claude/CLAUDE.md` from the blank scaffold in `claude-md.md`, populating only what
   the repo already states and leaving the rest as the placeholder lines:
   - **About** — one paragraph from the README or the obvious project purpose.
   - **Stack** / **Version Pins** — from the dependency manifests (`package.json`,
     `pyproject.toml`, `Cargo.toml`, `go.mod`, …). Pin only packages whose exact version is
     load-bearing.
   - **Layout** — the major directories and what each holds, from the actual tree.
   - **Quality Gate** — the lint / typecheck / test / build commands from the manifest.
   - **System Skills**, **Context Sources**, **Conventions** — leave the placeholder line.
3. Tell the user to run `attune all` to discover and propose system skills.

## Mode B — `.claude/` already exists: migrate

Restructure the existing `.claude/` into the canonical shape **without losing content**. This
is a one-time structural normalization. Relocate prose; never discard it.

### CLAUDE.md

Reshape `.claude/CLAUDE.md` into the eight canonical sections (see `claude-md.md`):

- Map existing content into **About / Stack / Version Pins / Layout / Conventions / Quality
  Gate**. Convert Stack and Version Pins prose into the canonical tables.
- Cross-cutting rules — rules that govern all feature work, not one system — move to
  **Conventions**.
- A topical section that **duplicates an existing skill** → collapse it; the skill owns that
  content. Drop any `→ Skill:` pointer blocks — the `System Skills` registry replaces them.
- A topical section describing a system with **no skill** → keep its content in the file for
  now and flag it. Never delete unowned content; recommend `attune all` to turn it into a
  skill.
- Build the **System Skills** registry from the skills found in `.claude/skills/`, with the
  `You MUST invoke...` header.
- Ensure **Context Sources** exists (empty `_None._` if nothing is project-wide).

### Skill tree

For every `.claude/skills/*/SKILL.md`:

- Ensure frontmatter has `name` (kebab-case, matching the directory) and
  `user-invocable: false`.
- Ensure a `## Context Sources` section exists (empty `_None._` if none).
- Do not rewrite the body — migration is structural only; `attune all` reviews content.

### Finish

Report what moved, what was flagged (unowned topical sections), and tell the user to run
`attune all` for the content review and to propose skills for the flagged systems.
