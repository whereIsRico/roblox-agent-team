# World rules (builder, reviewer, planner on map jobs)

## Movement numbers: prove reach with math, don't eyeball it

Read the real values first (read-only `execute_luau`): `workspace.Gravity`,
and on a character's Humanoid `WalkSpeed`, `UseJumpPower`, `JumpHeight` /
`JumpPower`. Then:

- Takeoff speed `v0 = sqrt(2 * g * JumpHeight)` (or `v0 = JumpPower`)
- Apex height `= v0^2 / (2g)`
- Flat jump distance `= WalkSpeed * 2 * v0 / g`
- Jump onto something `dy` higher: `t = (v0 + sqrt(v0^2 - 2*g*dy)) / g`,
  distance `= WalkSpeed * t`. If `v0^2 < 2*g*dy`, it can't be reached at all.

Stock Roblox (gravity 196.2, WalkSpeed 16, JumpHeight 7.2):

| Rise | Max gap at walk speed |
|---|---|
| 0 (flat) | 8.7 studs |
| +2 | 8.0 |
| +4 | 7.2 |
| +6 | 6.1 |
| over 7.2 | impossible |

Give real gaps a margin (aim ~80% of max) or players fail them half the time.
Auto-step is about 2 studs: anything taller is a wall, so stairs need risers
of 2 studs or less.

Reachability has three answers, keep all three: **yes** (comfortably),
**maybe** (only at the edge of the numbers), **no**. Don't round "maybe" to
"yes" for things players should reach, or to "no" for places they shouldn't
(out of bounds, inside walls).

## Placement

- **Nothing sits at exactly y=0.** Studio draws its grid there and it paints
  across any surface at that height (editor only, but it looks broken). Lift
  ground to y=8 or similar.
- **Terrain snaps to a 4-stud voxel grid.** You can't nudge it by 0.5. Plan
  terrain surfaces on multiples of 4. Two terrain materials in the same voxel
  band fight; keep them in separate bands.
- **A Model's pivot moves when you set PrimaryPart.** Never trust the pivot
  for placement. Rotate, read `GetBoundingBox()`, then move by the measured
  difference:
  ```lua
  m:PivotTo(CFrame.Angles(0, math.rad(yaw), 0))
  local cf = m:GetBoundingBox()
  m:PivotTo(m:GetPivot() + (target - cf.Position))
  ```
- **`GetBoundingBox()` is in the model's own frame.** For a world-space
  audit of rotated models, build the box from part corners
  (`part.CFrame:PointToWorldSpace(part.Size * corner)`).
- `ScaleTo` exists on Models only, and it's uniform. Pick the scale from the
  dimension you care about (usually height). MeshParts scale via `.Size`.
- A `Ball` part uses the SMALLEST size component as its diameter. You can't
  make a flattened dome from parts; use a mesh or terrain.
- Anchor static geometry. Set CanCollide/CanQuery/CanTouch on purpose. No
  overlapping coplanar faces (they flicker). Group under named Folders/Models,
  nothing loose at the Workspace root.

## Boundaries

Build the map edge as two separate things: **scenery** the player looks at
(cliffs, walls, terrain, facing inward) and an **invisible barrier** that
actually stops them (one tall invisible anchored part per side, overlapping at
corners). Never contain players with mesh collision: there's always a seam.
Scenery must stand ON the ground (sink it a few studs so no sky shows under
it). Judge a boundary from inside the map at head height, because that's the
only view players get.

## Looks

- **Build from a reference, not from memory.** Find a reference image of the
  thing (search for it), actually look at it, and list 3-5 concrete details
  to match before building. Building "a cottage" from imagination gives you a
  box with a lid every time.
- **Mesh first.** Trees, rocks, buildings, props and anything repeated: use
  meshes (`generate_mesh`, `generate_procedural_model`, `insert_asset`), not
  stacks of parts. Greybox parts are fine in Phase A as obvious placeholders,
  and each one is a ledger debt until replaced.
- Toolbox/inserted assets: delete any script inside you didn't intend to
  bring in, especially `require(<number>)`, `getfenv`, `loadstring` or
  obfuscated strings. That's the classic backdoor.
