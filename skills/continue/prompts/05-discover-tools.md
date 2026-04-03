# Step 5: Discover Alternative Tools

## Condition

This step only runs if the tool-fit verdict from step 4 was **POOR**. If the verdict was GOOD or ADEQUATE, skip this step entirely.

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, pain points, budget)
- `~/.stackscan/projects/{project}/output/tool-fit.md` -- tool-fit assessment showing which tools are POOR fits

## Task

Find alternative SaaS tools to address the **unaddressed pain points** identified in the tool-fit assessment.

Based on the tool-fit assessment, identify which pain points have no good tool coverage and search for alternatives. Focus on:

1. **Locale and language fit** -- tools that work in the company's country and language.
2. **Budget constraints** -- tools within the company's stated budget range.
3. **Integration compatibility** -- tools that integrate with systems the company is keeping (avoid adding silos).
4. **Low barrier to entry** -- tools with free tiers or trials for initial testing.

### Web Search Strategy

If web search is available, search the following sources for alternatives to the POOR-rated tools:

- **Product Hunt** -- search for the tool category (e.g., "inventory management for small business")
- **Capterra** -- search for category comparisons and user reviews
- **G2** -- search for alternatives and competitive comparisons
- Search for competitors to the poorly-fitting tools by name

If web search is not available, use your training knowledge but clearly flag all recommendations with: "Based on training data -- verify current pricing and features on vendor website."

### For Each Discovered Tool, Provide

- **Tool name** and website URL
- **Which unaddressed pain point(s)** it solves (reference the specific gaps from tool-fit.md)
- **Exact pricing** -- tiers, monthly cost, annual discounts if available
- **Key integrations** -- especially with tools the company is keeping
- **Real user reviews or ratings** if available (G2/Capterra scores)
- **Language/locale support** -- does it work in the company's region?
- **Setup documentation URL** -- link to the official setup/getting-started guide
- **Why recommended over alternatives** -- what makes this the best choice vs. other options considered

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Grounding Rule** -- only reference features you can verify from search results or documentation

### Step-specific rules

- Do NOT recommend tools the company already has (those are assessed in tool-fit.md).
- Prioritize tools that cover MULTIPLE unaddressed pain points over single-purpose tools.
- For each tool, include at least one concrete alternative if available ("If [Tool A] doesn't fit, consider [Tool B]").
- If no suitable tool exists for a pain point, say so explicitly rather than forcing a bad recommendation.
- Keep the total number of new tools minimal -- adding too many tools creates its own complexity.

## Output Format

Format as markdown with the following structure:

```
# Tool Discovery Report

## Unaddressed Pain Points (from tool-fit assessment)
[List the gaps that need covering]

## Recommended Tools

### [Tool Name]
- **Website:** [URL]
- **Addresses:** [which pain point(s)]
- **Pricing:** [exact tiers]
- **Key integrations:** [list]
- **Reviews:** [ratings/summary]
- **Locale support:** [yes/no + details]
- **Recommendation:** [why this tool fits]

### [Next Tool...]

## Coverage Summary
[Table mapping pain points to recommended tools, showing which gaps are now covered]

### Compliance Filter
For each recommended tool, verify:
- GDPR compliance (if EU): Does it process data in the EU? DPA available?
- Industry-specific regulations (e.g., e-invoicing for French businesses)
- Data residency: Where is data stored?
- Flag non-compliant tools: "⚠️ COMPLIANCE WARNING: [specific issue]"

## Notes
[Any caveats, unverified claims, or pain points that remain unaddressed]
```

## Output File

Write to: `~/.stackscan/projects/{project}/output/tool-discovery.md`
