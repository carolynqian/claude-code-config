---
name: daily-log
description: Append a day's GitHub commits to the running programming log in Obsidian.
---

Append a summary of the day's GitHub commits to the running programming log. Do the following:

1. Verify `gh` is authenticated (`gh auth status`). If not, stop and ask the user to run `gh auth login`.
2. Determine the target date: today by default, or the date the user specified (e.g. "yesterday", "2026-04-19").
3. Fetch the day's commits authored by the user:
   ```
   gh search commits --author=@me --author-date=YYYY-MM-DD --limit=100 --json repository,sha,commit,url
   ```
   Fall back to `gh api` with the commit-search endpoint if `gh search` is unavailable.
4. If there are no commits, tell the user and stop.
5. Group commits by repository. For each commit, pull the diff stat (`gh api repos/OWNER/REPO/commits/SHA` to get `files`, `stats`) so the summary reflects actual change volume, not just commit messages.
6. Target file (single file for **all** days — do not create a folder):
   `<path-to-your-obsidian-vault>/Programming Log.md`  *(set this to your actual vault path)*
7. Read the file if it exists. The structure is one `## YYYY-MM-DD` section per day, with `### <repo>` subsections inside.
8. Locate the target day's `## YYYY-MM-DD` section:
   - If it doesn't exist, insert a new one — days in reverse chronological order (newest at top) so recent work is visible first.
   - If it exists, read the SHAs already documented *in that day's section only*. Skip commits whose SHAs are already there. Integrate only the new commits into that day's subsections:
     - If a new commit belongs to a repo section already under that day, add bullets there.
     - If it's a new repo for that day, add a `### <repo>` subsection under that day.
9. Even if the same repo has commits on multiple days, keep them under each day's section separately. Never merge commits across days.
10. Per repo subsection (under a given day):
    - Brief description of what changed (1-3 bullets), narrative not raw commit messages
    - Notable decisions or surprises (only if any)
    - Links to commits using markdown: `[\`abc1234\`](commit-url)`
11. End each day's section with a one-line total: `_N commits across M repos_`. Update if you added new commits to an existing day.
12. Report the file path so the user can open it in Obsidian.

Obsidian auto-syncs via Dropbox, so no manual save/push needed.
