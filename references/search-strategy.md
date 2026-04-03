# Search Strategy Reference

How to search for tools based on classified pain points.

## Query Generation by Taxonomy Level

### Category level (broad discovery)
For pain at the category level (e.g., "financial-operations"):
- G2: "best [category] software for small business"
- Capterra: "[category]" category, filtered by team size + pricing
- ProductHunt: "[category]" tag, sorted by votes, last 12 months

### Subcategory level
For pain at subcategory (e.g., "financial-operations.invoicing"):
- G2: "best [subcategory] software [industry]"
- Web: "[subcategory] tools for [team size] person [industry]"

### Leaf level (specific targeting)
For pain at leaf (e.g., "invoicing.no-auto-from-orders"):
- Web: "[existing_tool] [specific pain] module/plugin"
- G2: "[specific solution]"
- ProductHunt: "[specific solution]" last 6 months

## 5 Search Heuristics (in order)

### 1. Stack-first (zero cost)
Search: "[user's existing tool] [pain point] module/plugin/integration/feature"
If found → this IS the answer. No new tool needed. Cost: €0.
Eliminates search for ~30-40% of pain points.

### 2. Integration-first (lowest friction)
Search: "best [pain category] software integrates with [primary tool]"
Sort by: integration count with user's stack × review rating.
The tool with deepest integration wins.

### 3. Category leader with budget filter
Search: site:g2.com "[pain category] software" + filter by budget/team size
Take top 3 by rating × review count.
Category leader is usually right for SMBs.

### 4. Compound tool preference
If user has 3 pain points that ONE tool solves, prefer it over 3 separate tools.
Score: compound_score = sum(individual_scores) × 1.3

### 5. Free tier preference for low-severity pains
For pains below €500/yr waste: only recommend tools with a free tier.

## Search Budget Allocation

| Pain severity | Searches | Depth |
|---|---|---|
| HIGH (>€1000/yr waste) | 4-5 per pain | G2 + Capterra + ProductHunt + web + tool site |
| MEDIUM (€200-1000/yr) | 2-3 per pain | G2 + web |
| LOW (<€200/yr) | 0-1 per pain | Training knowledge or single search |

Total budget: 20-30 searches per analysis run.
Reuse results across pain points where categories overlap.

## Handling Non-Standard/Niche Stacks

If the user uses a niche tool with no ecosystem:
1. Search the tool's own plugin/integration marketplace
2. Search "[tool name] alternatives" to find tools with better ecosystems
3. Search for middleware (Zapier/n8n) connections
4. If nothing: recommend process changes (no tool) or tool replacement

## "I Already Tried That" Handling

Before recommending, check local cache (~/.stackscan/projects/{project}/memory.json):
- If tool was previously rejected by user → skip it, note why
- If tool was previously recommended → check if still current (pricing may have changed)
