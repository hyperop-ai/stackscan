# Step 7: Calculate ROI

This is the core investment analysis -- the numbers produced here drive every decision downstream. Present results as ranked investment opportunities, not just savings calculations.

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, budget, hourly rates)
- `~/.stackscan/projects/{project}/process.md` -- current (old) process documentation
- `~/.stackscan/projects/{project}/output/new-process.md` -- redesigned process
- `~/.stackscan/projects/{project}/output/inefficiencies.md` -- inefficiency analysis with per-operation breakdowns
- `~/.stackscan/projects/{project}/output/tool-budget.md` -- authoritative tool pricing and tiers

## Task

Calculate ROI by comparing the old and new processes -- treat each proposed change as a potential investment and quantify its return. Extract from the company context: budget limits, team size, locale, and derive realistic hourly rates for the region and business type. If no hourly rate is available, use $50/hr as the default.

### Time Savings

For EACH task area, provide an atomic breakdown table:

| Operation | Per-unit time (before) | Per-unit time (after) | Volume/week | Source | Confidence | Weekly savings |
|-----------|----------------------|---------------------|-------------|--------|------------|---------------|

**Worked example (follow this format exactly):**

| Update stock book | 5 min | 1 min | 20/week | benchmark | HIGH | (5-1) x 20 = 80 min |

### Source column (REQUIRED for every row)

- **client-data**: from company information or client-provided time estimates (quote the source)
- **benchmark**: industry standard (cite briefly)
- **research**: from research findings (cite the tool feature and source URL)
- **tool-docs**: capability documented in the tool's product pages (cite the feature)
- **estimate**: educated guess (explain reasoning)

### Confidence column (REQUIRED for every row)

- **HIGH**: client-provided data, well-established benchmarks, or documented tool capabilities
- **MEDIUM**: reasonable inference from context
- **LOW**: educated guess with no supporting data

### Cost Analysis

Calculate and provide:

1. **Tool costs** (monthly/annual) -- use ACTUAL pricing from tool-budget.md. Do not select different pricing tiers than those listed.
2. **Training costs** (one-time) -- scaled to the actual team size.
3. **Implementation costs** (one-time) -- realistic for this business size.
4. **Net monthly savings** = time savings value - monthly tool costs.
5. **Payback period** = total implementation costs / net monthly savings.

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Time Decomposition Rule** -- every task must have per-unit x volume breakdown
- **Automation Ceiling Rule** -- time saved must not exceed 70% of current time
- **Grounding Rule** -- only reference tool features that appear in research findings or tool documentation
- **Pricing Verification Rule** -- use only pricing from tool-budget.md or research findings
- **Escalation Check Rule** -- flag analyses with too many LOW-confidence estimates
- **Math Transparency Rule** -- every savings figure, cost, net return, and ROI percentage must show the full calculation inline

### Step-specific rules

- NEVER give a single "saves 5 hours/week" without the per-unit x volume breakdown.
- The "after" time must be justified -- if a tool automates something, cite the specific feature from research findings.
- Show the calculation in the Weekly savings column: "(before - after) x volume = result".
- If inefficiencies.md was provided, use its EXACT operations, volumes, and per-unit "before" times. Do not change "15 clients/week" to "5 clients/week" or any other number -- use what the inefficiencies analysis established.
- If tool-budget.md was provided, use the EXACT tiers and prices listed there. Do not select different pricing tiers.
- Every "after" time must be >= 1 minute. Zero is forbidden.

## Reasoning Chain

Show your reasoning explicitly:

1. For each operation, state the before time and its source.
2. Justify the after time with specific tool capabilities from research or tool-budget.md.
3. Show the arithmetic step by step.
4. Cross-check totals against the automation ceiling.

## Validation

After calculating total weekly savings, perform these checks:

1. **Automation rate**: Calculate automation_rate = total_weekly_saved / total_weekly_before_time. If this exceeds 70%, you MUST revise "after" times upward until the rate is at or below 70%. Show the revised table.
2. **Minimum after time**: Verify every "after" time is >= 1 minute. Zero is not allowed.
3. **Team capacity check**: Total current weekly time cannot exceed team capacity (teamSize x 40 hours/week). Total savings cannot exceed actual working hours.

## Escalation Check

After completing the analysis:

1. Count how many rows have Confidence=LOW.
2. If >50% are LOW: add prominently at the top: "ESCALATION: [X]% of time estimates are educated guesses (LOW confidence). This ROI projection should be treated as indicative only."
3. If >30% are LOW: add: "NOTE: Several time estimates ([X]%) are unverified. Recommend client validation."

## Marginal Returns Analysis

After calculating per-recommendation ROI, apply the marginal returns threshold to each recommendation:

**For each recommendation, calculate:**
- Marginal benefit = annual value of solving this pain point
- Marginal cost = annual subscription + (setup hours x hourly rate) amortized over 12 months + cognitive overhead of another tool in the stack (estimate: €5-15/mo per tool depending on complexity)

**Threshold rule:** If marginal benefit < marginal cost x 1.5, the recommendation does NOT have clear ROI. Move it to a "Below Threshold" section. The 1.5x multiplier accounts for adoption risk and the certainty discount -- uncertain benefits must meaningfully exceed certain costs.

Show the math for every recommendation:
```
[Tool]: Marginal benefit €X/yr vs Marginal cost €Y/yr (= €Z subscription + €W setup amortized + €V cognitive overhead)
Ratio: X/Y = [ratio]. [ABOVE THRESHOLD / BELOW THRESHOLD]
```

## Dynamic Investment Levels per Objective

For each objective detected during intake (from `sharedFacts.objectives` or inferred from pain points), find solutions at DIFFERENT investment levels calibrated to THIS business's actual budget and capacity.

**Do NOT use hardcoded labels like "Minimal / Recommended / Maximum."** Instead, present concrete options with real numbers. The investment levels emerge from what's actually available for this business.

For each objective:

```
### OBJECTIVE: "[objective name]"
Current cost of NOT solving: €[X]/yr

**Option 1: [Tool/approach] — €[cost]/mo + [setup hours] setup**
  Annual return: €[X] | Net ROI: [X]% | Payback: [X] months
  What you get: [concrete description]

**Option 2: [Tool/approach] — €[cost]/mo + [setup hours] setup**
  Annual return: €[X] | Net ROI: [X]% | Payback: [X] months
  What you get: [concrete description]
  vs Option 1: [what additional value, where diminishing returns start]

**Option 3: [Tool/approach] — €[cost]/mo + [setup hours] setup**
  Annual return: €[X] | Net ROI: [X]% | Payback: [X] months
  What you get: [concrete description]
  vs Option 2: [marginal gain is smaller — diminishing returns visible here]
```

Always include a free/zero-cost option if one exists. Let the user see diminishing returns visually -- when a more expensive option has LESS net ROI than a cheaper one, that's visible in the numbers.

## Cross-Objective Bundling

After presenting per-objective options, identify tools that appear in MULTIPLE objectives. Highlight the combined value:

```
### Cross-Objective Bundle: [Tool Name]
Appears in: Objective A, Objective C, Objective D
Combined annual value across all objectives: €[X]
Single subscription cost: €[Y]/yr
Combined ROI: [Z]%
This is the highest-impact single investment because it solves [N] objectives with one tool.
```

## Output Format

Format as a detailed markdown report with the following sections:

1. **Time Savings Analysis** -- per-task-area tables with atomic breakdowns.
2. **Summary** -- total weekly time saved, monthly time saved, monthly value (using hourly rate).
3. **Cost Analysis** -- tool costs, training costs, implementation costs.
4. **Net Savings** -- net monthly savings, payback period.
5. **Investment Portfolio Summary** -- rank each proposed change as an investment opportunity using this table:

| Rank | Investment (proposed change) | Implementation cost | Annual return | ROI % | Payback period | Risk level |
|------|------------------------------|---------------------|---------------|-------|----------------|------------|
| 1 | ... | ... | ... | ... | ... | LOW/MED/HIGH |

Sort by ROI % descending. This table gives the decision-maker a single view of where to allocate operational capital.

**Precision requirement:** In the Investment Portfolio Summary table, use EXACT calculated figures, not approximations. Annual return = monthly savings x 12. Do not round.

**ROI headline numbers MUST include both the return AND the investment cost.** Not just "net monthly return €159" but "net monthly return €159 (= €208 time savings - €49 tool costs)".

6. **Marginal Returns Analysis** -- per-recommendation threshold check (benefit vs cost x 1.5). Split into "Clear ROI" and "Below Threshold" sections.
7. **Investment Levels per Objective** -- for each objective, concrete options at different investment levels with diminishing returns visible.
8. **Cross-Objective Bundles** -- tools that serve multiple objectives with combined value.
9. **Below Threshold** -- recommendations where benefit < cost x 1.5. Include the math. Note when to revisit (e.g., "revisit when volume exceeds X/month").
10. **Not Recommended Now** -- pain points where no tool justifies adoption. State why and when conditions would change.
11. **Validation** -- automation rate check, capacity check.
12. **Escalation Check** -- confidence assessment (if applicable).

## Key Assumptions for Confirmation

List the top 5 assumptions that most affect the ROI numbers. For each:
- **The assumed value** and unit
- **Source:** client-data / benchmark / research / estimate
- **Confidence:** HIGH / MEDIUM / LOW
- **Sensitivity:** What changes if this assumption is wrong? (e.g., "If hourly rate is actually €35/hr instead of €25/hr, annual savings increase by 40%")

Focus on: hourly rate, task volumes, tool pricing tiers, implementation time estimates, and adoption timeline assumptions.

## Output File

Write to: `~/.stackscan/projects/{project}/output/ROI.md`
