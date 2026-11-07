# Code rules (scripter + reviewer)

## Architecture

- **Server owns the game, clients own the display.** Health, inventory,
  currency, score, damage, purchases, spawning, cooldowns, saves: server.
  Input, camera, local UI, visual feedback: client.
- **Every client message is a request, not a fact.** On the server, check in
  this order before changing anything: type (`typeof`, never `type`), range,
  ownership, distance/timing where relevant. Rate-limit anything spammable.
- **One `Net` module declares every remote.** All RemoteEvent/RemoteFunction
  names live in one ModuleScript in ReplicatedStorage. No bare name strings
  scattered across scripts, because a typo fails silently.
- **Every tunable lives in a `Config` module.** Speeds, prices, cooldowns,
  drop rates, round lengths. A balance pass should be a data edit, never a
  code edit. (For values you want to change live without restarting servers,
  load the `rbx-configs-experimentation` skill.)
- **Pure logic in pure modules.** If a function can be written without
  touching an Instance (damage math, score rules, inventory rules), put it in
  a ModuleScript that takes plain numbers/tables and returns plain values.
  That's what makes it testable with `rbx-unit-test`. Build Vector3s and touch
  Instances at the edges, in the scripts that call it.
- **Cosmetics can never break gameplay.** VFX, sounds, tweens and camera
  shake run isolated (`task.spawn` + `pcall`) and fail quietly with a `warn`.
  A broken particle must never stop a hit from registering.
- **Build stamp.** The main server script and main client script each print
  one line on start, e.g. `print("[Game] server up - build 12")`. Bump it when
  you need proof Studio is running the newest code. If that line isn't in
  Output, your edit isn't live.

## Luau specifics

- `task.wait/spawn/delay/defer`, never `wait/spawn/delay`.
- Modern physics movers (LinearVelocity, AlignPosition, AlignOrientation,
  VectorForce), never BodyVelocity/BodyGyro/BodyPosition.
- `--!strict` and type annotations if the codebase uses them.
- `local ok, err = pcall(fn)` then `if not ok then warn(...) end`. Never a
  bare `pcall(function() ... end)` that throws the error away.
- DataStores: `pcall` + retry with backoff, `UpdateAsync` when two things
  could write the same key, save on PlayerRemoving AND BindToClose, never
  save more often than the budget allows.
- Purchases: `ProcessReceipt` must be idempotent (record the PurchaseId) and
  only return PurchaseGranted after the grant is actually saved.
- Loops must yield. Heartbeat work must be bounded, not scale with
  players x parts.
- Clean up: disconnect connections, clear per-player tables on
  PlayerRemoving, handle Destroying.
- Name internal fields with an underscore (`self._coins`) so they can't
  collide with a method of the same name.
- Motor6D, not Weld, for anything an animation needs to move.
- No narrating comments. Comment only real constraints or non-obvious reasons.

## Before reporting (scripter)

- `script_read` back every script you changed.
- If you changed a remote's arguments, grep for that remote at all THREE
  ends (sender, server handler, any client receiver/relay). Changing two ends
  makes the third drop every message with no error.
- `get_console_output`: no errors or warnings from your scripts.
- If the project uses Rojo and the tools are installed, run what's available:
  `rojo build -o /tmp/check.rbxl`, `selene src`, `stylua --check src`.
  `rojo build` alone catches syntax errors and bad paths in about a second.
