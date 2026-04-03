# Step 14: Generate Action Plan

You are a project manager creating an operational investment roadmap for a small business. Each action is an investment with a cost to implement, an expected return, and a payback period.

---

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, pain points, budget)
- `~/.stackscan/projects/{project}/output/inefficiencies.md`
- `~/.stackscan/projects/{project}/output/tool-budget.md` -- **AUTHORITATIVE tool pricing: use these EXACT prices, do NOT pick different tiers**
- `~/.stackscan/projects/{project}/output/new-process.md`
- `~/.stackscan/projects/{project}/output/setup.md`
- `~/.stackscan/projects/{project}/output/ROI.md`
- `~/.stackscan/projects/{project}/output/risks.md`
- `~/.stackscan/projects/{project}/output/adoption-plan.md`
- `~/.stackscan/projects/{project}/output/diff.md`

Also read `~/.stackscan/projects/{project}/progress.json` to retrieve `sharedFacts.targetTools` and `sharedFacts.roles`.

---

## Task

Create an **operational investment roadmap** -- a concrete, actionable plan that this business can start executing immediately. Each phase represents a tranche of investment, and each task is framed by its cost to implement and expected return.

### Primary structure: Group by OBJECTIVE

The roadmap is organized by business objective (from intake / ROI analysis), NOT as a flat list of tool adoptions. Each objective shows what changes, investment options, and combined ROI.

Structure the output as:

```markdown
## OBJECTIVE A: "[objective from intake]"
**Current cost of not solving:** €[X]/yr
**Recommended investment level:** [which option from ROI.md, with reasoning]

### Phase 1: [Name] -- Immediate-Payback Investments (Week N-N)
**Goal:** [What this phase achieves for this objective]
**Phase investment:** [Total implementation cost for this phase]
**Expected return:** [Monthly savings unlocked by completing this phase]

| # | Task | Owner | Depends On | Est. Time | Impl. Cost | Expected Monthly Return | Priority |
|---|------|-------|------------|-----------|------------|------------------------|----------|
| 1 | [Specific, actionable task] | [Actual role from company] | - | [Realistic time] | [Cost] | [Return] | HIGH |
| 2 | ... | ... | Task 1 | ... | ... | ... | HIGH |

**Phase Go/No-Go Checklist:**
- [ ] Concrete verification step
- [ ] Concrete verification step

### Phase 2: [Name] (Week N-N)
...and so on for this objective.

## OBJECTIVE B: "[objective from intake]"
...same structure.
```

### Below Threshold section

After all primary objectives, add:

```markdown
## Below Marginal Threshold

These items have marginal benefit < marginal cost x 1.5 (from ROI.md). They are NOT recommended as primary investments but are documented for completeness.

| Item | Annual Benefit | Annual Cost | Ratio | When to Revisit |
|------|---------------|-------------|-------|-----------------|
| [description] | €[X] | €[Y] | [X/Y] | [condition that changes the math] |
```

### Not Recommended Now section

```markdown
## Not Recommended Now

These pain points were evaluated but no tool adoption is justified at this time.

- **[Pain point]:** [Why not]. Revisit when: [specific trigger condition].
- **[Pain point]:** [Why not]. Revisit when: [specific trigger condition].
```

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

- Tasks must be specific enough that someone can start doing them right now.
- Dependencies must reference specific task numbers.
- Owner must be one of the actual roles from `sharedFacts.roles` -- do NOT invent roles.
- Time estimates must be realistic for the actual team size and capacity.
- Respect the budget constraints from the company context.
- Group by priority: do the highest-ROI, lowest-risk investments first (immediate-payback investments first, then medium-term, then long-term).
- Include data migration tasks with specific steps.
- Each phase must have a Go/No-Go checklist before moving to the next.
- Final phase should include a "Measure & Adjust" section with specific KPIs drawn from the ROI analysis.
- If the tools have free tiers, recommend starting there before committing to paid plans.
- **TIMELINE ANCHOR:** The Adoption Plan (`adoption-plan.md`) defines the authoritative phased timeline. Your task board MUST use the same phase structure and week ranges. Do not invent a different timeline.

### Delegation Principle
- Assign tasks to the LOWEST-ranking role that is empowered to complete them
- The top decision-maker (CEO/owner/founder) should only own: final approvals, budget sign-offs, and strategic decisions
- Everything else should be delegated downward
- For each task, if delegation is possible, note: "Owner: [Role] (can delegate to [Lower Role] after initial setup)"
- Use the Role Agenda Map from company.md to identify which roles have capacity for new tasks
- If no subordinate roles exist (solo founder), all tasks go to them — but flag: "Consider hiring or contracting for [task type] to free up strategic time"

---

## Output Format

Format as a single markdown document with phases, task tables, and Go/No-Go checklists as shown above.

---

## Output File

Write to: `~/.stackscan/projects/{project}/output/action-plan.md`
