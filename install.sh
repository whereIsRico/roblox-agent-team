#!/usr/bin/env bash
# Manual install (only if you are NOT using the plugin/marketplace route).
# Don't use both, or you'll get duplicate skills and agents.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)/plugins/roblox-agent-team"
mkdir -p "$HOME/.claude/skills" "$HOME/.claude/agents"
for s in "$here"/skills/*/; do
  name="$(basename "$s")"
  rm -rf "$HOME/.claude/skills/$name"
  cp -R "$s" "$HOME/.claude/skills/$name"
done
cp "$here"/agents/*.md "$HOME/.claude/agents/"
echo "Installed skills: $(ls "$here/skills" | tr '\n' ' ')"
echo "Installed agents: $(ls "$here/agents" | sed 's/.md//' | tr '\n' ' ')"
echo "Restart Claude Code."
