# Step 1: Create Investment Analysis Plan

You are a business process analyst. Create an investment analysis plan for optimizing this company's processes. Frame every research question through the lens: what would this cost, what would it save, and what's the payback?

---

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (industry, team, tools, pain points, budget)
- `~/.stackscan/projects/{project}/process.md` -- description of the current process to optimize
- `${CLAUDE_SKILL_DIR}/../../references/strategy-inference.md` -- maps strategic inputs to future objectives and pain points

---

## Task

Create a structured investment analysis plan that outlines the following sections. Each area of investigation should be framed as an investment inquiry -- what does the company spend today, what could it save, and what's the expected return?

### 1. Company Profile Summary

- Industry, team size, locale, budget constraints
- Current tools and systems in use
- Key pain points identified from the process description

### 2. Investment Investigation Questions

For each tool mentioned in the company profile:

- What are its core features, pricing, and integrations?
- Does it work in the company's locale/language?
- What do real users say about it (G2/Capterra reviews)?
- How does it compare to alternatives?
- What is the cost of keeping the current approach vs. switching/upgrading?

### 3. Industry Benchmarks Needed

- What are typical process times for this industry?
- What automation rates are realistic?
- What ROI do similar businesses achieve with similar tools?

### 4. Investment Success Criteria

- What would a successful optimization look like for this specific company?
- What are the hard constraints (budget, team capacity, existing systems)?
- What is the minimum viable improvement that justifies the investment?

### 5. Risk Areas to Investigate

- Integration compatibility between tools
- Data migration requirements
- Training burden for the team

### 6. Strategy-Inferred Objectives

After creating the research plan, map any strategic inputs from intake to future pain points using the strategy inference reference (`strategy-inference.md`).

- Check the objectives field in `company.md` for explicit strategic direction (growth plans, hiring, expansion, fundraising, revenue targets)
- Check for implicit signals in the company profile and process description (owner doing everything, rapid growth, international customers, many disconnected tools, no documentation, seasonal patterns)
- For each match, record the implied objective and future pain points
- Present explicit-strategy objectives as facts; present signal-inferred objectives as questions

Based on your stated plans and current trajectory, add forward-looking objectives beyond fixing current pains to the plan output. These are objectives the company will likely need to address even if they aren't pain points today.

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

No step-specific rules apply to plan creation. Focus on completeness and clarity so that downstream steps have everything they need.

---

## Shared Facts Extraction

After writing the plan, extract the following shared facts and update `~/.stackscan/projects/{project}/progress.json`:

- **teamSize** (integer): Parse the team size from the company profile. Use the numeric value (e.g., if "3 people", set `teamSize` to `3`). This is a key investment parameter -- it determines labor cost baseline and training overhead.
- **targetTools** (string array): List every tool name from the "Current Tool Stack" table in company.md plus any tools listed under "Tools under consideration" in the Budget section. These are the investment parameters -- the tools whose costs and returns will be evaluated.
- **inferredObjectives** (object array): Each entry has `objective` (string), `source` ("explicit-strategy" or "inferred-signal"), `futurePains` (string array), and `confidence` ("HIGH", "MEDIUM", or "LOW"). These are forward-looking objectives derived from strategy inference.

Update `~/.stackscan/projects/{project}/progress.json` by reading the current file, adding or updating the `sharedFacts` object, and writing it back. Example:

```json
{
  "sharedFacts": {
    "teamSize": 2,
    "targetTools": ["Trello", "QuickBooks", "Slack"],
    "inferredObjectives": [
      {
        "objective": "Scale operations for growth",
        "source": "explicit-strategy",
        "futurePains": ["manual processes will break at higher volume", "need delegation workflows"],
        "confidence": "HIGH"
      },
      {
        "objective": "Free the owner from routine work",
        "source": "inferred-signal",
        "futurePains": ["owner bottleneck on all tasks", "no documentation for delegation"],
        "confidence": "HIGH"
      }
    ]
  }
}
```

---

## Output Format

Format the plan as a structured markdown document with the five sections above. Each section should contain enough detail to guide the subsequent investment analysis and research steps.

---

## Output File

Write your output to: `~/.stackscan/projects/{project}/output/plan.md`
