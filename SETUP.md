# Setup (Mac), one time

Do these in order. Each step ends with a check so you know it worked.

## 1. Tools

```bash
# Homebrew (skip if you have it): https://brew.sh
brew install git gh uv
brew install --cask blender roblox-studio   # or download Blender from blender.org
```
Check: `git --version`, `uvx --version`, Blender opens.

Claude Code: install from https://claude.com/claude-code, then run `claude`
once and log in.

## 2. Your game folder

```bash
mkdir -p ~/Projects/RBLX && cd ~/Projects/RBLX
git init
mkdir -p design research art/refs art/blend art/exports art/renders
cp <path-to-this-pack>/templates/CLAUDE.md ./CLAUDE.md
```
One folder per game is cleanest (e.g. `~/Projects/RBLX/<game-name>`). Always
start `claude` from inside the game's folder.

## 3. Roblox Studio MCP

1. Open Studio and your place.
2. Assistant > ... > Manage MCP Servers > turn on **Enable Studio as MCP
   server** > Quick connect **Claude Code**.
3. In the same MCP settings, approve **`~/Projects/RBLX/<game>/art/exports`**
   as an upload folder and grant the Open Cloud asset scopes
   (`asset:read`, `asset:write`) when asked. Needed to import Blender models.

Check: `claude mcp list` shows `Roblox_Studio` connected. The planner and
reviewer agents expect that exact name.

## 4. Blender MCP

```bash
claude mcp add --scope user blender -- uvx blender-mcp
```
Then in Blender:
1. Download `addon.py` from https://github.com/ahujasid/blender-mcp
2. Edit > Preferences > Add-ons > Install... > pick `addon.py` > enable
   **Interface: Blender MCP**.
3. In the 3D view press **N** > **BlenderMCP** tab > **Connect to Claude**.

Check: in Claude Code, `/mcp` shows `blender` connected, and asking "what's in
the Blender scene?" gets an answer. Blender must be open and connected
whenever you want 3D work done.

Safety: the Blender MCP runs any Python Claude sends. Keep tool approval on
and save your .blend files.

## 5. This pack

Push this folder to your GitHub (if you haven't):
```bash
cd <path-to-this-pack>
gh repo create roblox-agent-team --public --source=. --push
```
Then in Claude Code:
```
/plugin marketplace add <your-github-username>/roblox-agent-team
/plugin install roblox-agent-team@rico-roblox
/reload-plugins
```
Check: type `/roblox` and you see roblox-game, roblox-market-research,
roblox-orchestrator, roblox-launch (maybe prefixed `roblox-agent-team:`).
`/agents` lists roblox-planner, -scripter, -builder, -reviewer, -scout,
-blender.

Updating later: push changes (bump `version` in
`plugins/roblox-agent-team/.claude-plugin/plugin.json`), then
```
/plugin marketplace update rico-roblox
/plugin update roblox-agent-team@rico-roblox
/reload-plugins
```

## 6. Optional

- `EL4CTEO/roblox-skills` for deeper Luau/security knowledge:
  `/plugin marketplace add EL4CTEO/roblox-skills` then
  `/plugin install roblox-skills@roblox-skills`
- Rojo + Git for scripts as files, once you're comfortable.

## 7. Go

```bash
cd ~/Projects/RBLX/<game> && claude
```
```
/roblox-game let's make a new game
```
