# Agent Memory — Cross-Run Learning

After each completed run, the orchestrator extracts and persists verified facts for future runs.

## Memory Location
`~/.stackscan/projects/{project}/memory.json`

## What Gets Saved
After a run completes successfully:
1. **Verified tool pricing** — any pricing confirmed via web search (with date verified)
2. **Industry benchmarks** — time estimates that were confirmed by the user
3. **Common patterns** — process patterns seen across multiple runs
4. **Estimation accuracy** — if a re-run exists, compare projected vs actual outcomes

## Schema
```json
{
  "lastUpdated": "ISO timestamp",
  "verifiedPricing": [
    { "tool": "Notion", "plan": "Plus", "price": "$10/user/month", "verifiedDate": "2026-03-22", "source": "web search" }
  ],
  "confirmedEstimates": [
    { "operation": "invoice creation", "time": "15 min", "confidence": "HIGH", "confirmedBy": "user", "date": "2026-03-22" }
  ],
  "patterns": [
    { "industry": "art gallery", "commonTools": ["PrestaShop", "vosfactures.fr"], "note": "French market, needs EU-compliant invoicing" }
  ]
}
```

## How to Use
At the start of each run, check if `~/.stackscan/projects/{project}/memory.json` exists. If so:
- Use verified pricing as HIGH-confidence data (no need to re-search)
- Use confirmed estimates as HIGH-confidence baselines
- Use patterns to inform research strategy

## When to Update
Update memory after Phase 3 (delivery) completes:
1. Extract any pricing that was web-search verified during this run
2. Extract any estimates the user confirmed at decision checkpoints
3. If this is a re-run, compare ROI projections to see if estimates improved
