# Shared Rules Reference

Cross-cutting constraints that apply across pipeline steps. Every prompt must follow the relevant rules listed here.

---

## Investment Decision Framing

- All outputs should frame findings as investment decisions, not just process improvements.
- Lead with financial impact (cost, savings, payback period, net return) before operational details.
- Use investment language: **allocate**, **invest**, **return**, **payback**, **portfolio**, **capital** — not just optimize, improve, streamline.
- Position tool adoption as capital allocation: the client is choosing where to deploy operational budget for maximum return.
- Every recommendation should answer: "What is the expected return on this operational investment?"
- **Financial Signal (mandatory in every step report):** Every step must estimate the monetary impact of its findings as a preliminary ROI signal:
  - Inefficiency analysis: "This cost leak wastes ~€X/year (= time × rate × 52)"
  - Tool evaluation: "Current stack ROI is approximately €X return per €Y spent"
  - Risk assessment: "If realized, this risk could cost ~€X (= probability × impact estimate)"
  - Process design: "This change is expected to save ~€X/month (= time saved × hourly rate)"
  - These are PRELIMINARY estimates — the formal ROI calculation in step 7 is authoritative
- **Running ROI tally:** Maintain a running estimate in sharedFacts.runningROI across steps. This gives the user a sense of direction before the formal calculation.

---

## Role Agenda Rule
Before calculating time savings for any role, check the Role Agenda Map in company.md:
- Total savings for a role MUST NOT exceed their allocated time for the activity being optimized
- Example: if a gallerist spends 8 hrs/week on admin, max savings = 8 × 0.7 = 5.6 hrs/week
- If no role agenda exists, flag: "⚠️ Role time allocation unknown — savings estimates may exceed realistic bounds"
- Cross-reference: if you claim to save 10 hrs/week on admin but the role only does 8 hrs of admin, reduce the estimate

---

## Automation Ceiling Rule

- Total weekly time saved MUST NOT exceed 70% of total current weekly time spent on these tasks.
- Even fully automated tasks require monitoring, exception handling, and occasional manual intervention.
- "After" time of 0 minutes is FORBIDDEN -- every task needs at least 1 minute per occurrence for oversight.
- If your calculation exceeds 70%, increase "after" times to reflect oversight, exceptions, and maintenance.

---

## Grounding Rule

- You may ONLY reference tool features that appear in the research findings or tool documentation provided.
- If a tool has no documentation, state: "Documentation unavailable -- features unverified."
- Do NOT assume integrations exist between tools unless documentation explicitly mentions them.
- Flag unverified features with: "Unverified -- verify with vendor before implementation."

---

## Time Decomposition Rule

For EACH task area, provide an atomic breakdown table:

| Operation | Per-unit time | Volume/week | Source | Confidence | Weekly total |
|-----------|--------------|-------------|--------|------------|-------------|

### Source column (REQUIRED for every row)

- **client-data**: from company information (quote the source)
- **benchmark**: industry standard (cite briefly)
- **research**: from research findings (cite the source URL)
- **estimate**: educated guess (explain reasoning)

### Confidence column (REQUIRED for every row)

- **HIGH**: client-provided data, established benchmarks, or documented capabilities
- **MEDIUM**: reasonable inference from context
- **LOW**: educated guess with no supporting data

### Rules

- NEVER give a single weekly/monthly total without the per-unit x volume breakdown.
- Every row must have BOTH a per-unit time AND a volume.
- Use minutes as the unit for per-unit time, hours only for weekly/monthly totals.
- Be conservative -- when uncertain, estimate LOW rather than HIGH time savings.

---

## Team Size Scaling Rules

### Very small team (3 or fewer)

- Do NOT suggest enterprise patterns.
- No pilot groups, change champions, or daily stand-ups.
- No dedicated project manager role.
- Combine phases where possible -- they cannot spend weeks on adoption.
- Prefer self-service setup over formal training programs.
- Budget constraints are tight -- prioritize free tiers and essential-only features.

### Small team (4--10)

- Scale recommendations accordingly.
- One champion is enough, not a committee.
- Keep phases short and practical.
- Training can be informal (screen shares, not formal sessions).

### Medium team (11+)

- Some structure is appropriate but avoid over-engineering.
- One or two champions, not a full change management team.

---

## Pricing Verification Rule

- Use ONLY pricing tiers from research findings or tool-budget.md.
- If pricing was not found in research, write: "Pricing not verified -- check vendor website."
- Do NOT guess or approximate pricing.
- If tool-budget.md exists, use those EXACT tiers and prices -- do not select different ones.
- Total monthly costs must be identical across setup.md, ROI.md, action-plan.md, and adoption-summary.md.

---

## Escalation Check Rule

After completing your analysis:

1. Count how many estimates have Confidence = LOW.
2. If > 50% are LOW: add prominently -- "ESCALATION: Most estimates are educated guesses. This analysis needs client validation."
3. If > 30% are LOW: add -- "NOTE: Several estimates are unverified. Recommend client validation."

---

## Confidence Markers

Use these labels on every estimate:

| Level | Definition |
|-------|-----------|
| **HIGH** | Client-provided data, established benchmarks, or documented capabilities |
| **MEDIUM** | Reasonable inference from context |
| **LOW** | Educated guess with no supporting data |

---

## Math Transparency Rule

Every number in a report MUST show its derivation inline. Never present a bare number.

Format: `result (= formula)`

Examples:
- Time savings: "109 min/week (= 35 min × 2 artworks/wk + 15 min × 3 invoices/wk + ...)"
- Monetary values: "€2,362/year (= 109 min/wk × €25/hr ÷ 60 × 52 wk)"
- Net values: "Net monthly return €159 (= €208 savings - €49 tool costs)"
- ROI percentages: "ROI 312% (= €2,362 return ÷ €756 investment × 100)"
- Payback: "1.6 months (= €250 setup cost ÷ €159/mo net savings)"

Rules:
- NEVER present a bare number without showing the calculation
- For summary/brief documents: show at minimum the top-level formula
- For detailed analysis: show every intermediate calculation
- ROI headline numbers MUST include both the return AND the investment cost
- If math involves more than 3 chained operations, show step by step

---

## Source Attribution

Tag every data point with one of:

| Tag | Meaning |
|-----|---------|
| **client-data** | From company information (quote the source) |
| **benchmark** | Industry standard (cite briefly) |
| **research** | From research findings (cite the source URL) |
| **estimate** | Educated guess (explain reasoning) |
