---
name: review-diff
description: Review recent git changes for debug code, dead code, import hygiene, and comment quality
argument-hint: [N | --unstaged]
---

## Arguments

Parse `$ARGUMENTS`:
- If empty, review the last **2 commits**.
- If a positive integer `N`, review the last `N` commits.
- If `--unstaged`, review current unstaged working-tree changes (`git diff`).

## Context

Run the appropriate git command to obtain the diff:
- For commits: `git log --oneline -<N>` to confirm scope, then `git diff HEAD~<N>..HEAD`
- For unstaged: `git diff`

Display the scope at the top of your output (e.g. "Reviewing last 2 commits: abc1234, def5678"
or "Reviewing unstaged working-tree changes").

For each file touched by the diff, read the **full current file** to give proper context for
dead code and import checks — the diff alone is insufficient.

## Checks

Perform every check below. For each finding record:
- **Severity**: `must-fix` or `nitpick`
- **File and line**
- **Category**
- A concise description and suggested fix

### 1. Debug artifacts `must-fix`

Look for lines added in the diff (`+` prefix) that are temporary debugging:
- Print/log statements added for debugging (`console.log`, `print(`, `dbg!`, `dump(`,
  `var_dump(`, `pp`, `pry`, `binding.pry`, `debugger;`, `breakpoint()`, etc.)
- Debug flags hardcoded to a non-default value (`DEBUG = true`, `verbose = true`)
- Commented-out blocks of old code (3 or more consecutive commented lines of code)

### 2. Dead code `must-fix` or `nitpick`

Cross-reference the diff with the full current file to find:
- Functions, classes, or variables defined in `+` lines but never referenced anywhere in
  the current file
- Unreachable branches (`if False:`, `if (false)`, code after a `return`/`throw` at the
  same scope level)

### 3. Dangling imports `must-fix`

For every import present in files touched by the diff, check the full current file to confirm
the imported name is actually used. Flag any that are unused.

Do not flag imports used only in type annotations when the file uses `TYPE_CHECKING`.

### 4. Outdated comments `must-fix` or `nitpick`

Look for comments in `+` lines, or in unchanged lines immediately adjacent to changed code,
that:
- Describe logic that no longer matches the surrounding code
- Reference old function names, removed fields, or resolved tickets
- Contain `TODO`/`FIXME`/`HACK`/`XXX` that were not addressed by this diff

### 5. Comment quality `nitpick`

For every comment in `+` lines:
- Flag comments that restate what the code obviously does (e.g. `# increment counter`
  above `counter += 1`)
- Flag comments longer than ~2 sentences that could be trimmed without losing meaning
- Do **not** flag comments that explain *why* a non-obvious decision was made — those
  are valuable and should be kept

## Output format

Start with the scope line, then group findings:

### Must Fix
Bullet list with `file:line — category — description — suggested fix`

### Nitpicks
Same format.

### Clean
For any category with zero findings, state it explicitly (e.g. "Imports: clean").

End with a **2-sentence verdict**: overall quality assessment and whether the diff is ready
to push as-is or needs attention first.
