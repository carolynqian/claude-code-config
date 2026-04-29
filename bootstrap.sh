#!/usr/bin/env bash
# Installs user-level Claude Code config (settings, CLAUDE.md, skills) into ~/.claude/.
# Env vars:
#   GITHUB_TOKEN         — fine-grained PAT with read access to your fork of this repo
#   CLAUDE_CONFIG_REPO   — owner/repo (e.g. yourname/claude-code-config)
#   GIT_USER_NAME        — (optional) sets global git user.name
#   GIT_USER_EMAIL       — (optional) sets global git user.email

set -euo pipefail

: "${GITHUB_TOKEN:?Set GITHUB_TOKEN (fine-grained PAT with read access to your config repo)}"
: "${CLAUDE_CONFIG_REPO:?Set CLAUDE_CONFIG_REPO to owner/repo (e.g. yourname/claude-code-config)}"

REPO="$CLAUDE_CONFIG_REPO"
BRANCH="main"
BASE="https://raw.githubusercontent.com/$REPO/$BRANCH"
AUTH=(-H "Authorization: token $GITHUB_TOKEN")

mkdir -p ~/.claude/skills/ship ~/.claude/skills/catchup ~/.claude/skills/new-repo ~/.claude/skills/daily-log ~/.claude/skills/generate-anki

curl -sfL "${AUTH[@]}" -o ~/.claude/settings.json             "$BASE/settings.json"
curl -sfL "${AUTH[@]}" -o ~/.claude/CLAUDE.md                 "$BASE/CLAUDE.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/ship/SKILL.md      "$BASE/skills/ship/SKILL.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/catchup/SKILL.md   "$BASE/skills/catchup/SKILL.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/new-repo/SKILL.md  "$BASE/skills/new-repo/SKILL.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/daily-log/SKILL.md               "$BASE/skills/daily-log/SKILL.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/generate-anki/SKILL.md            "$BASE/skills/generate-anki/SKILL.md"
curl -sfL "${AUTH[@]}" -o ~/.claude/skills/generate-anki/anki-card-style-guide.md "$BASE/skills/generate-anki/anki-card-style-guide.md"

if [ -n "${GIT_USER_NAME:-}" ] && [ -n "${GIT_USER_EMAIL:-}" ]; then
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
  echo "Set global git identity to $GIT_USER_NAME <$GIT_USER_EMAIL>."
fi

echo "Installed Claude config to ~/.claude/."
echo "Next: run 'gh auth login' to authenticate the GitHub CLI."
