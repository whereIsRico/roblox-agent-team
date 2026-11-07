---
name: roblox-market-research
description: Researches the Roblox market to find game ideas a solo dev can build that can earn at least a revenue target (default $500/month): games and loops already earning that, rising loops, what players actually respond to (mechanics, thumbnails, retention signals, monetization), and money math. Produces a ranked opportunity brief that feeds the roblox-orchestrator game plan. Use when picking a new game to make, checking a trend, or studying why top games work.
---

# Roblox Market Research

You run the research. Scouts gather; you judge. The deliverable is a ranked
opportunity brief a solo dev can act on, not a list of popular games.

## The thinking that matters most

1. **The target is money, not CCU.** The goal is at least $500/month (or
   the user's number). Work backwards with `money-math.md`: at decent
   monetization that's a few hundred average CCU, not thousands. So the most
   useful games to study are **comparable wins**: small-to-mid games
   (roughly 100-3,000 CCU) that are plausibly already earning the target. If
   several games in a loop clear the bar, the loop is proven. Look at the
   loop's leaders too, but only to learn what works, not as the bar.
2. **Rising beats big.** A game at 400k CCU is owned by a studio with ad
   money. What matters is a loop that's *growing*, with few good competitors
   and room for a better version. Compare against last week and last month.
3. **Trend speed vs build speed.** Roblox fads can peak and die in weeks. If
   a solo dev needs 6-8 weeks to ship and the trend is 3 weeks old and
   already flooded with copies, it's too late. Evergreen loops (tycoon,
   obby, simulator, roleplay, horror, sports) are slower but safer.
4. **Survivorship bias.** For every hit there are hundreds of copies at 10
   CCU. Look at the copies too: if 50 clones of a hit are all dead, the hit
   won on something else (a YouTuber, a brand, timing, ad spend). Find out
   what.
5. **Measured vs estimated.** CCU and visits are measured. Revenue, retention
   and session length from outside are estimates. Label every number with
   which it is and where it came from. Never present an estimate as fact.
6. **Clickbait doesn't work anymore.** Roblox recommends games by Qualified
   Play-Through Rate (people who see it AND actually play, not just click).
   A thumbnail that over-promises gets people who leave in 60 seconds, and
   the algorithm buries it. Thumbnails must match the first 3 minutes.

## Inputs

Ask the user only if missing (otherwise use defaults):
- **Revenue target**: default $500/month.
- **Build budget**: default solo dev with this agent team, about 4-8 weeks to
  a first playable release.
- **Genres to include/exclude**: default open.
- **Age of trend allowed**: default prefer evergreen or trends under ~2 weeks.

## Workflow

Make a folder `research/<YYYY-MM-DD>/` in the working directory. Everything
goes there.

### 1. Market scan (you)

Get a current snapshot of (a) **comparable wins**: games around 100-3,000 CCU
whose estimated revenue or monetization suggests they clear the target, (b)
**risers** at any size, and (c) the leaders of any loop that shows up in (a)
or (b). No fixed CCU cutoff. Sources, best first:
- **ccucheck.com**: live top games, player history, genres, biggest movers,
  new finds.
- **rotrends.com**: trending lists, genre stats, avg CCU, estimated revenue,
  likes/favorites per 1k visits. Free core, Pro is paid.
- **Roblox's own Charts / Discover pages** and game pages for visits, likes,
  favorites, created and updated dates.
- **profitable.app**: revenue estimate distributions by genre/CCU (it's a
  model from visits, so label as estimate).

Write `scan.csv`: name, link, genre, CCU now, CCU trend (7d/30d if
available), visits, created date, last update, like ratio, est. monthly
revenue (and method), clears target? (yes/maybe/no), source.

If `research/ccu-history.csv` exists from earlier runs, append today's
numbers and use the history for growth. This is how the research gets smarter
every time it runs.

### 2. Cluster and shortlist (you)

Group the scan by **core loop**, not by name. "Steal a ___" games are one loop.
For each loop: how many games plausibly clear the target, how many dead
copies, is it rising or falling, how old is it, and what the smallest game
that clears the target looks like (that's the realistic bar for us).

Shortlist 3-5 loops that look like real opportunities. Write one sentence
each on why.

### 3. Deep dives (fan out scouts, parallel is safe: they don't touch Studio)

Spawn one **roblox-scout** per shortlisted loop. Brief:

```
OBJECTIVE   Deep-dive the "<loop>" loop. 1-2 leaders, 2-3 smaller games that
            plausibly earn the target, and 2-3 failed copies.
OUTPUT      research/<date>/<loop-slug>.md in the scout format.
            Thumbnails saved to research/<date>/thumbs/<loop-slug>/.
TOOLS       Sources above; the signals checklist at <abs path to signals.md>.
BOUNDARIES  This loop only. Measured vs estimated on every number. Every URL
            you cite you actually opened. Stop after ~25 tool calls and report
            what you have.
```

### 4. Score (you)

Read every scout file and the thumbnails yourself. Score each loop with the
rubric in `scoring.md`. Run the money math from `money-math.md` for the user's
target. Check scout claims against the source when a score depends on it: a
scout's number is a claim until you've seen it.

### 5. Brief (you)

Write `research/<date>/brief.md`:

```markdown
# Market brief <date>
Target: $<x>/month. Build budget: <x>.

## Top pick
<loop> - one paragraph: the gap, why a solo dev can win it, the 3 things the
version we build must do better than the current leaders.

## Ranked opportunities
| # | Loop | Demand | Competition | Trend | Build cost | Monetization fit | Score |

## For each (top 3)
- Proof it pays (games in this loop that plausibly clear the target, measured + estimated): ...
- What players actually respond to: mechanics, hooks, session pattern
- Thumbnail patterns that work here (with examples from /thumbs)
- Retention signals (estimated, with method)
- Monetization: what the leaders sell, at what Robux prices
- Money math: CCU needed for the target at low/mid/high monetization
- Risks: timing, saturation, IP, things that need a big team
- First playable (Phase A) in 5 bullets

## Avoid
<loops that look tempting but aren't, and why>

## Sources
```

Then offer to turn the top pick into `design/game-plan.md` for the
roblox-orchestrator (sections 2, 3, 5, 6, 16 come straight from the brief).

## Rules

- Don't recommend cloning a game. Recommend a better or different version of
  a loop. Never copy names, art, thumbnails or branded IP.
- Don't hammer sites. Fetch what you need, cache in the research folder,
  reuse it.
- Facts about Roblox's systems (payout rates, algorithm, analytics features)
  change. Re-check the official docs (create.roblox.com) each run rather
  than trusting old numbers, including the ones in these references.
