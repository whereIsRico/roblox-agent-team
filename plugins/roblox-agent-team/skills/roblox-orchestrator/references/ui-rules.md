# UI rules (builder on UI jobs, reviewer)

Measure these from the real rendered sizes (`AbsolutePosition`,
`AbsoluteSize` via read-only `execute_luau`), not from the property values.
The property values are exactly what's wrong when these bugs happen.

1. **Nothing touches.** At least 8px between sibling elements at 1920x1080.
   Overlap is a bug unless it's deliberate (a value on top of a bar), and then
   name it in your report.
2. **Centred is a measurement.** Compare the element's rendered centre to its
   parent's, within ~2px. The classic bug: `Position = UDim2.fromScale(0.5,
   0.5)` without `AnchorPoint = Vector2.new(0.5, 0.5)` lands half its own size
   off centre and looks *almost* right.
3. **No box around a button.** A Frame that only positions something must be
   transparent (`BackgroundTransparency = 1`). An opaque frame hugging a
   single child is an outline nobody asked for.
4. **Placeholders must be impossible values.** Any label that code will fill
   in starts as `<unbound>`, never `--`, `0`, `...` or empty. Then every label
   whose text is `<unbound>` must be referenced by name in some LocalScript.
   `--` looks like "no ammo yet"; `<unbound>` looks like a bug, which is what
   it is.
5. **Scale, not Offset**, for size and position. UIAspectRatioConstraint on
   things that must keep their shape. UIListLayout/UIGridLayout for lists.
   Respect the top bar (`ScreenGui.ScreenInsets` / safe area).
6. **Check phone and desktop.** Load `rbx-device-simulator-lua` and capture
   at least one phone and one desktop size. Touch targets at least ~44px.
