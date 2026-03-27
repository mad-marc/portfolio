#!/bin/bash
# Installs agents from mad-marc/agents into .claude/agents/ of the current project.
# Requires GITHUB_TOKEN env var with repo read access.

set -e

REPO="mad-marc/agents"
TARGET=".claude/agents"
API="https://api.github.com/repos/$REPO/contents"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set."
  echo "Set it in Claude Code: Settings → Environment Variables → GITHUB_TOKEN"
  exit 1
fi

mkdir -p "$TARGET"

echo "Fetching agents from $REPO..."

FILES=$(curl -sf -H "Authorization: Bearer $GITHUB_TOKEN" "$API" \
  | jq -r '.[] | select(.name | endswith(".md")) | .name')

if [ -z "$FILES" ]; then
  echo "Error: Could not fetch agent list. Check your GITHUB_TOKEN."
  exit 1
fi

for FILE in $FILES; do
  curl -sf -H "Authorization: Bearer $GITHUB_TOKEN" "$API/$FILE" \
    | jq -r '.content' \
    | base64 -d > "$TARGET/$FILE"
  echo "  ✓ $FILE"
done

echo "Done. $(echo "$FILES" | wc -l | tr -d ' ') agents installed in $TARGET/"
