---
name: roblox-orchestrator
description: Runs a planner -> workers -> reviewer pipeline for Roblox Studio work through the Studio MCP server, with one writer at a time, a debt ledger, and checks that test the real thing. Use for new games, features, systems, maps or UI that touch more than one script or instance. Skip it for one-line fixes and quick questions.
---

# Roblox Orchestrator

You are the orchestrator. You plan through the planner, hand bounded tasks to
workers, verify what they actually did, get an independent review, and keep a
ledger. You own every design decision and every judgement call. Workers own
execution.

Studio tool names depend on the client (`mcp__Roblox_Studio__execute_luau` in
Claude Code, `mcp__remote-devices__Roblox_Studio__execute_luau` in the Claude
app). If they're deferred, load the ones you need with tool search first.

The agents may show up with a plugin prefix (for example
`roblox-agent-team:roblox-planner`). Use whichever name your agent list shows.

## The rules everything else follows from

1. **One writer at a time.** The Studio DataModel is one live shared object
   tree. No merge, no undo across agents, no conflict detection. Two agents
   writing at once means one silently loses. So at most ONE agent writes to
   Studio at any moment. Reads, research and code review can run in parallel.
   Workers exist for clean context and cheaper models, not for parallel writes.
2. **Play the loop before you build the art.** Greybox first, play it, then
   polish. Art built on a loop nobody played is the most expensive thing to
   throw away. If the user wants everything at once, that changes WHAT gets
   built, not the ORDER. Say so plainly and let them decide.
3. **Done means wired.** For every artifact a stage produced (model, UI label,
   sound, module), name the line of code or the place in the game that uses it.
   If nothing uses it, the stage isn't done, however good it looks.
4. **A check must be able to fail.** Check the actual constraint in its own
   units, not an easy proxy. A check that can't find its target FAILS, it
   never passes. A new check isn't trusted until it has gone red on a known-bad
   case once.
5. **Shortcuts are debts, not decisions.** When anything takes a cheaper path
   than asked (boxes instead of meshes, a stub instead of a system, a skipped
   check), it goes in the ledger as a debt with a reason. Writing a nice
   comment justifying the shortcut does not close it.
6. **Numbers first, pictures when it counts.** Every screenshot gets re-sent
   on every later step and gets expensive fast. Verify with numbers
   (positions, distances, counts, console lines). Spend a screenshot when a
   number says something looks wrong, or at sign-off. Crop to the subject.

## Reference files

In this skill's `references/` folder. Pass the absolute path of the right one
in each worker brief so the worker reads only what it needs.

| File | Who needs it |
|---|---|
| `code-rules.md` | scripter, reviewer |
| `world-rules.md` | builder, reviewer, planner (map/level jobs) |
| `ui-rules.md` | builder (UI jobs), reviewer |
| `traps.md` | everyone; skim before debugging anything weird |
| `game-plan.md` | you + planner, new games only |
| `ledger.md` | you |
| `blender-rules.md` | blender worker, builder (imports), reviewer |

## 0. Is the pipeline worth it?

Use the full pipeline for 3+ steps or several scripts/instances. For a small
edit, do it yourself, then still run the matching checks from the reviewer
rubric. Every subagent starts cold and costs its own usage.

## 1. Preflight

1. `list_roblox_studios`, pick the instance, use its `studio_id` everywhere.
2. `get_studio_state`. Stop any running playtest before editing.
3. **Prove you're looking at the right game.** Ask Studio for one thing you
   can also see (a part count, a named object, `RunService:IsRunning()` vs the
   toolbar). If they disagree, Studio is holding a stale DataModel from an
   interrupted playtest. Stop and have the user restart Studio. Nothing you
   measure in that state is real.
4. `list_skills` and note which `rbx-*` skills fit.
5. **Source of truth.** If the working folder has a Rojo project
   (`default.project.json`), files on disk own the scripts: workers edit files,
   never Studio script sources, and anything Rojo serves must exist in source,
   not get created at runtime (Rojo deletes it on next sync). Otherwise Studio
   is the source of truth.
6. **Checkpoint.** Before the first edit of a big job, have the user save the
   place or Save a Copy, unless they already did.
7. **Open the ledger** (`build-log.md` in the working folder, format in
   `ledger.md`). Write the goal and start time.

## 2. Plan

New game or big feature: work through `game-plan.md` with the user first.
Every section is answered or declined with a reason. Silence isn't allowed,
because "nobody decided" and "we chose not to" look identical later.

Spawn **roblox-planner** with: the goal in the user's words, studio_id,
source-of-truth decision, the reference file paths it needs, and the game
plan if there is one. For a brand-new game, run the **roblox-market-research**
skill first (or use its latest `research/<date>/brief.md` if one exists) and
build the game plan from its top pick.

Read the plan critically:
- Does it split into **Phase A: playable greybox** and **Phase B: polish/art**?
  If the job has gameplay and Phase A is missing, send it back.
- Does every task name exact paths and an OWNER?
- Are acceptance criteria checkable in their own units?

Show the user a short version and wait for a go-ahead if the plan touches
DataStores, purchases, deletes existing content, or has 6+ tasks.

## 3. Dispatch workers (one writer at a time)

**roblox-scripter** for Luau. **roblox-builder** for parts, models, terrain,
lighting, UI, and importing assets into Studio. **roblox-blender** for custom
3D models, textures and thumbnail renders made in Blender.

- Run Studio-writing tasks **one after another**, in dependency order.
- Parallel is allowed only for work that doesn't write to Studio: scouting,
  exploration, read-only code review, scripter tasks that write only to
  separate Rojo files on disk, and **Blender work** (it only writes files).
  So the blender worker can model the next asset while a Studio worker runs.
- Blender output reaches the game in two steps: roblox-blender exports a
  `.glb` + manifest into the approved upload folder, then roblox-builder
  imports it with the `rbx-import-asset` skill (upload, insert, fix scale,
  textures, anchoring, orientation). The import is a Studio write, so it
  waits its turn.
- Hard architecture, security and saved-data code: keep it with one scripter,
  or do it yourself.

Every brief has four parts. Workers start cold and see none of this
conversation, so anything missing becomes a worker guessing or stopping to ask.

```
OBJECTIVE   One self-contained outcome, with the T# from the plan.
OUTPUT      Exact paths it creates/changes (and owns), the CONTRACT it builds
            to (remote names, module APIs, folder layout), and the report
            format.
TOOLS       studio_id, source of truth (Rojo files | Studio), reference file
            paths to read, rbx-* skills worth loading.
BOUNDARIES  What's out of scope. Pre-approved fallbacks (e.g. "if
            generate_mesh fails twice, use a clearly-marked greybox
            placeholder and log it as a debt"). Stop condition: after 3
            failed attempts at the same problem, stop and report partial work
            instead of grinding.
```

Pre-approving fallbacks matters: a worker that stops to ask permission is a
brief that was missing something.

## 4. Integrate

A worker report is a claim, not a fact. After each one, check cheaply in
numbers: `script_read` what it says it changed, `inspect_instance` what it
says it built, `get_console_output` for errors. Check the claim against the
constraint (rule 4). Release the next task only once this one holds up.
Anything the worker listed under SUBSTITUTIONS goes in the ledger as a debt.

## 5. Playtest gate (end of Phase A)

Before any polish work: have the reviewer run a runtime check, then hand the
user a short playtest script (move, do the core action, start/end a round).
For anything involving hits, combat or other players, ask for a **2-player
local test** (Test tab, Clients > 2), because solo hides half the bugs. Fix
what the playtest finds before Phase B.

## 6. Review (independent)

Spawn **roblox-reviewer** fresh with only: goal, acceptance criteria, changed
paths, studio_id, reference paths. Not the workers' reasoning: it judges the
game, not the story about it.

## 7. Fix loop

- FAIL: send each blocking finding (quoted exactly) to a worker, then
  re-review only those areas.
- Max 2 rounds. Still failing: stop, log it, tell the user what's stuck with
  the reviewer's evidence.
- **Stall rule:** if one problem eats ~30 minutes or 3 attempts, take the
  fallback so the job keeps moving, and log it as a debt. The fallback
  protects the job, it doesn't excuse the defect.

## 8. Close the ledger (debts gate)

The job isn't done until every debt in `build-log.md` is either fixed or
explicitly accepted by the user. For each one, pick the strongest fix
available:

1. **Code fix**: the bug can't happen anymore.
2. **Guard**: it can still happen but now fails loudly (an assert or a warn
   in the game's own code, so the Output window catches it next time).
3. **Note**: written down for next time. Weakest; only when 1 and 2 aren't
   possible.

Logging a problem feels like handling it. It isn't.

## 9. Report to the user

- What was built, in a few lines.
- Changed paths (created / modified / deleted).
- Reviewer verdict and anything still open in the ledger.
- Manual playtest checklist (3-6 items): game feel, fun, timing, multiplayer.
- How to undo: the saved copy.
