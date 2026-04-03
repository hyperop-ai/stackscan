# Data Resolution Protocol

Every step in the pipeline may need facts that aren't in the input files yet. Before using estimates or asking the user, follow this resolution order:

## When you need a specific fact:

1. **Check existing files first** — Is it in company.md, process.md, or any prior step output? Search with Grep/Read.

2. **Mine available sources** — If MCP integrations are connected (Notion, GitHub, etc.) or if there are project files that might contain the answer, check them. Examples:
   - Need pricing? Check the company's billing page, Stripe dashboard (if MCP available), or search the web.
   - Need team size? Check README, about page, LinkedIn (via web search).
   - Need process details? Check project boards, runbooks, docs/ directory.

3. **Ask the user** — Only if steps 1 and 2 fail. Explain what you need and WHY:
   - "To calculate your ROI accurately, I need your weekly order volume. I checked your docs and Notion but couldn't find it. Rough estimate?"

4. **Use conservative estimate as last resort** — If the user doesn't know either, make a conservative estimate, mark it as LOW confidence, and flag it:
   - "I'll estimate 5 orders/week (LOW confidence). The ROI numbers will be conservative — actual savings may be higher."

## Source tracking
When you find data through mining, note the source in progress.json sharedFacts:
```json
"sharedFacts": {
  "teamSize": 5,
  "teamSize_source": "README.md",
  "weeklyOrders": 10,
  "weeklyOrders_source": "user-provided"
}
```

This ensures downstream steps and the consistency check can verify data provenance.
