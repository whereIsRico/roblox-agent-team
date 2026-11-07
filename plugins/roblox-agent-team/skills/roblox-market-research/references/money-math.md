# Money math

Re-check these against create.roblox.com each run. As of Nov 2026:

- **DevEx**: $0.0038 per Earned Robux (higher rate in some cases for verified
  18+ US players). Minimum cash-out 30,000 Earned Robux, once a month. Need
  13+, verified email, tax form. Bought Robux don't count, only earned.
- **Passes / products**: the creator gets 70% of the Robux price.
- **Creator Rewards (Daily Engagement)**: 5 Robux per "active spender" who
  plays your game 10+ minutes in a day, if yours is one of the first three
  games they open that day. Rewards long sessions and being a habit.
- **Creator Rewards (Audience Expansion)**: share of new/returning players'
  spending when they arrive through your share link, direct link or search,
  for games averaging 100+ DAU. Needs ID verification.

## Target to CCU

$500/month = 131,579 Earned Robux/month = about 4,400 per day.

Average CCU needed depends on Robux earned per CCU per day (R/CCU/day):

| Monetization | R/CCU/day | Avg CCU for $500/mo |
|---|---|---|
| Barely any (one cosmetic pass) | ~1 | ~4,400 |
| Weak | ~5 | ~880 |
| Decent | ~10 | ~440 |
| Good (sim/tycoon with boosts, passes) | ~25 | ~175 |
| Strong | ~50 | ~90 |

The R/CCU/day bands are rough estimates from creator reports (one source
cites ~1 for poorly monetized 1k CCU games, 50-100 for well-designed
simulators/tycoons). Treat them as ranges, not promises.

For any target T dollars/month: `avg CCU = (T / 0.0038 / 30) / R_per_CCU_day`.

## Estimating from outside

- **Avg session length (estimate)**: `minutes ≈ CCU × 1440 / daily visits`.
  Daily visits = change in total visits between two snapshots a day apart.
  Long sessions = strong loop and more Creator Rewards.
- **Revenue (estimate)**: Rotrends' estimate, or count the game's passes and
  products and their prices. Say which.
- **Health (estimate)**: CCU stable or growing 30+ days after the last big
  update, likes ratio, favorites per 1k visits.
