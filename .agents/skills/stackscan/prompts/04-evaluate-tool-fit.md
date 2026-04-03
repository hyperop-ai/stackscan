# Step 4: Evaluate Tool Fit

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (current tool stack, pain points)
- `~/.stackscan/projects/{project}/output/inefficiencies.md` -- identified inefficiencies from Step 3
- `${CLAUDE_SKILL_DIR}/../../references/evaluation-pipeline.md` -- 7-gate evaluation pipeline (use for candidate evaluation)
- `${CLAUDE_SKILL_DIR}/../../references/risk-maturity-matching.md` -- maturity spectrum and risk profile matching

## Task

You are a tool-fit analyst. Your job is to check whether the company's current and proposed SaaS tools actually solve the identified pain points.

1. Extract the core pain points from the inefficiencies and company context.
2. For each pain point, check if ANY of the documented tools address it -- use only what is documented in the research findings or company context; do not assume features.
3. Classify coverage:
   - **ADDRESSED**: The tool has a documented feature that directly solves this (cite the source).
   - **PARTIAL**: The tool helps but does not fully solve it (e.g., reduces manual entry but does not automate it).
   - **UNADDRESSED**: No documented tool solves this pain point.
4. Produce an overall fit assessment:
   - **GOOD**: All core pain points ADDRESSED or PARTIAL.
   - **ADEQUATE**: Most core pain points addressed, 1 UNADDRESSED but non-critical.
   - **POOR**: 2+ core pain points UNADDRESSED, or the #1 pain point is UNADDRESSED.

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Grounding Rule** -- only reference documented tool features; do not assume capabilities

### Step-specific rules

- Evaluate EACH current tool against documented pain points individually.
- A tool can be rated KEEP even when the overall fit is POOR -- only REPLACE tools that are individually poor.
- Do NOT assume integrations exist between tools unless documentation explicitly mentions them.
- If a tool has no documentation, state: "Documentation unavailable -- features unverified."

## Reasoning Chain

Show your reasoning for each coverage classification:

1. State the pain point.
2. List what the research or company context says about relevant tool capabilities.
3. Assess coverage with explicit justification.

## Output Format

### Coverage Table

| Pain Point | [Tool A Name] | [Tool B Name] | Coverage |
|---|---|---|---|
| [pain point] | [what this tool offers or "No capability"] | [same] | ADDRESSED / PARTIAL / UNADDRESSED |

### Maturity & Risk Assessment

For each evaluated tool (current and candidate), include a maturity and risk assessment using the spectrum from `risk-maturity-matching.md`:

```
[Tool Name]
  Maturity: [LEVEL] ([age], [review count], [activity signal])
  Risk for your profile: [Low/Medium/High] — [brief justification matching user's risk_tolerance]
```

If a tool the user CURRENTLY uses shows LEGACY signals (declining reviews, stale updates, shrinking ecosystem), flag it explicitly:

```
⚠ Legacy signal: [Tool] shows [specific declining signals].
You currently use it. Switching cost is [estimate]. Consider: is it worth migrating
now, or ride it until a clear replacement emerges?
```

### Fit Assessment

State clearly:

```
Fit Assessment: GOOD / ADEQUATE / POOR -- [brief justification]
```

### Shared Fact

Extract the following shared fact for downstream steps:

```
toolFitVerdict: GOOD | ADEQUATE | POOR
```

This is the WORST verdict across all tools. If the verdict is GOOD or ADEQUATE, the `discover_tools` step will be skipped.

### 7-Gate Evaluation Funnel

After identifying candidate tools (from step 2, tool discovery, or existing stack), run ALL candidates through the 7-gate elimination pipeline described in `evaluation-pipeline.md`.

**Show the funnel in your output.** For each pain point where you evaluate tools:

1. State how many candidate tools were identified
2. Show how many were eliminated at each gate and why
3. Present the 2-3 survivors with deep evaluation

Example funnel output:

```
Evaluation funnel for "[pain point]":
  Found 15 candidate tools
  - 6 eliminated at Gate 1 (budget): over €[X]/mo limit
  - 3 eliminated at Gate 2 (constraints): [which constraints violated]
  - 2 eliminated at Gate 3 (stack): no integration with [user's tools]
  - 1 eliminated at Gate 4 (maturity): too new (<6 months, <10 reviews)
  - 1 eliminated at Gate 5 (dealbreakers): [specific reason]
  → 2 tools evaluated in depth (Gates 6-7), both presented below
```

For tools that pass all gates, provide the deep evaluation from Gate 7 (TCO, lock-in, vendor risk, compliance, ecosystem, trajectory). This evaluation replaces generic "it has feature X" descriptions with concrete, dimensional assessments.

### If Fit Assessment is POOR

When the overall assessment is POOR, add ALL of the following sections:

**Per-Tool Verdict:**

For EACH target tool, give an individual assessment:
- [Tool A]: KEEP / REPLACE -- [reason]. [If KEEP: what it is good at. If REPLACE: what function needs a replacement.]
- [Tool B]: KEEP / REPLACE -- [reason].

For each KEEP tool, also include:
- **Why not replace**: The specific reason the current tool is being kept
- **What would change the verdict**: Under what conditions should the team reconsider

**Unaddressed Pain Points:**
- [pain point 1]: [what capability is missing]

**Tools to Replace:**
- [Tool name]: replace because [specific reason for THIS tool]

**Tools to Keep:**
- [Tool name]: keep because [what it does well]

**Search Queries** (for finding tools that REPLACE the gaps -- not duplicating what kept tools already do):
- "[specific search query 1]"
- "[specific search query 2]"
- "[specific search query 3]"

The search queries should be specific to the company's locale, industry, and existing systems.

## Output File

Write to: `~/.stackscan/projects/{project}/output/tool-fit.md`
