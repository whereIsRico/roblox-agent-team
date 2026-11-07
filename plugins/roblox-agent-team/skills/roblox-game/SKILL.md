---
name: roblox-game
description: The start-to-finish roadmap for making a Roblox game with this agent team, from setup check and market research to plan, playable prototype, art, monetization, launch and weekly live-ops. Tracks progress in design/progress.md so work can resume across sessions. Use when starting a new game, resuming one ("where are we?", "what's next?"), or when the user isn't sure which skill to use.
---

# Roblox Game: start to finish

You are the producer. You don't do the stages yourself; you run them in
order with the right skill, keep `design/progress.md` honest, and stop at
each gate until it's actually met.

## First, every session

1. Read `design/progress.md` in the working folder. If it doesn't exist,
   this is a new game: create it from the template below.
2. Tell the user in 2-3 lines where the game is and what's next.
3. Run the **setup check** (stage 0) if it hasn't passed this session and the
   next stage needs Studio or Blender.

## Stages and gates

| # | Stage | Skill / agents | Gate (done when) |
|---|---|---|---|
| 0 | Setup check | this skill | Studio MCP answers `list_roblox_studios`; Blender MCP answers (only needed from stage 5); git repo exists |
| 1 | Research | roblox-market-research | `research/<date>/brief.md` exists and the user picked a loop |
| 2 | Game plan | orchestrator's `game-plan.md` | `design/game-plan.md`: all 17 sections answered or declined; scope fits the build budget |
| 3 | Prototype (Phase A) | roblox-orchestrator | Greybox core loop works; reviewer PASS; no open debts except "greybox art" |
| 4 | Playtest gate | user + orchestrator | User played it (2 players if social/combat) and says the loop is fun enough to continue. If not: back to 2 or 3, don't polish a boring loop |
| 5 | Art + polish (Phase B) | roblox-orchestrator (+ roblox-blender) | Greybox debts replaced with meshes/UI art; reviewer PASS incl. imported-art checks |
| 6 | Monetize + analytics | roblox-launch stages 2-3 | Passes/products live and tested; funnel + economy events firing |
| 7 | Launch | roblox-launch stages 1, 4-7 | Published, store page done, audience requirements started, soft launch running |
| 8 | Live-ops | roblox-launch weekly review | Weekly; one change per week; revenue vs target tracked |

**Gate rules:**
- Never skip a gate silently. If the user wants to skip one, say what it
  risks in one line, then do what they decide and write it in progress.md.
- Stage 4 is the most important gate. Art on an unfun loop is wasted work.
- Revenue target defaults to $500/month (from the research skill). Every
  plan and review is measured against it.

## Scope sanity (stage 2)

A first game for a solo dev with this team should be playable in about 2
weeks (stage 3) and launchable in about 4-8. If the plan can't fit, cut
features into the plan's "Out of scope" section until it does. Small and
finished beats big and abandoned; you can always update after launch.

## progress.md template

```markdown
# <Game name>
Target: $500/month. Started: <date>.

## Stage
<current stage # and name>

## Gates
- [ ] 0 Setup check
- [ ] 1 Research: <brief path, chosen loop>
- [ ] 2 Game plan: design/game-plan.md
- [ ] 3 Prototype: reviewer PASS on <date>
- [ ] 4 Playtest: <who played, verdict>
- [ ] 5 Art + polish
- [ ] 6 Monetize + analytics
- [ ] 7 Launch: <date>
- [ ] 8 Live-ops: weekly reviews in design/weekly/

## Decisions
- <date>: <decision and why>

## Next
<the very next concrete step>
```

## Folder layout (the working folder)

```
CLAUDE.md            project rules (see SETUP.md in the pack)
design/              progress.md, game-plan.md, weekly/
research/<date>/     market research runs, ccu-history.csv
art/                 refs/, blend/, exports/ (approved upload folder), renders/
build-log.md         orchestrator ledger
src/                 only if using Rojo
```
