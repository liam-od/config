---
name: merge
description: Rebase the current branch onto a target (default develop), resolve conflicts, then open and merge a PR via gh for a linear history
argument-hint: [target-branch]
---

## Arguments

Parse `$ARGUMENTS`:
- If empty, the target branch is `develop`.
- Otherwise, the target branch is the given name.

## Context

1. Run `git rev-parse --abbrev-ref HEAD` to get the current (feature) branch. Abort if it is
   the target branch itself, or if it is `main`/`master`.
2. Run `git status --porcelain`. If the working tree is dirty, stop and tell the user to
   commit or stash first — do not stash for them.
3. Run `git fetch origin` to update remote refs.

## Rebase

Rebase the feature branch onto the latest target so history stays linear:

```
git rebase origin/<target>
```

If the rebase completes cleanly, skip to **Push**.

## Resolve conflicts

For each conflict the rebase stops on:

1. Run `git diff` (or read the conflicted files) to see the `<<<<<<<` / `=======` / `>>>>>>>`
   markers.
2. Resolve each conflict on its merits:
   - **Additive conflicts** (both sides add new, independent lines — imports, list/enum
     entries, new functions, config keys): keep **both** sides. This is the common case.
   - **Genuine conflicts** (both sides edit the same logic): read the surrounding code,
     understand each intent, and merge them so neither change is lost. If intent is
     ambiguous, stop and ask the user.
3. After resolving every file in the current step: `git add <files>` then
   `git rebase --continue`.
4. Repeat until the rebase finishes.

Never run `git rebase --skip` — it silently drops a commit.

## Push

Push the rebased feature branch. Rebasing rewrote its commits, so a force is required:

```
git push --force-with-lease origin <feature-branch>
```

## Open and merge the PR

The PR is the browsable record — the user reviews it on GitHub but takes no action.

1. Check for an existing open PR: `gh pr view <feature-branch> --json number,url`.
2. If none exists, create one:
   ```
   gh pr create --base <target> --head <feature-branch> --title "<title>" --body "<body>"
   ```
   - Title: match the style of recent commits (`git log --oneline -10`).
   - Body: a short summary of the changes, plus a one-line note of any conflicts resolved
     during the rebase.
3. Merge it, rebasing to keep history linear (do **not** delete the branch):
   ```
   gh pr merge <feature-branch> --rebase
   ```
   - If `gh` reports required status checks are still pending, retry with `--auto` so it
     merges automatically once checks pass: `gh pr merge <feature-branch> --rebase --auto`.

## Sync local

Bring the local target branch up to date with the merged result. The local target may
carry its own un-pushed commits (commits made directly onto `develop`), so rebase rather
than fast-forward — `git pull --ff-only` aborts on divergence:

```
git fetch origin
git checkout <target>
git pull --rebase origin <target>
```

After the rebase, if the local target is ahead of `origin/<target>` (it had local-only
commits), push them so origin matches:

```
git rev-list --count origin/<target>..<target>   # >0 means local commits to push
git push origin <target>                          # only if the count is >0
```

Then return to the feature branch:

```
git checkout <feature-branch>
```

Do not touch `main` — the user opens the `<target>` → `main` PR manually.

## Output

Always surface every conflict you resolved so the user can review it on the PR.

Report:
- Feature branch, target branch, and number of commits rebased.
- A **Conflicts resolved** section — one entry per conflicted file:
  - `file:line — additive | merged`
  - For each, a short fenced snippet of the resolved region showing what you kept. Keep
    `additive` snippets to a few lines; show `merged` regions in full since those required
    judgement.
  - If there were no conflicts, say so explicitly (`Rebased cleanly, no conflicts`).
- The PR URL, and whether it merged immediately or was set to auto-merge on checks.
- If the local target had its own un-pushed commits, say so and report that they were
  rebased onto the merged result and pushed.
- The final state: `<target>` is updated and ready for a manual PR to `main`.
