---
name: catchup
description: Review the current repo's state so the user can get up to speed quickly.
---

Review the project state so I can get up to speed quickly. Do the following:

1. If `docs/progress.md` exists, read it. If `docs/design.md` exists, read it. Skip silently if missing.
2. Check `git log --oneline -20` for recent commits and `git status` for uncommitted work.
3. Survey the repo: read `README.md` if present, then list the top-level directory to understand the layout. Briefly inspect any directories that look central to the project (e.g. `src/`, `config/`, `results/`, or whatever the project uses).
4. Summarize: current state, what was done last, and likely next steps.

Keep the summary concise — bullet points, not paragraphs.
