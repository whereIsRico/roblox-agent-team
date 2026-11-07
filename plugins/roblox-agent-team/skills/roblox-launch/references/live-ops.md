# Weekly live-ops review

Run once a week. Pull numbers from Creator Dashboard > Analytics (the user may
need to paste them or screenshot them; the Studio MCP can't read the
dashboard). Write the review to `design/weekly/<date>.md`.

## The numbers

| Metric | Where | Healthy (rough, by genre) |
|---|---|---|
| D1 retention | Analytics > Retention | obby 25-35%, tycoon 20-28%, shooter 22-30%, roleplay 15-22% |
| D7 retention | same | tycoon 12-18%, shooter 12-16%, obby 10-15% |
| Avg session length | Engagement | 15+ min for most loops (also drives Creator Rewards) |
| QPTR (qualified play-through rate) | Acquisition | at or above the "similar experiences" benchmark shown |
| Payer conversion, ARPPU | Monetization | compare week over week |
| Earned Robux / day | Monetization | target: ~4,400/day for $500/month |
| Onboarding funnel | Analytics > Funnels | biggest drop-off step |
| Errors | Error Report | zero new from our scripts |

Benchmarks above are one analyst's genre guidance (RoWatcher, July 2026). The
benchmarks Roblox shows in your own dashboard against similar games are
better; prefer those when available.

## The decision

Pick **one** thing to change this week, from the biggest problem:

1. Errors → fix them first, always.
2. Low QPTR → thumbnails/icon/name don't match what players want, or the
   first minute disappoints. Test new thumbnails (keep 2-5 active), fix the
   first 60 seconds.
3. Bad onboarding funnel / low D1 → fix the step where people quit. Clearer
   goal, faster first reward.
4. Low D7 → missing return loop: daily rewards, timed goals, collections,
   rebirths, events, friends.
5. Good retention, low revenue → monetization: a starter offer, better
   placement of the shop, a pass players actually want (look at what leaders
   sell).
6. Everything healthy → grow: update with new content + new thumbnails,
   share-link pushes, small ad tests.

Then hand the change to the orchestrator as a normal job, and log it in the
weekly file so next week can see if it worked.

## Updates

- Ship a meaningful update every 1-2 weeks early on. Each update: changelog
  in the description, new thumbnails if it adds something visual.
- Change one big thing at a time where possible, so the numbers tell you what
  worked.
