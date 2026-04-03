# Step Definitions

## Step 1: create_plan
- **Prompt:** `01-create-plan.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/process.md`
- **Output:** `~/.stackscan/projects/{project}/output/plan.md`
- **Shared facts to extract:**
  - `teamSize` — parse from company.md (look for team size / number of employees)
  - `targetTools` — parse from company.md (current tool stack names + any tools under consideration)
- **Task:** Create a research plan that outlines the analysis strategy. Identify which areas to investigate, what tools to research, and what the key optimization targets are based on the company profile and process description.
- **Report:** Highlight team size, target tools identified, and research strategy.

## Step 2: research_tools
- **Prompt:** `02-research-tools.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/plan.md`
- **References:** Read `${CLAUDE_SKILL_DIR}/../../references/search-strategy.md` for query generation patterns and heuristic cascade. Read `${CLAUDE_SKILL_DIR}/../../references/pain-taxonomy.md` to classify pain points into taxonomy nodes.
- **Output:** `~/.stackscan/projects/{project}/output/research-findings.md`
- **Task:** Classify each detected pain point into the pain taxonomy hierarchy, then research tools using taxonomy-driven smart search. Apply the 5 heuristics in cascade order (stack-first, integration-first, category leader, compound preference, free tier for low-severity). Allocate search budget by pain severity (HIGH: 4-5 searches, MEDIUM: 2-3, LOW: 0-1). Deduplicate results across pain points and check the local tool cache for previously evaluated tools. If WebSearch/WebFetch tools are available, use them to look up current pricing, features, integrations, and alternatives on sites like Product Hunt, Capterra, G2. If web tools are not available, use training knowledge and add a disclaimer: "Based on training data. Run with web search enabled for the latest tool recommendations."
- **Report:** Highlight pain point classification, stack-first findings (pains solved by existing tools), compound matches, and key pricing discoveries.

## Step 3: analyze_inefficiencies
- **Prompt:** `03-analyze-inefficiencies.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/process.md`, `~/.stackscan/projects/{project}/output/research-findings.md` (if exists)
- **Output:** `~/.stackscan/projects/{project}/output/inefficiencies.md`
- **Task:** Quantify operational waste and identify investment targets. Before estimating time/volume, apply the Data Resolution Protocol — check sources for actual operational data (time tracking tools, project boards, invoices) before estimating. For each task area, provide an atomic operation breakdown table with per-unit time, volume/week, source, confidence, and weekly total (as defined in helpers.md Time Decomposition Rule). Identify bottlenecks, redundancies, manual work that could be automated, and handoff delays — each one is a potential investment target. Apply the Automation Ceiling Rule (max 70% savings). Apply the Escalation Check Rule.
- **Report:** Highlight the top 3 cost leaks by weekly waste, total weekly waste, and confidence level. Flag if >30% estimates are LOW.

## Step 4: evaluate_tool_fit
- **Prompt:** `04-evaluate-tool-fit.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/inefficiencies.md`, `~/.stackscan/projects/{project}/output/research-findings.md` (if exists)
- **Output:** `~/.stackscan/projects/{project}/output/tool-fit.md`
- **Shared facts to extract:**
  - `toolFitVerdict` — the overall verdict: `GOOD`, `ADEQUATE`, or `POOR`. Parse from the output: look for a line containing "Fit Assessment:" followed by the verdict.
- **Task:** Evaluate the ROI of your current tool stack against the identified inefficiencies. For each tool, assess fit as GOOD (covers needs well, good return on spend), ADEQUATE (works but suboptimal, mediocre return), or POOR (significant gaps, poor return on investment). Provide an overall Fit Assessment verdict on a standalone line: `Fit Assessment: GOOD|ADEQUATE|POOR`.
- **Report:** Highlight per-tool verdicts and the overall verdict. This is a DECISION CHECKPOINT.

## Step 5: discover_tools (CONDITIONAL)
- **Prompt:** `05-discover-tools.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/tool-fit.md`
- **Output:** `~/.stackscan/projects/{project}/output/tool-discovery.md`
- **Condition:** SKIP this step if `toolFitVerdict` is NOT `"POOR"`. If skipped, record in progress.json as `{ "name": "discover_tools", "status": "skipped", "reason": "toolFitVerdict is not POOR" }` and move on.
- **Task:** Discover alternative investment opportunities (tools) that could address the POOR-rated gaps. Use WebSearch/WebFetch if available. Present findings in a table with columns: Tool Name, URL, Pricing, Key Features, Addresses Gap. Update `targetTools` shared fact with any newly discovered tool names.
- **Report:** Highlight new tools discovered and how they address the gaps.

## Step 6: design_process (MULTI-OUTPUT)
- **Prompt:** `06-design-process.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/inefficiencies.md`, `~/.stackscan/projects/{project}/output/tool-fit.md`, `~/.stackscan/projects/{project}/output/tool-discovery.md` (if exists), `~/.stackscan/projects/{project}/output/research-findings.md` (if exists)
- **Outputs:** THREE files from a single generation, separated by `---SPLIT---` delimiters:
  1. `~/.stackscan/projects/{project}/output/new-process.md` — everything BEFORE the first `---SPLIT---`
  2. `~/.stackscan/projects/{project}/output/setup.md` — everything BETWEEN the first and second `---SPLIT---`
  3. `~/.stackscan/projects/{project}/output/tool-budget.md` — everything AFTER the second `---SPLIT---`
- **Shared facts to extract:**
  - `roles` — array of role names extracted from the new process (look for role headers or a roles section)
  - `toolBudget` — the tool budget content (for downstream ROI calculation)
- **Task:** Design an optimized process that addresses the identified inefficiencies. The output MUST contain exactly two `---SPLIT---` lines to separate three sections:
  - **Section 1 (new-process.md):** The redesigned process with step-by-step breakdown, tool assignments, time estimates, and role assignments.
  - **Section 2 (setup.md):** Setup instructions for each recommended tool — account creation, configuration, integrations, and data migration steps.
  - **Section 3 (tool-budget.md):** Pricing breakdown table with tool name, plan/tier, monthly cost, annual cost, and notes. Apply the Pricing Verification Rule.
- **After generating:** Split the output on `---SPLIT---` and write each section to its respective file.
- **Report:** Highlight the key process changes, new tool budget total, and roles affected. This is a DECISION CHECKPOINT.

## Step 7: calculate_roi (CENTERPIECE)
- **Prompt:** `07-calculate-roi.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/process.md`, `~/.stackscan/projects/{project}/output/new-process.md`, `~/.stackscan/projects/{project}/output/inefficiencies.md`, `~/.stackscan/projects/{project}/output/tool-budget.md` (if exists)
- **Output:** `~/.stackscan/projects/{project}/output/ROI.md`
- **Task:** This is the core investment analysis — every prior step feeds into it, and every subsequent step references it. Before using hourly rates or volumes, apply the Data Resolution Protocol — check for actual payroll data, billing records, or time logs before estimating. Calculate the return on investment for each proposed operational change. Show ALL arithmetic work. For each operation: weekly savings = (before_time - after_time) x volume. Apply the Automation Ceiling Rule (cap at 70%). Calculate: total weekly time saved, monetary value (using reasonable hourly rate), new tool costs (from tool-budget.md), net weekly/monthly/annual savings, and payback period for each investment. Validate total time saved against team capacity (teamSize x 40 hours/week). Use the Pricing Verification Rule — costs must match tool-budget.md exactly.
- **Report:** Highlight weekly savings, net monthly return, payback period, and automation rate. This is a DECISION CHECKPOINT — ask if numbers feel right.

## Step 8: assess_risks
- **Prompt:** `08-assess-risks.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/new-process.md`
- **Output:** `~/.stackscan/projects/{project}/output/risks.md`
- **Task:** Identify risks in adopting the new process. For each risk: description, likelihood (HIGH/MEDIUM/LOW), impact (HIGH/MEDIUM/LOW), mitigation strategy. Include: adoption resistance, tool migration risks, data loss risks, learning curve, vendor lock-in, integration failures, and cost overrun. Apply Team Size Scaling Rules from helpers.md.
- **Report:** Highlight the top 3 risks and their mitigations.

## Step 9: generate_diff
- **Prompt:** `09-generate-diff.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/process.md`, `~/.stackscan/projects/{project}/output/new-process.md`
- **Output:** `~/.stackscan/projects/{project}/output/diff.md`
- **Task:** Generate a before/after comparison of the process. For each step or area: what changes, what stays the same, what is new, what is removed. Use a clear table or side-by-side format. Highlight the biggest wins and any trade-offs.
- **Report:** Highlight the biggest changes and any trade-offs.

## Step 10: generate_adoption_plan
- **Prompt:** `10-generate-adoption-plan.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/diff.md`, `~/.stackscan/projects/{project}/output/ROI.md`, `~/.stackscan/projects/{project}/output/risks.md`
- **Output:** `~/.stackscan/projects/{project}/output/adoption-plan.md`
- **Task:** Create a phased implementation roadmap with payback milestones. Include: phase timeline, investments per phase, responsible roles, success criteria, rollback triggers, and when each investment starts paying back. Apply Team Size Scaling Rules. For very small teams (3 or fewer), combine phases and keep it practical — no pilot groups, no change champions, no formal training sessions.
- **Report:** Highlight the number of phases, total timeline, and when payback starts.

## Step 11: generate_role_guides (MULTI-FILE)
- **Prompt:** `11-generate-role-guides.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/diff.md`, `~/.stackscan/projects/{project}/output/new-process.md`
- **Outputs:** One file per role: `~/.stackscan/projects/{project}/output/role-guides/{RoleName}.md`
- **Task:** Generate a personalized adoption guide for each role listed in the `roles` shared fact. Each guide should cover: what changes for this role, new tools to learn, new steps in their workflow, time impact (what they gain/lose), and a quick-start checklist. Create the `role-guides/` subdirectory first. If the `roles` shared fact is empty or missing, extract roles from `new-process.md` or `company.md`.
- **Report:** Highlight how many role guides were generated and for which roles.

## Step 12: generate_integration_checklist
- **Prompt:** `12-generate-integration-checklist.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/research-findings.md` (if exists), `~/.stackscan/projects/{project}/output/setup.md`
- **Output:** `~/.stackscan/projects/{project}/output/integration-checklist.md`
- **Task:** Generate a technical integration checklist. For each tool pairing or integration point: what needs to be connected, API/Zapier/native integration method, estimated setup time, verification test, and fallback if integration fails. Use `targetTools` shared fact for tool-specific items. Apply the Grounding Rule — only reference integrations that appear in research findings or are well-known.
- **Report:** Highlight total number of integration tasks and any blockers.

## Step 13: check_consistency (QUALITY GATE)
- **Prompt:** `13-check-consistency.md`
- **Inputs (all clipped to manage context size):**
  - `~/.stackscan/projects/{project}/company.md` (first 3000 chars)
  - `~/.stackscan/projects/{project}/process.md` (first 3000 chars)
  - `~/.stackscan/projects/{project}/output/inefficiencies.md` (first 4000 chars)
  - `~/.stackscan/projects/{project}/output/new-process.md` (first 4000 chars)
  - `~/.stackscan/projects/{project}/output/setup.md` (first 4000 chars)
  - `~/.stackscan/projects/{project}/output/ROI.md` (first 5000 chars)
  - `~/.stackscan/projects/{project}/output/risks.md` (first 3000 chars)
  - `~/.stackscan/projects/{project}/output/diff.md` (first 3000 chars)
  - `~/.stackscan/projects/{project}/output/adoption-plan.md` (first 3000 chars)
  - `~/.stackscan/projects/{project}/output/tool-budget.md` (first 2000 chars, if exists)
- **Output:** `~/.stackscan/projects/{project}/output/consistency-report.md`
- **Task:** Check for consistency across ALL outputs. Verify:
  1. **Number consistency:** Do time savings, costs, and ROI figures match across documents?
  2. **Capacity plausibility:** Does total time saved stay within team capacity (teamSize x 40 hrs/week)? Does automation rate stay under 70%?
  3. **Pricing match:** Do tool costs match exactly across setup.md, tool-budget.md, ROI.md, and adoption-summary.md?
  4. **Tool name consistency:** Are tool names spelled identically everywhere?
  5. **Confidence markers:** Are LOW confidence items flagged appropriately?

  Categorize issues as HIGH (must fix), MEDIUM (should fix), LOW (minor).

  **CRITICAL — Last line of output must be one of:**
  - `CONTINUE` — no HIGH issues found, pipeline can proceed
  - `LOOP_BACK:{step_name}` — HIGH issues found that require re-running from `{step_name}` (e.g., `LOOP_BACK:calculate_roi`)

- **After writing the consistency report:** Parse the LAST LINE of the output.
  - If `CONTINUE`: proceed to step 14.
  - If `LOOP_BACK:{step_name}`:
    1. Validate that `{step_name}` is one of the 15 valid step names listed in Constants above.
    2. If invalid, log a warning and proceed with `CONTINUE` instead.
    3. If valid, increment `loopCount` in progress.json.
    4. **If `loopCount` >= 3:** Log "Max loops reached. Proceeding." and treat as `CONTINUE`.
    5. Otherwise: reset `currentStep` in progress.json to the index of `{step_name}`, and re-execute from that step forward. All steps from `{step_name}` onward will re-run (their previous entries in progress.json steps array remain for history, but new entries are appended).
- **Report:** Highlight issue counts by severity. This is a DECISION CHECKPOINT if any HIGH issues.

## Step 14: generate_action_plan
- **Prompt:** `14-generate-action-plan.md`
- **Inputs:** `~/.stackscan/projects/{project}/company.md`, `~/.stackscan/projects/{project}/output/new-process.md`, `~/.stackscan/projects/{project}/output/setup.md`, `~/.stackscan/projects/{project}/output/ROI.md`, `~/.stackscan/projects/{project}/output/risks.md`, `~/.stackscan/projects/{project}/output/adoption-plan.md`, `~/.stackscan/projects/{project}/output/diff.md`, `~/.stackscan/projects/{project}/output/inefficiencies.md`, `~/.stackscan/projects/{project}/output/tool-budget.md` (if exists)
- **Output:** `~/.stackscan/projects/{project}/output/action-plan.md`
- **Task:** Generate a ranked portfolio of operational investment opportunities ordered by payback period. Group by priority (immediate quick wins, short-term investments, medium-term bets). Each investment: what, who, when, dependencies, cost, expected return, and payback period. Include quick wins (< 1 hour to implement, immediate payoff) at the top. Reference specific tools, costs, and time savings from prior outputs. Numbers must match ROI.md exactly.
- **Report:** Highlight total investment required, number of quick wins, and top-ranked investment.

## Step 15: generate_summary
- **Prompt:** `15-generate-summary.md`
- **Inputs (clipped):**
  - `~/.stackscan/projects/{project}/output/inefficiencies.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/new-process.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/setup.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/diff.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/ROI.md` (first 4000 chars)
  - `~/.stackscan/projects/{project}/output/risks.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/adoption-plan.md` (first 2500 chars)
  - `~/.stackscan/projects/{project}/output/role-guides/` (list of files, first 2500 chars of each if available)
  - `~/.stackscan/projects/{project}/output/integration-checklist.md` (first 2500 chars, if exists)
  - `~/.stackscan/projects/{project}/output/action-plan.md` (first 2500 chars)
- **Output:** `~/.stackscan/projects/{project}/output/adoption-summary.md`
- **Task:** Generate an investment brief for stakeholders. Include: situation overview, key findings, recommended investments ranked by return, ROI headline numbers, top risks, and recommended next steps. **Copy EXACT numbers from ROI.md** — do not round, rephrase, or recalculate. This is the final deliverable that gets shared with decision-makers.
- **Report:** This is the final output — present the full investment brief inline.

---

## progress.json Management

After each step completes, update progress.json:

1. **Add a step entry** to the `steps` array:
   ```json
   {
     "name": "{step_name}",
     "status": "completed",
     "outputFile": "{filename}",
     "completedAt": "{ISO timestamp}"
   }
   ```
   For skipped steps, use `"status": "skipped"` and include `"reason": "..."`.
   For multi-output steps (6, 11), list all output files: `"outputFiles": ["file1.md", "file2.md"]`.

2. **Update `currentStep`** to the index of the step just completed (0-based).

3. **Merge shared facts** — if this step extracted any shared facts, merge them into `sharedFacts`:
   ```json
   "sharedFacts": {
     "teamSize": 5,
     "targetTools": ["Notion", "Slack", "QuickBooks"],
     "toolFitVerdict": "POOR",
     "roles": ["Founder", "Operations Manager"],
     "toolBudget": "...",
     "runningROI": {
       "estimatedAnnualWaste": 0,
       "estimatedAnnualSavings": 0,
       "estimatedAnnualCost": 0
     }
   }
   ```

   - `runningROI` — Preliminary ROI tally maintained across steps:
     - `estimatedAnnualWaste`: sum from step 3
     - `estimatedAnnualSavings`: sum from step 6
     - `estimatedAnnualCost`: tool costs from step 6
     Updated by steps 3, 6. Used by step 7 as cross-check against formal calculation.

4. **On resume:** When loading progress.json to resume a run, skip all steps that already have a `"status": "completed"` or `"status": "skipped"` entry. Continue from the first step that has no entry or has `"status": "failed"`. Reload `sharedFacts` from the saved state.
