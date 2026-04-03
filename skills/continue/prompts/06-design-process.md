# Step 6: Design New Process

This is the most critical step in the pipeline. You will produce THREE output sections in a single response.

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, pain points, budget)
- `~/.stackscan/projects/{project}/output/inefficiencies.md` -- identified inefficiencies with time breakdowns
- `~/.stackscan/projects/{project}/output/tool-fit.md` -- tool-fit assessment with target tools and verdicts
- `~/.stackscan/projects/{project}/output/tool-discovery.md` -- alternative tools (if this file exists; it may not)

## Task

Generate a redesigned business process using the target tools, comprehensive setup instructions with pricing, and a tool budget summary.

Your response MUST consist of exactly **three sections** separated by a line containing ONLY the text `---SPLIT---` (nothing else on that line -- no extra dashes, spaces, or formatting).

Structure your entire response like this:

```
{Section 1: New Process document}

---SPLIT---

{Section 2: Setup Guide with pricing tables}

---SPLIT---

{Section 3: Tool Budget summary table}
```

---

## Section 1: New Process (new-process.md)

Write a detailed, prescriptive process document covering:

### Step-by-step workflow
- Describe the new workflow using the target tools from tool-fit.md (and any additions from tool-discovery.md).
- Reference tools **explicitly by name** throughout -- never say "the CRM" when you can say "HubSpot."
- For each step, state which tool is used and what specifically happens in it.
- For each major process change, include: **Expected monthly savings: €X (= time_saved_per_week × rate ÷ 60 × 4.33)**

### Tool categorization

For EACH tool recommendation in the new process, classify it as one of two types:

- **SCALING ENABLER** -- unlocks new capabilities, revenue, or markets. Value is measured in REVENUE POTENTIAL (what you can now do that you couldn't before). Examples: payment gateway enabling international sales, CRM enabling pipeline management, e-commerce platform enabling online sales.

- **TEDIUM REDUCER** -- makes existing operations less painful. Value is measured in TIME/COST SAVINGS (what you no longer waste). Examples: auto-invoicing saving 15 min per invoice, integration module eliminating double data entry, template system reducing document creation time.

Add a label to each tool recommendation in the output:

```
**[Tool Name]** — Type: Tedium Reducer — eliminates manual data entry between Excel and PrestaShop
```
or
```
**[Tool Name]** — Type: Scaling Enabler — unlocks automated email marketing to existing customer base
```

These categories matter because they have different evaluation criteria:
- Scaling enablers have UNCERTAIN but potentially large upside
- Tedium reducers have KNOWN, concrete, calculable returns

Use the correct category to frame the value proposition in the process description.

### Roles and responsibilities
- List every role involved in the new process.
- For each role, provide a clear task breakdown: what they do, in which tool, at what frequency.
- If the company has 3 or fewer people, do NOT create artificial role separations -- the same person may handle multiple roles.

### Integration points
- Describe how the tools work together to simplify the workflow.
- Specify exact integration mechanisms (native integration, Zapier, manual handoff, etc.).

### Automation Opportunities
For each integration point involving data transfer between tools:
- Can this be automated? (native module, Zapier/n8n, API script, manual)
- **Trigger:** What event starts it?
- **Action:** What happens automatically?
- **Platform:** n8n / Zapier / native module / custom script
- For the top 3 automations, provide a ready-to-use description:
  - n8n: describe the workflow nodes and connections (trigger → action → output)
  - Zapier: describe the zap (trigger app → action app → fields mapped)
  - Native: describe the module/plugin settings

### Grounding constraints
- ONLY reference tool features that appear in the research findings, tool-fit assessment, or tool-discovery report.
- If a tool has no research documentation, write: "Documentation unavailable -- features unverified. Verify with vendor before implementation."
- Do NOT assume integrations exist between tools unless explicitly documented in the input files.
- Flag any unverified feature with: "Unverified -- verify with vendor before implementation."

---

After writing Section 1, output exactly this on its own line:

```
---SPLIT---
```

---

## Section 2: Setup Guide (setup.md)

Write a detailed setup guide covering:

### Prerequisites and dependencies
- What accounts need to be created, what access is required.
- Order of operations if tools need to be set up sequentially.

### Step-by-step setup instructions
- Written for a **non-technical business owner** -- no jargon without explanation.
- For each tool: account creation, initial configuration, key settings to change, business rules to configure.
- Include specific settings where possible (e.g., "Set invoice due date to Net 30 under Settings > Invoicing > Defaults").

### Tool pricing table
- Include a pricing table with exact tiers from the research findings and tool-fit assessment.
- Use this format:

| Tool | Plan | Monthly Cost | Annual Cost | Notes |
|------|------|-------------|-------------|-------|
| [name] | [tier] | [amount] | [amount] | [what's included] |

- **PRICING RULE**: Use ONLY pricing tiers found in the input files. If pricing was not researched, write "Pricing not verified -- check vendor website."
- If a tool has no research findings, flag it: "[Tool Name]: No documentation available. Features and pricing unverified."

### Monthly total
- Sum all tool costs at the bottom of the pricing table.

### Documentation & Learning Resources
For each recommended tool, include:
- **Official setup guide URL** (use WebSearch if available to find current URL)
- **Video tutorial** (search YouTube for "[Tool Name] setup tutorial" if WebSearch available)
- **Key documentation pages** for the specific features being used
- If web search is not available: "Search '[Tool Name] setup guide' for current documentation"

### Why These Tools (Alternatives Considered)
For each recommended tool, briefly explain:
- Why it was chosen over alternatives
- What alternatives were considered and why they were ruled out
- Under what conditions the user should reconsider this choice

### Troubleshooting section
- Common issues during setup and how to resolve them.

---

After writing Section 2, output exactly this on its own line:

```
---SPLIT---
```

---

## Section 3: Tool Budget (tool-budget.md)

Write a concise tool budget summary extracted from the pricing information in Section 2. This should be a standalone reference document containing:

### Budget summary table

| Tool | Plan | Monthly Cost | Annual Cost |
|------|------|-------------|-------------|
| [name] | [tier] | [amount] | [amount] |
| **Total** | | **[sum]** | **[sum]** |

### Cost comparison
- Current monthly spend (from company.md tool stack)
- New monthly spend (from the table above)
- Net change (increase or decrease)

### Notes
- Any tools with unverified pricing
- Free tier limitations that may require future upgrades
- Annual vs monthly savings if applicable

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Grounding Rule** -- only reference verified tool features
- **Pricing Verification Rule** -- use only researched pricing, never guess
- **Team Size Scaling Rule** -- scale recommendations to the actual team size

### Step-specific rules

- The `---SPLIT---` delimiter is CRITICAL. The orchestrator splits your output on this exact string. If you omit it or format it incorrectly, the output files will be malformed.
- Both Section 1 and Section 2 must be substantial (at minimum several hundred words each). Do not produce empty or stub sections.
- Section 3 (tool budget) must be consistent with the pricing table in Section 2. The numbers must match exactly.
- Be prescriptive and specific, not generic. Write "Configure HubSpot to send follow-up emails 3 days after quote delivery" not "Set up automated follow-ups."
- If the company has 3 or fewer people: no pilot groups, no change champions, no dedicated project manager roles. Keep it simple.
- Prefer free tiers and essential-only features for budget-constrained businesses.

## Shared Facts Extraction

The orchestrator will extract the following from your output:

- **roles**: The list of roles mentioned in the new process (Section 1). Make sure role names are clear and consistent.
- **toolBudget**: The pricing summary from Section 3. This will be reused by later steps (ROI, consistency checks).

## Key Assumptions for Confirmation

List the top 5 assumptions that most affect the numbers in this analysis. For each:
- **The assumed value** and unit
- **Source:** client-data / benchmark / research / estimate
- **Confidence:** HIGH / MEDIUM / LOW
- **Sensitivity:** What changes if this assumption is wrong? (e.g., "If artwork volume is actually 3/month instead of 8, the annual waste estimate drops from €2,362 to €885")

## Output Files

The orchestrator will split your output on `---SPLIT---` markers and write to:

- `~/.stackscan/projects/{project}/output/new-process.md` (Section 1)
- `~/.stackscan/projects/{project}/output/setup.md` (Section 2)
- `~/.stackscan/projects/{project}/output/tool-budget.md` (Section 3)
