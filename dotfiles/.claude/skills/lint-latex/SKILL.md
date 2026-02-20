---
name: lint-latex
description: Run chktex on a LaTeX file and diagnose errors, warnings, and messages in plain English
argument-hint: <filename> [section name]
---

## Arguments

Parse `$ARGUMENTS` as follows:
- The first whitespace-delimited token is the **filename**.
- Everything after the first token (if present) is the **section filter** — the exact heading
  text of a `\section{}`, `\subsection{}`, or `\subsubsection{}` to restrict the output to.
- If no section filter is given, diagnose the entire file.

## Task

### 1. Run chktex

Run: `chktex <filename> 2>&1`

Collect all warnings from the output. Ignore the summary lines and copyright header.

### 2. Read the file

Read the full file to get line content and to locate section boundaries.

If a section filter was given, find the matching `\section{}`, `\subsection{}`, or
`\subsubsection{}` heading and determine its line range (from that heading up to but not
including the next heading at the same or higher level).
Filter the warnings list to only those whose line numbers fall within that range. If no matching
heading is found, inform the user and stop.

### 3. Classify each diagnostic

For each diagnostic (error, warning, or message), classify it as one of:
- **False positive** — a known chktex quirk that does not reflect a real problem (e.g. W1 on
  `algpseudocode` commands like `\State`, `\EndFor`, `\For`)
- **Legitimate** — a real issue worth fixing

### 4. Report

If there are no legitimate diagnostics (only false positives, or nothing at all), say so clearly
and briefly explain any false positives present.

Otherwise, report legitimate diagnostics grouped by severity in this order: **errors** first,
then **warnings**, then **messages**. For each:
- Show the severity, diagnostic number, line number, and the offending line
- Explain in plain English what the problem is and why it matters
- Give the concrete fix (show the corrected LaTeX)

Then list any **false positives** in a separate section at the end, briefly noting why they are
safe to ignore or suppress with `% chktex <N>`.

If no filename is given, ask which file to lint.
