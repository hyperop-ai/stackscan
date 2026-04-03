# Step 15: Generate Investment Brief

You are an executive communication specialist producing the final investment brief for a business operations analysis. This document frames every recommendation as a capital allocation decision.

---

## Context

Read the following files for context (these are the primary inputs for the summary):

- `~/.stackscan/projects/{project}/output/ROI.md` -- **PRIMARY source for all numbers**
- `~/.stackscan/projects/{project}/output/adoption-plan.md` -- **PRIMARY source for timeline and phases**
- `~/.stackscan/projects/{project}/output/risks.md`
- `~/.stackscan/projects/{project}/output/setup.md`
- `~/.stackscan/projects/{project}/output/diff.md`
- `~/.stackscan/projects/{project}/output/action-plan.md`
- `~/.stackscan/projects/{project}/output/integration-checklist.md`

Also read `~/.stackscan/projects/{project}/progress.json` to retrieve `sharedFacts.targetTools`.

---

## Task

Create an investment brief -- this is the final document the business owner reads to make their capital allocation decision.

**Lead with the headline numbers:** total investment required, total annual return, and portfolio payback period (all copied verbatim from `ROI.md`).

**Structure the brief around OBJECTIVES, not a flat list of tools.** The reader should see: "here are my goals, here's what each costs and returns, here's what I should do."

Include the following sections:

### 1. Investment Overview

Key metrics from the ROI analysis. **CRITICAL: Copy the EXACT numbers from `ROI.md`.** Do NOT round, approximate, or recalculate. If `ROI.md` says "4.7 hours/week", write "4.7 hours/week" -- not "about 5 hours" or "nearly 5 hours".

Include at minimum:
- Total investment required (implementation + first-year tool costs)
- Total annual return (net annual savings)
- Portfolio payback period (exact figure from ROI.md)
- Weekly time saved (exact figure from ROI.md)
- Monthly tool cost (exact figure from ROI.md)
- Net monthly savings (exact figure from ROI.md)

### 2. Investment by Objective

**Lead with objectives, not tools.** For each objective identified during analysis:

```
#### OBJECTIVE: "[objective name]"
What it solves: [1-sentence description of the pain]
Investment options:
  - Option A: €[X]/mo → returns €[Y]/yr (ROI: [Z]%)
  - Option B: €[X]/mo → returns €[Y]/yr (ROI: [Z]%)
Recommended: [which option and why, in one sentence]
```

**Cross-objective bundling:** If a tool appears in multiple objectives, highlight it:

```
**Cross-Objective Investment: [Tool Name]**
Serves objectives: [A], [C], [D]
Combined value: €[X]/yr across all objectives
Single cost: €[Y]/yr
This is the highest-impact single investment.
```

### 3. Below Threshold

Note items that were evaluated but don't justify adoption (from ROI.md's Below Threshold section). Keep it brief -- one line each:

```
- [Item]: benefit €[X]/yr vs cost €[Y]/yr -- ratio below 1.5x threshold. Revisit when [condition].
```

These are NOT featured as recommendations. They're documented for completeness.

### 4. Setup Guide Summary

Brief overview of what needs to be configured and the estimated effort.

### 5. Capital Allocation Decisions

High-level summary of the tool and process changes recommended, drawn from `diff.md`. Frame each change as an investment decision: what you are investing in, what it costs, and what it returns.

### 6. Timeline

Reference the **exact same total duration and phases** from the Adoption Plan. Do NOT invent a different timeline.

### 7. Quick Reference

Link to all deliverable documents using these exact filenames:
- `inefficiencies.md` -- Analysis of current process inefficiencies
- `process.md` -- New recommended process
- `setup.md` -- Setup and configuration guide
- `diff.md` -- Change management document
- `ROI.md` -- Return on investment analysis
- `risks.md` -- Risk assessment
- `adoption-plan.md` -- Phased rollout plan
- `integration-checklist.md` -- Technical integration tasks
- `action-plan.md` -- Phased task board

### 8. Investment Decision Framework

Should the business invest? Present a balanced Pros/Cons analysis framed around financial return, risk, and strategic value to help the decision-maker allocate operational capital.

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

- **EXACT NUMBERS ONLY:** Every number in this document must be copied verbatim from the source document. Do not round, approximate, or recalculate any figure.
- Use the exact tool names from `sharedFacts.targetTools`.
- Timeline must match `adoption-plan.md` exactly.
- Write for a non-technical business owner -- clear, concise, no jargon.
- This is a decision document, not a technical spec. Focus on business impact.
- **Math Transparency Rule:** Every headline number in the investment brief must include its formula in parentheses. Example: "Annual return: €1,918 (= 109 min/wk × €25/hr ÷ 60 × 52 wk - €588 tools/yr + €250 setup amortized)"

---

## Output Format

Format as a single markdown document with the six sections described above. Keep it concise -- this should be a 1-2 page executive summary, not a detailed report.

---

## Output File

Write to: `~/.stackscan/projects/{project}/output/adoption-summary.md`
