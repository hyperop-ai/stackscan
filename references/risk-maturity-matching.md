# Risk Profile Matching

Match tool maturity to user risk tolerance for every recommendation.

## Tool maturity spectrum

| Level | Signals | What it means |
|---|---|---|
| UNPROVEN | Just launched, <5 reviews, unknown team | Could be a weekend project. High failure risk. |
| EARLY | <6 months, <10 reviews, small team | Still finding product-market fit. May pivot. |
| GROWING | 6mo-2yr, 10-100 reviews, some funding | Gaining traction but not proven long-term. |
| ESTABLISHED | >2yr, >100 reviews, profitable or funded | Reliable. Low risk. |
| INDUSTRY STANDARD | >5yr, >1000 reviews, dominant share | The default choice. Near-zero risk. |
| LEGACY | >5yr, BUT declining reviews, stale updates | May be dying. Risk to ADOPT, may be OK to KEEP. |

### How to assess maturity (quick signals)

- Age: founding year from about page or WHOIS
- Reviews: G2/Capterra count + recency
- Activity: last blog post, changelog update, social media post
- Ecosystem: are third parties still building integrations?

### Industry standard vs Legacy (for old tools)

Check vitality: recent updates? growing reviews? active community? new integrations?
- Vitality positive → INDUSTRY STANDARD (safe)
- Vitality negative → LEGACY (flag: "shows signs of declining support")

## User risk tolerance (from intake)

| Tolerance | Accept tools rated... | Reject tools rated... |
|---|---|---|
| LOW | ESTABLISHED, INDUSTRY STANDARD | UNPROVEN, EARLY, LEGACY |
| MEDIUM | GROWING and above | UNPROVEN |
| HIGH | Everything except obviously dead | Nothing (evaluate all) |

## How to show in output

For each recommended tool, include:
```
Maturity: ESTABLISHED (5 years, 450+ reviews, active development)
Risk for your profile: Low — this is a proven tool that matches your preference for stability
```

For new tools that are potentially disruptive:
```
⚠ New tool alert: [Tool] launched 3 months ago. If it works as described,
it could save 80% of your [pain] time. But it's EARLY — limited reviews, small team.
Your risk profile is LOW, so: add to watchlist, revisit in 6 months.
```

For legacy tools the user currently uses:
```
⚠ Legacy signal: [Tool] shows declining update frequency and community activity.
You currently use it. Switching cost is [estimate]. Consider: is it worth migrating
now, or ride it until a clear replacement emerges?
```
