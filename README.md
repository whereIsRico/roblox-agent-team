# Roblox Agent Team v3

Everything to make a Roblox game start to finish with Claude Code: research
what to build, plan it, build it with an agent team, make 3D art in Blender,
launch it, and run weekly live-ops against a revenue target ($500/month by
default).

**Setup: see [SETUP.md](SETUP.md).**

## Skills

| Skill | What it does |
|---|---|
| `/roblox-game` | Start here. The roadmap and progress tracker; runs the others in order |
| `/roblox-market-research` | Finds loops already earning your target, what players respond to, money math |
| `/roblox-orchestrator` | Builds: planner -> workers (one Studio writer at a time) -> reviewer -> debt ledger |
| `/roblox-launch` | Ship-readiness QA, monetization, analytics, store page, publishing, weekly live-ops |

## Agents

| Agent | Model | Job |
|---|---|---|
| roblox-scout | sonnet | Deep-dives one game loop for research. No Studio |
| roblox-planner | opus | Read-only; explores the place, returns a phased plan |
| roblox-scripter | sonnet | Luau |
| roblox-builder | opus | Parts, terrain, UI, lighting, imports Blender models |
| roblox-blender | opus | 3D models, textures, thumbnail renders in Blender. Files only, no Studio |
| roblox-reviewer | opus | Read-only; code, wiring, measurements, art, captures, runtime |

## The path

```
0 Setup check -> 1 Research -> 2 Game plan -> 3 Prototype (greybox)
-> 4 Playtest gate -> 5 Art + polish (Blender) -> 6 Monetize + analytics
-> 7 Launch -> 8 Weekly live-ops
```

## Rules the whole pack follows

- One writer to Studio at a time. Reads, research and Blender run in parallel.
- Play the loop before building the art.
- Done means wired: every artifact is used by something.
- Checks must be able to fail; "not found" is a fail.
- Shortcuts are logged as debts and closed before a job is done.
- Numbers first, screenshots when they count.

## If your Studio server isn't named Roblox_Studio

Planner and reviewer have locked tool lists that assume `Roblox_Studio`.
Replace `mcp__Roblox_Studio__` in `roblox-planner.md` and `roblox-reviewer.md`
if yours differs.

## Credits

Several rules (single writer, debt ledger, play-the-loop-first, honest checks,
movement math, UI layout rules, traps) are adapted from SyphoDev's free
Roblox skills (https://github.com/SyphoDev-yt/roblox-ai-skills, SyphoDev on
YouTube). Their licence: free to use and modify, credit when shared, never
sell it or put it in a paid bundle.
