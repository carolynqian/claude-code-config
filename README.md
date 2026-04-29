# claude-code-config

Portable [Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration: user-level settings, global `CLAUDE.md` guidelines, and custom skills (slash commands). One `bootstrap.sh` sets up a fresh machine or remote GPU in seconds.

## What's in the box

```
settings.json          # permissions, effort level, cleanup period
CLAUDE.md              # global behavioral guidelines (conciseness, code style, config sync)
CLAUDE.md.template     # starter CLAUDE.md to drop into new projects
bootstrap.sh           # one-liner installer — pulls everything into ~/.claude/
skills/
  catchup/             # /catchup — summarize repo state (git log, docs, layout)
  ship/                # /ship — update docs + commit + push
  new-repo/            # /new-repo — init + create private GitHub repo
  daily-log/           # /daily-log — aggregate GitHub commits into an Obsidian log
  generate-anki/       # /generate-anki — create Anki flashcards from lecture notes
    anki-card-style-guide.md   # detailed style guide with 11 reference examples
```

## Skills overview

| Skill | What it does |
|-------|-------------|
| `/catchup` | Reads `progress.md`, `design.md`, recent git history, and repo layout to produce a quick status summary |
| `/ship` | Updates project docs (`progress.md`, `design.md`), runs linters, commits, and pushes |
| `/new-repo` | Initializes a git repo, scans for secrets, creates a private GitHub repo via `gh`, and pushes |
| `/daily-log` | Fetches the day's GitHub commits (`gh search commits`), groups by repo with diff stats, appends to an Obsidian programming log |
| `/generate-anki` | Reads lecture notes, checks for duplicates via AnkiConnect, generates Anki cards following a [detailed style guide](skills/generate-anki/anki-card-style-guide.md) with cloze design principles and 11 reference examples |

## Setup

### Quick install (remote machine / pod)

```bash
export GITHUB_TOKEN=ghp_...                        # PAT with read access to this repo
export CLAUDE_CONFIG_REPO=yourname/claude-code-config
export GIT_USER_NAME="Your Name"                   # optional
export GIT_USER_EMAIL="you@example.com"            # optional

curl -sfL -H "Authorization: token $GITHUB_TOKEN" \
  https://raw.githubusercontent.com/$CLAUDE_CONFIG_REPO/main/bootstrap.sh | bash
```

### Local clone

```bash
git clone https://github.com/yourname/claude-code-config.git
cd claude-code-config && ./bootstrap.sh
```

## Customizing

1. **Fork this repo** and update `CLAUDE_CONFIG_REPO` to point to your fork.
2. Edit `CLAUDE.md` for your global preferences (coding style, response format, etc.).
3. Drop `CLAUDE.md.template` into new projects and fill in the `<placeholders>`.
4. Add your own skills under `skills/<name>/SKILL.md` — Claude Code auto-discovers them as slash commands.
5. Add a `curl` line to `bootstrap.sh` for each new skill so fresh machines pick it up.

## Design choices

- **Config-as-code**: `~/.claude/` is ephemeral on pods. This repo is the source of truth; `bootstrap.sh` hydrates it.
- **Skills over memory**: Behavioral rules live in skill files (deterministic, version-controlled) rather than Claude's memory system (probabilistic, per-conversation).
- **Minimal permissions**: `settings.json` allows `Bash`, `Read`, and `WebFetch` by default; destructive operations (`rm -r*`) require confirmation.
