# Step 3: Identify Operational Cost Leaks

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, pain points)
- `~/.stackscan/projects/{project}/process.md` -- current process documentation

## Task

Analyze the company and process information to identify operational cost leaks -- places where time and money drain out of the business and that represent potential investment targets.

For EACH cost leak, decompose it into atomic operations using this table format:

| Operation | Per-unit time | Volume/week | Source | Confidence | Weekly total |
|-----------|--------------|-------------|--------|------------|-------------|
| [specific action, e.g. "Look up client in Excel"] | [time per occurrence] | [how many times/week] | [see below] | [see below] | [per-unit x volume] |

### Source column (REQUIRED for every row)

- **client-data**: number comes from the company information above (quote the source)
- **benchmark**: industry standard or well-known reference (cite it briefly)
- **research**: from research findings above (cite the source URL)
- **estimate**: your educated guess (explain your reasoning in a footnote)

### Confidence column (REQUIRED for every row)

- **HIGH**: based on client-provided data or well-established benchmarks
- **MEDIUM**: reasonable inference from context (e.g., deriving weekly sales from stated revenue)
- **LOW**: educated guess with no supporting data

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Time Decomposition Rule** -- every task must have per-unit x volume breakdown
- **Automation Ceiling Rule** -- time saved must not exceed 70% of current time
- **Escalation Check Rule** -- flag analyses with too many LOW-confidence estimates
- **Math Transparency Rule** -- every time total, weekly cost, and annual waste figure must show its derivation inline

- **Role Agenda Rule** -- cross-check total savings against role time allocations. If no role agenda map exists, flag the gap.

### Step-specific rules

- NEVER give a single weekly/monthly total without the per-unit x volume breakdown.
- Every row must have BOTH a per-unit time AND a volume -- no exceptions.
- Decompose coarse tasks into specific actions (not "data entry: 5 hrs" but each step of the data entry process).
- Use minutes as the unit for per-unit time, hours only for weekly/monthly totals.
- Be conservative -- when uncertain, estimate LOW rather than HIGH time savings.
- When research findings provide benchmarks, USE THEM and cite the source.

## Reasoning Chain

Show your reasoning step by step:

1. First, identify the major process areas where operational budget is spent.
2. For each area, list the atomic operations -- this is the operational waste quantification.
3. Estimate times with explicit justification.
4. Cross-check totals against team capacity.

## Validation

After listing all inefficiencies, add a **Plausibility Check** section:

1. Sum all weekly totals.
2. Calculate what percentage of total team capacity this represents (extract team size and working hours from company context; capacity = teamSize x 40h).
3. If the total exceeds 40% of team capacity, flag it: "HIGH ADMIN BURDEN -- these estimates suggest the team spends [X]% of their time on admin. Verify with the client."
4. If >50% of your rows have Source=estimate and Confidence=LOW, add: "ESCALATION: Most time estimates are educated guesses. These numbers need client validation before using them for ROI calculations."

## Output Format

Format as markdown with clear headings per cost leak category. Each category must include:

1. A description of the cost leak and why it is an investment target.
2. The atomic breakdown table (as shown above) -- the operational waste quantification.
3. A subtotal of weekly time and estimated weekly cost for that category.
4. **Financial signal — Estimated annual waste: €X (= weekly_cost × 52)**. This is required for every cost leak category.

Rank cost leak areas by annual waste -- highest first.

End with:
- A **Total estimated annual operational waste: €X** line summing all cost leak categories. This total becomes `sharedFacts.runningROI.estimatedAnnualWaste`.
- The Plausibility Check section.

## Key Assumptions for Confirmation

List the top 5 assumptions that most affect the numbers in this analysis. For each:
- **The assumed value** and unit
- **Source:** client-data / benchmark / research / estimate
- **Confidence:** HIGH / MEDIUM / LOW
- **Sensitivity:** What changes if this assumption is wrong? (e.g., "If artwork volume is actually 3/month instead of 8, the annual waste estimate drops from €2,362 to €885")

## Output File

Write to: `~/.stackscan/projects/{project}/output/inefficiencies.md`
