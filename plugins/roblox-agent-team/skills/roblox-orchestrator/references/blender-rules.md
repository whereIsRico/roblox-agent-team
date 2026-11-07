# Blender rules (blender worker, builder on imports, reviewer)

## Connection

- **Blender MCP** (preferred): tools appear as `mcp__blender__*`
  (`execute_blender_code` plus scene-info / viewport-screenshot tools; the
  exact list depends on the add-on version, so check what you have). Blender
  must be open with the add-on connected (N panel > BlenderMCP > Connect).
  The first call after connecting sometimes fails; retry once.
- **Headless fallback** (no MCP, or for batch jobs): write a Python script and
  run `/Applications/Blender.app/Contents/MacOS/Blender -b <file.blend>
  --python <script.py>`. Render images to check your work and Read them.
- `execute_blender_code` runs arbitrary Python. Save the .blend first.

## Files

```
art/
  refs/<asset>/        reference images you looked at
  blend/<asset>.blend  one source file per asset (or per kit)
  exports/<asset>.glb  what goes to Roblox (this folder is the approved
                       upload folder in Studio's MCP permissions)
  exports/<asset>.json manifest (below)
  renders/             previews, thumbnail and icon renders
```

Never edit a .blend you didn't create unless the brief says so. Work on
copies for anything destructive (decimate, apply modifiers, join).

## Scale and orientation

- Model at real-world size in metres. Roblox imports at about
  **1 stud = 0.28 m**, so a 5-stud-tall character is about 1.4 m and a
  door for it is about 2 m. Write the expected size in studs in the manifest.
- Origin at the bottom centre of the object. Apply rotation and scale (on a
  copy or via the exporter).
- Blender is Z-up, Roblox is Y-up. glTF export with "+Y Up" on handles it.
- Pick one **asymmetric feature** (e.g. "door faces -Y") and write it in the
  manifest. The import step uses it to check rotation and mirroring.

## Budget and style

- Roblox has a per-mesh triangle limit. Look up the current number on the
  Roblox mesh specifications page before exporting; split anything over it
  into `<Name>_Part<N>` pieces.
- Stay well under it anyway. Rough budgets per object: grass/small prop
  100-300, rock 300, crate/furniture 300-1,000, building 800-3,000, tree
  1,000-2,500, hero/landmark 3,000-8,000. Many players are on phones.
- Reuse: one well-made kit (5 rock variants, 3 tree variants) beats 40 unique
  meshes. Repeated objects should be the same mesh.
- Stylized low-poly with clean silhouettes reads best on Roblox. Bevel only
  where light catches it.

## Materials and textures

- Principled BSDF only. Base Color, Normal, Roughness, Metallic map to
  Roblox SurfaceAppearance.
- Textures at most 1024x1024 (512 is often plenty). Prefer a shared atlas or
  trim sheet across a kit over one texture per object.
- Flat-coloured objects: a plain Base Color value is fine (no texture).
  Blender's colour values are linear; the import step converts them.
- UV unwrap anything textured; no overlapping islands for unique textures.
- Pack or save every image so the GLB embeds it. No blank or single-colour
  textures pretending to be detail.
- Unique, meaningful names for every mesh and material. Imports match by
  name.

## Look before you ship

- **Reference first.** Find 1-3 reference images, save them to
  `art/refs/<asset>/`, actually look at them, and write 3-5 concrete details
  to match. Building from memory gives you generic boxes.
- Check in numbers first: triangle count per mesh after modifiers,
  dimensions, material list.
- Then render or screenshot front, side and 3/4 views at a small size and
  look at them. Fix what's wrong before exporting.
- Generated meshes (AI generators, Studio's `generate_mesh`) are fine as a
  starting point, but clean them up, check their licence, and still hit the
  budget.

## Export

- GLB, selected objects only, modifiers applied by the exporter, +Y up,
  textures embedded. No cameras, lights or helpers.
- Write `art/exports/<asset>.json`:

```json
{
  "asset": "market_stall",
  "file": "art/exports/market_stall.glb",
  "meshes": [{"name": "Stall_Body", "tris": 1240}, {"name": "Stall_Awning", "tris": 380}],
  "materials": [{"name": "Wood", "baseColorTexture": true}, {"name": "Cloth_Red", "baseColor": [0.6, 0.05, 0.04]}],
  "size_m": [3.2, 2.9, 2.1],
  "expected_size_studs": [11.4, 10.4, 7.5],
  "asymmetric_feature": "awning overhangs on -Y (front)",
  "reference": "art/refs/market_stall/",
  "licence": "original"
}
```

## Rigs and animation

Skinned characters and custom rigs must follow Roblox's avatar/character
specs and are a big job. Don't start one unless the brief explicitly asks.
Most games are better served by Roblox's default R15 characters with
animations made in Studio's Animation Editor.

## Thumbnails and icon renders

- Thumbnails: 1920x1080 (16:9). Icon: 512x512.
- Show what the first 3 minutes of play actually look like: the core action,
  a clear focal subject, high contrast, readable at phone size. Nothing
  important along the bottom edge (player count covers it).
- 1-3 words of text at most, or none.
