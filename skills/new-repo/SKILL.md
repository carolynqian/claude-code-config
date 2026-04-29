---
name: new-repo
description: Create a new private GitHub repo from the current directory and push.
---

Create a new private GitHub repo from the current directory and push it. Do the following:

1. Verify `gh` is authenticated (`gh auth status`). If not, stop and ask the user to run `gh auth login`.
2. If the directory is not yet a git repo, run `git init -b main`.
3. If there are no commits yet, stage files (`git add .`) and create an initial commit. Before staging, scan the files for obvious sensitive patterns (`.env`, `credentials*`, `*.pem`, `id_rsa*`, `*.key`) — if any are about to be staged, pause and ask the user to confirm or add them to `.gitignore`.
4. Determine the repo name — default to the current directory's basename. If the user passed a name as an argument, use that instead.
5. Run `gh repo create <name> --private --source=. --push`.
6. Report the resulting repo URL.

Repos are private by default. Only use `--public` if the user explicitly asks.
