# Build ledger

Keep `build-log.md` in the working folder. Append as things happen, not from
memory at the end. One file per project, newest run at the top.

```markdown
# Run: <goal> (<date> <start time>)

## Plan
<one-paragraph summary, link to design/game-plan.md if any>

## Log
- 10:42 T1 done (scripter): CoinService + Net remotes
- 10:58 STALL T3: generate_mesh failed 3x, used greybox crates
- 11:05 REVIEW FAIL: coin remote not rate-limited

## Debts
| # | What | Why | Fix type | Status |
|---|---|---|---|---|
| D1 | crates are greybox parts | generate_mesh kept failing | code fix: replace with mesh | open |
| D2 | no rate limit on CollectCoin | missed in T1 | code fix | fixed 11:12 |

## Result
<reviewer verdict, what's left open and whether the user accepted it>
```

Fix types, strongest first: **code fix** (can't happen again) > **guard**
(fails loudly in Output) > **note** (written down only).

The run is not finished while any debt is `open`. It's either `fixed` or
`accepted by user`.
