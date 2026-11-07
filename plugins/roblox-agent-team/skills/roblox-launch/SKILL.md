---
name: roblox-launch
description: Takes a playable Roblox game to public release and keeps it earning: pre-launch QA, monetization and analytics setup, store page (icon, thumbnails, description), publishing and audience requirements, soft launch, and a weekly live-ops review against the revenue target. Use when a game's core loop is done and it's time to ship, or for the weekly post-launch review.
---

# Roblox Launch

You run launch and live-ops. Studio work still goes through the
roblox-orchestrator rules (one writer at a time, review, ledger). Some steps
can only be done by the user in Studio or the Creator Dashboard; mark those
clearly as **YOU DO** and give exact steps.

Roblox's publishing rules, fees and thresholds change. Before telling the
user any requirement, check the current official docs (`rbx-docs-search`, or
create.roblox.com) and Creator Hub > Eligibility. The numbers in
`launch-checklist.md` are a starting point, not gospel.

## Modes

- **Launch** (first release): run all stages below.
- **Weekly review** (after launch): run `live-ops.md`.

## Launch stages

Track progress in `design/progress.md` (the roblox-game skill's file).

### 1. Ship-readiness QA

Run the orchestrator's reviewer on the whole game, plus:
- `rbx-scene-analysis` and `rbx-perf-profiling`: no obvious memory or frame
  problems. Phones matter most.
- `rbx-device-simulator-lua`: UI on phone, tablet, desktop.
- `rbx-network-simulator`: play on a bad 4G connection. Nothing breaks,
  nothing double-awards.
- Saving: leave and rejoin, data is there. Leave mid-purchase, nothing lost.
- A **2-player** local test of anything social or competitive.
- First 60 seconds: a new player knows what to do without reading anything.

Any blocking issue goes to the orchestrator as a fix job. Don't launch with
open debts the user hasn't accepted.

### 2. Monetization

From the game plan's monetization section (or the market brief: what the
leaders in this loop sell, at what prices):
- Load `rbx-open-cloud-usage` and `rbx-permissions`. Create game passes and
  developer products through `open_cloud_invoke` if the API and permissions
  allow; otherwise give the user exact Creator Dashboard steps.
- Scripter wires them: `MarketplaceService`, an idempotent `ProcessReceipt`
  (record PurchaseId, grant, save, THEN return PurchaseGranted), pass checks
  on join and on purchase.
- Price against the loop's leaders. A cheap "starter" item (25-100 Robux)
  converts first-time buyers; one VIP/2x pass is standard.
- No pay-to-win that breaks the game for free players; the research says
  which genres tolerate it.

### 3. Analytics

Load `rbx-instrument-analytics`. At minimum:
- **Onboarding funnel**: each step of the first 5 minutes, so you can see
  where new players quit.
- **Economy events**: currency in and out, by source and sink.
- **Custom events** for the core loop (rounds played, items collected, etc).

Without this, the weekly review is guessing.

### 4. Store page

- **Name** under ~50 characters, searchable (contains what the game is).
- **Description**: first two lines say what you do and why it's fun. Then
  controls, updates, social links. No keyword spam.
- **Icon** 512x512 and **3-5 thumbnails** 1920x1080 (roblox-blender renders,
  or the builder stages a scene in Studio and captures it). Rules:
  `blender-rules.md` > Thumbnails, and the market brief's thumbnail patterns.
  Thumbnails must match the first 3 minutes of play.
- **Genre**, devices, max players set to match the design.
- **YOU DO**: upload icon/thumbnails in Creator Dashboard (or Studio Game
  Settings), activate 2-5 thumbnails so Roblox personalizes them.

### 5. Publish and audience

**YOU DO** (walk the user through it, after checking current docs):
- File > Publish to Roblox, fill in name/description/genre.
- Content Maturity questionnaire, answered honestly.
- Account: age check / ID verification, 2-step verification.
- **All-ages release matters for money**: without it, the game only reaches
  age-checked 16+ players. Check current requirements in Creator Hub >
  Eligibility (`launch-checklist.md` lists what they were when written).
- Creator Rewards Audience Expansion needs ID verification. Set up share
  links (Creator Dashboard) for every place the game gets promoted.

### 6. Soft launch

- Release to the audience you're eligible for, invite friends, post share
  links (Discord, TikTok, YouTube Shorts of the core moment).
- First 3-7 days: watch errors (Creator Dashboard > Error Report), the
  onboarding funnel and D1 retention. Fix the biggest leak first.
- Don't buy ads until D1 and session length are at or near genre benchmarks
  (`live-ops.md`). Ads on a leaky game burn Robux.

### 7. Hand off to live-ops

Write the launch date, targets and first numbers into `design/progress.md`
and set the user up with the weekly review (`live-ops.md`). Offer to create a
scheduled weekly reminder.
