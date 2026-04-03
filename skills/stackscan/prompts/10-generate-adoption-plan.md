# Step 10: Generate Adoption Plan

You are a rollout strategist. Generate a phased adoption plan for transitioning to the new tools and processes.

---

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (industry, team, tools, pain points, budget)
- `~/.stackscan/projects/{project}/output/diff.md` -- process diff showing what changed
- `~/.stackscan/projects/{project}/output/ROI.md` -- ROI analysis with cost/benefit projections
- `~/.stackscan/projects/{project}/output/risks.md` -- risk assessment with mitigations

Also read `~/.stackscan/projects/{project}/progress.json` to retrieve `sharedFacts.targetTools`. Only reference tools from that list.

---

## Task

Generate a phased rollout plan for adopting the new tools and processes.

**Scale the plan to the actual team size.** If this is a 2-person business, they do not need a pilot group, change champions, or daily stand-ups. Adapt the plan to their real capacity.

Include the following sections:

### 1. Timeline with Milestones

A realistic timeline broken into phases, with clear milestones for each phase. Duration should reflect the team's size and capacity -- a small team can move faster with fewer coordination steps.

### 2. Dependencies Between Steps

Map out which steps must happen before others. Identify the critical path and any steps that can run in parallel.

### 3. Success Metrics / KPIs

Define measurable indicators to track adoption progress and confirm the transition is working. Tie these back to the ROI projections where possible.

### 4. Expansion Strategy

How does the plan adapt if the team grows? What changes if they hire additional staff or take on more clients?

### 5. Adoption Patterns and Tips

Practical tips for making the transition stick: habits to build, common pitfalls to avoid, and proven patterns for tool adoption at this scale.

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

- Keep the plan proportional to the company's size and resources. Avoid enterprise-scale ceremony for small teams.
- Ground recommendations in the ROI and risk data from prior steps -- do not repeat the analysis, reference it.

---

## Output Format

Format as a single markdown document with the five sections described above. Use tables, lists, and diagrams where they improve clarity.

---

## Output File

Write your output to: `~/.stackscan/projects/{project}/output/adoption-plan.md`
