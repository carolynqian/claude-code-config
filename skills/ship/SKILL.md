---
name: ship
description: Update project docs (if present) and commit+push.
---

Update project docs and commit+push. Do the following:

1. Review what has changed since the last commit (or since the last `docs/progress.md` entry, if that file exists) using `git diff` and `git log`.
2. If `docs/progress.md` exists, add a new timestamped entry summarizing what was done, following the existing format. Keep it succinct (1-2 bullet points per change). Skip silently if the file doesn't exist.
3. If `docs/design.md` exists and any design decisions were made, add them (1-2 points per decision, following existing format). Skip silently if the file doesn't exist or there are no new decisions.
4. If the project has a configured linter/formatter (ruff, eslint, prettier, etc.), run it on the changed files and fix any issues. Skip if none is set up.
5. Stage all relevant changes, commit with a clear message, and push.
