# CLAUDE.md (user-level)

Global guidelines that apply to every project. Project-level `CLAUDE.md` files override these when they conflict.

## Style

- Keep responses concise and direct. Skip unnecessary preamble.
- Use markdown link syntax for file references (e.g. `[filename.py:42](path/filename.py#L42)`).

## Code

- Prefer short, minimal code. Cut fluff on iteration.
- Keep comments succinct

## System config maintenance

When you modify anything under `~/.claude/` (`settings.json`, `CLAUDE.md`, `skills/*`), mirror the change to the config repo and commit+push. The repo is the canonical source; remote machines install from it via `bootstrap.sh`, so local edits that skip the repo silently disappear on the next pod bootstrap.

If the config repo isn't cloned on the current machine (e.g. remote pod), flag the change to the user so they can sync it later.

When adding a new skill, also add a `curl` line for it to `bootstrap.sh` so fresh machines pull it.
