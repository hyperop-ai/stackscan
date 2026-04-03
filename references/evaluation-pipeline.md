# 7-Gate Tool Evaluation Pipeline

This reference describes the systematic elimination pipeline for evaluating candidate tools. The goal: eliminate cheap, evaluate deep. Most candidates die at Gates 1-3 with zero page visits. Only 2-3 survivors per pain point get the full evaluation.

---

## The 7 Gates

Run candidates through these gates IN ORDER. Each gate is pass/fail. Fail = eliminated, no further evaluation. Pass = next gate.

### Gate 1: Budget Kill (instant)

**What:** Does the tool's cheapest relevant tier fit the user's per-tool budget?

- Read price from search snippet / G2 listing
- If minimum price > user's per-tool budget, KILL
- Cost: 0 seconds (price is in search results)
- Expected kill rate: 40-60%

### Gate 2: User Hard Constraints (instant)

**What:** Does the tool violate any non-negotiable requirement?

- Check against the user's constraint list from intake (stored in progress.json as `sharedFacts.constraints`)
- Hard constraints = instant kill. No exceptions, no nuance.
- Examples: "no US-hosted tools", "must be open source", "GDPR compliant only", "must support French"
- Also check INFERRED constraints (EU location → GDPR, healthcare → compliance, etc.)
- Cost: 0 seconds (keyword match)
- Expected kill rate: 10-40% (depends on constraint count)

### Gate 3: Stack Compatibility SPECTRUM (0-5 sec)

**What:** How well does this tool connect to the user's existing tools?

This is NOT binary. Score on a compatibility spectrum:

| Level | Score | Description |
|-------|-------|-------------|
| **Native module** | 10/10 | Plugin/module for user's platform (e.g., PrestaShop Addons). Zero integration work. |
| **Official API integration** | 8/10 | Direct API integration built by either vendor. Some setup, reliable. |
| **iPaaS (Zapier/n8n/Make)** | 6/10 | Works via middleware. Adds a dependency + possible latency. |
| **CSV/Export** | 4/10 | Data exchange via export/import. Manual, error-prone, not real-time. |
| **API-capable** | 3/10 | Tool has an API but no pre-built integration. Requires dev work. |
| **No connection** | 0/10 | No way to connect at all. |

**Kill threshold depends on user's tech level:**
- Non-technical user → kill below 6 (iPaaS is their floor)
- Technical user → kill below 3 (can build API integrations)

The score is CARRIED FORWARD to Gate 6 as a comparative factor (native > Zapier even if both survive).

- Cost: 0-5 seconds (search snippet often mentions "Zapier", "API", "module")
- Expected kill rate: 15-30%

### Gate 4: Maturity Floor (5 sec per tool)

**What:** Does this tool meet the user's risk tolerance?

Check age + review count on G2/Capterra + founding year from the tool's about page. Assess maturity using the quick signals in `risk-maturity-matching.md` (founding year, review count + recency, last blog/changelog update, third-party integration activity).

Reference: See `risk-maturity-matching.md` for the full maturity spectrum, detailed assessment signals, and output formatting guidance for maturity labels and risk assessments.

Match the assessed maturity level against the user's `risk_tolerance` from `sharedFacts` (captured during intake). If `risk_tolerance` is not set, default to MEDIUM.

**Maturity spectrum:**

| Level | Signals | Description |
|-------|---------|-------------|
| **UNPROVEN** | <6 months old, <10 reviews | Brand new, unknown reliability |
| **EARLY** | 6-18 months, 10-50 reviews | Promising but unvalidated at scale |
| **GROWING** | 1-3 years, 50-200 reviews | Gaining traction, actively developing |
| **ESTABLISHED** | 3-7 years, 200-1000 reviews | Proven, stable, significant user base |
| **INDUSTRY STANDARD** | 7+ years, 1000+ reviews | Market leader, deep ecosystem |
| **LEGACY** | 10+ years but declining reviews, stale updates | Was good, now fading. Distinguish from INDUSTRY STANDARD by checking: last major update date, review sentiment trend, team hiring vs layoffs. |

**Kill thresholds by user risk tolerance:**
- Risk LOW → require ESTABLISHED or INDUSTRY STANDARD (kill EARLY/UNPROVEN)
- Risk MEDIUM → require GROWING+ (kill UNPROVEN)
- Risk HIGH → pass everything except obviously dead tools

**IMPORTANT:** INDUSTRY STANDARD and LEGACY are different. A 15-year-old tool with active development, recent updates, and growing reviews is INDUSTRY STANDARD. A 15-year-old tool with declining reviews and no updates in 18 months is LEGACY. Check the signals, not just the age.

- Cost: 5 seconds (one page glance)
- Expected kill rate: 15-30%

### Gate 5: Dealbreaker Scan (15 sec per tool)

**What:** Quick website visit to check for instant disqualifiers.

Any ONE of these = KILL:
- No free trial AND no free tier (user can't validate before paying)
- Required feature is "Enterprise only" (e.g., invoicing only in €200/mo plan)
- Tool is clearly wrong scale (enterprise UI for 2 people, or solo tool for 50)
- Language: tool not available in user's required language when it's customer-facing
- Last update >18 months ago + declining review sentiment → LEGACY KILL

- Cost: 15 seconds (scan pricing page + about page)
- Expected kill rate: 15-25%

### Gate 6: Comparative Scoring (1-2 min per tool)

**What:** Among survivors, which are BEST for this user?

Evaluate and score each 1-10:
- Actual price at user's exact scale (per-seat x team size, or per-usage x volume)
- Integration depth (native module vs Zapier vs API-only) -- use Gate 3 score
- Review sentiment for the user's SPECIFIC use case (not overall rating)
- Feature coverage for the specific pain points (100% or 70%?)
- Onboarding friction (self-service? or need consultant?)

Rank. Top 2-3 proceed.

- Cost: 1-2 minutes per tool
- Expected cut: keep top 2-3

### Gate 7: Deep Evaluation (5-8 min per tool)

**What:** What happens AFTER you adopt this tool? Full evaluation of long-term dimensions.

Evaluate:
- **Total cost of ownership:** subscription + migration + training + maintenance
- **Lock-in depth + switching cost:** How hard is it to leave? Estimate in hours and euros.
- **Dependency chain:** What breaks if this tool fails or disappears?
- **Vendor risk:** Acquisition signals, shutdown risk, pivot risk
- **Data portability:** Can you export ALL your data in standard formats?
- **Compliance:** GDPR, industry-specific, AI Act implications
- **Ecosystem health:** Community, plugins, partner network, API docs
- **Trajectory alignment:** Where is the tool going vs where is the user going?
- **Compounding vs diminishing value:** Does this tool get more valuable over time (CRM with data) or stay flat (simple automation)?

Both/all survivors are presented with full evaluation.

- Cost: 5-8 minutes per tool (involves reading ~10 web pages per tool)

---

## Funnel Transparency

ALWAYS show the user the elimination funnel. This builds trust by showing the work.

Format:

```
OBJECTIVE: "[objective name]"

Found [N] tools addressing this pain
  - [X] eliminated at Gate 1: over budget ([max price] when limit is [budget])
  - [X] eliminated at Gate 2: violated constraints ([which ones])
  - [X] eliminated at Gate 3: no viable integration with [user's tools]
  - [X] eliminated at Gate 4: too new for risk profile
  - [X] eliminated at Gate 5: dealbreakers ([specifics])
  - [X] evaluated in detail at Gate 6, top [N] presented:

Option A: [Tool] ([price] / [setup time])
  [full evaluation]

Option B: [Tool] ([price] / [setup time])
  [full evaluation]

[N] other tools passed initial filters but scored lower on [reasons].
Available on request.
```

---

## Funnel Invalidation

When the user changes a criterion mid-analysis (e.g., "actually my budget is €200/mo not €100"), you do NOT need to re-run the entire pipeline.

**How it works:**

1. Every elimination is tagged with WHICH gate killed it and WHY
2. When a criterion changes, identify which gate it affects
3. Scan eliminations for that gate only
4. Re-evaluate ONLY resurrected tools, starting from the NEXT gate (they implicitly pass the changed one)
5. Tools killed at OTHER gates are unaffected

**What to tell the user:**

```
Noted -- updated [criterion].
This resurrects [N] previously eliminated tools:
  - [Tool A] ([price]) -- re-evaluating...
  - [Tool B] ([price]) -- re-evaluating...

[Tool A] passed all remaining checks. Adding to recommendations.
[Tool B] eliminated at Gate [N]: [reason].

Updated recommendations: [re-ranked list]
```

If the change affects scoring (Gates 6-7) but not elimination, re-rank current survivors with updated weights. No tools are resurrected, but rankings may change.

---

## Dimension Weighting by Objective

The 7 deep evaluation dimensions don't all matter equally. Weight them based on the user's primary objective:

| Dimension | Growth | Profitability | Stability | Hiring prep |
|-----------|--------|--------------|-----------|-------------|
| Financial (price, TCO) | Medium | **High** | Medium | Medium |
| Lock-in & portability | Low | Medium | **High** | Medium |
| Ecosystem & dependency | **High** | Medium | **High** | Medium |
| Vendor risk | Low | Medium | **High** | Low |
| Operational quality | Medium | Medium | **High** | **High** |
| Strategic fit (trajectory) | **High** | Low | Medium | Medium |
| Hidden (cognitive, change) | Low | **High** | Medium | **High** |

State the weighting rationale in your output: "Because your primary objective is [X], I've weighted [dimensions] higher in the rankings below."

---

## Timing Budget

| Gate | Per-tool cost | After 30 initial candidates |
|------|-------------|----------------------------|
| Gates 1-2 | 0 sec | ~0 sec total |
| Gate 3 | 0-5 sec | ~15 tools x 5 sec = ~75 sec |
| Gate 4 | 5 sec | ~9 tools x 5 sec = ~45 sec |
| Gate 5 | 15 sec | ~6 tools x 15 sec = ~90 sec |
| Gate 6 | 1-2 min | ~4 tools x 90 sec = ~6 min |
| Gate 7 | 5-8 min | 2 tools x 6 min = ~12 min |
| **Total** | | **~20 min per pain point** |

For multiple pain points, results are reused where categories overlap (e.g., one "PrestaShop modules" search serves multiple pains).
