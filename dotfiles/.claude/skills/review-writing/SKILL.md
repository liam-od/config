---
name: review-writing
description: Review LaTeX writing against the project writing rules
argument-hint: <filename> [section name]
---

## Arguments

Parse `$ARGUMENTS` as follows:
- The first whitespace-delimited token is the **filename**.
- Everything after the first token (if present) is the **section filter** — the exact heading text of a `\section{}`, `\subsection{}`, or `\subsubsection{}` to restrict the review to.
- If no section filter is given, review the entire file.

## Context

- Timestamp: !`date +%d-%m-%Y_%H%M`
- Output file: `.claude/reviews/<stem>[_<section>]_<timestamp>.md` where `<stem>` is the filename with any directory prefix and `.tex` extension removed; `<section>` is the section filter with spaces replaced by hyphens, omitted if no section filter was given; and `<timestamp>` is taken from the Timestamp line above.

## Writing rules

!`cat ~/.claude/writing-rules.md`

## Task

Read the file identified by the filename argument.

If a section filter was given, locate the matching `\section{}`, `\subsection{}`, or `\subsubsection{}` heading and review only the content from that heading up to (but not including) the next heading at the same or higher level. If no matching heading is found, inform the user and stop.

If no section filter was given, review the entire file.

Review the selected content against every writing rule above.

For each violation found:
- Quote the offending sentence or phrase
- State which rule is broken (by number and short description)
- Suggest a corrected version

Group violations by rule number, in ascending order.
At the end, provide a brief summary of the most frequent issues.

After completing the review, write the full review output to the output file path
given in the Context section above AND display it in full to the user, using the format:

```
# Writing Review: <filename> [— <section filter>]
Date: <timestamp from Context>

<full review content>
```

If no filename is given, ask which file to review.
