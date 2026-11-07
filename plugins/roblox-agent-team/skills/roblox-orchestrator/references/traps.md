# Traps

Each of these looks right, throws no error, and quietly does the wrong thing.
Most were measured on real builds by SyphoDev. Some came from the older
third-party Studio MCP, so if a trap doesn't reproduce on your setup, trust
what you see and note it.

**Studio / MCP**
- **Stale DataModel.** After an interrupted playtest, Studio can hold a
  second DataModel. `execute_luau` reports things that aren't on screen.
  Compare something you can see (selection count, a named part) with what the
  tool reports. If they disagree, restart Studio before investigating.
- **Stale screenshot.** The viewport can stop redrawing while the UI around
  it keeps updating, and captures come back frozen. If two captures after a
  camera move look identical, the frame is stale. Don't reason from it.
- **`execute_luau` that yields can lose its output.** Any `task.wait` or
  yielding call can drop prints and the return value. Do the work in one
  call and read the result in a second, or schedule with `task.delay` and
  return immediately.
- **`require` is cached in plugin context.** Re-requiring a changed module
  runs the old code. Verify through the script's `.Source`.
- **Edit vs runtime.** Edit-mode checks can't tell you whether the game
  works when a player presses the button. Runtime evidence is the console
  during a playtest, plus a human playing it.

**Scripting**
- **A remote has three ends.** Sender, server handler, and any receiver or
  relay. Change the arguments at two and the third drops every message with
  no error. Grep all three.
- **`type()` vs `typeof()`.** `type(CFrame.new())` and `type(Color3.new())`
  are both "userdata", so `type()` can't tell them apart and an exploiter can
  pass the wrong one. Validate with `typeof()`.
- **Bare `pcall` hides the error.** Always capture and warn.
- **The Humanoid fights scripted velocity.** On the ground, its state machine
  brakes your velocity to zero; `WalkSpeed = 0` is itself a brake and
  `ChangeState(Freefall)` gets overridden. What holds:
  `SetStateEnabled(Running, false)` during the impulse, with a restore that's
  guaranteed (set up the `task.delay` restore BEFORE the impulse).
- **Field vs method name clash.** `self.Coins` and `:Coins()` on the same
  object: the lookup returns the function. Prefix fields with `_`.
- **Rojo owns its subtree.** Anything created at runtime under a Rojo-synced
  folder is deleted on the next sync. If it must persist, it goes in source.
  Two Rojo connections at once duplicate every new file; keep one.

**Building**
- Model pivot shifts when PrimaryPart is set (see world-rules).
- `GetBoundingBox()` is in the model's own frame, not world space.
- `ScaleTo` is Model-only and uniform.
- Ball parts use the smallest size component.
- Terrain snaps to 4-stud voxels; nothing at y=0.
- Welds don't animate; Motor6D does.

**Checking**
- **A check that can't find its target must FAIL.** A check pointed at the
  wrong name reported green while hundreds of defects shipped.
- **Check the constraint, not a proxy.** "Weapon is above the floor" can't
  see a weapon floating beside the hand. "The swing animation played" can't
  see the server rejecting the hit. Ask: did the SERVER accept it? Did the
  VICTIM's health change? Does the Studio source contain the line I wrote?
- **Look at your own evidence** at full size, zoomed on what you're claiming,
  before you attach a claim to it.
