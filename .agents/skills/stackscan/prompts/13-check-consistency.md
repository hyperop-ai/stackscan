# Step 13: Check Consistency (Quality Gate)

You are a senior technical reviewer checking consistency across all analysis documents produced so far.

**This step is a quality gate.** If critical inconsistencies are found, the pipeline will loop back to the responsible step for regeneration.

---

## Context

Read the following files for context:

**Input files (company context):**
- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack, pain points, budget)
- `~/.stackscan/projects/{project}/process.md` -- current process documentation

**Output files (generated analysis -- clip each to ~3000-5000 chars if needed to manage context):**
- `~/.stackscan/projects/{project}/output/inefficiencies.md`
- `~/.stackscan/projects/{project}/output/tool-fit.md`
- `~/.stackscan/projects/{project}/output/tool-budget.md`
- `~/.stackscan/projects/{project}/output/new-process.md`
- `~/.stackscan/projects/{project}/output/setup.md`
- `~/.stackscan/projects/{project}/output/ROI.md`
- `~/.stackscan/projects/{project}/output/diff.md`
- `~/.stackscan/projects/{project}/output/risks.md`
- `~/.stackscan/projects/{project}/output/adoption-plan.md`
- `~/.stackscan/projects/{project}/output/role-guides/` (all files in directory)
- `~/.stackscan/projects/{project}/output/integration-checklist.md`

Also read `~/.stackscan/projects/{project}/progress.json` to retrieve `sharedFacts` (roles, targetTools, etc.) for cross-referencing.

---

## Task

Identify inconsistencies, contradictions, and issues across all documents. Check the following dimensions:

### 1. Input-to-Output Alignment
Does the analysis match the company context? Are recommendations appropriate for the team size, budget, and industry?

### 2. Cross-Document Consistency
Do recommendations align across documents? Are there contradictions between outputs?

### 3. Number Consistency (CRITICAL)
- Do the time estimates in `inefficiencies.md` match those cited in `ROI.md`?
- Do both documents use per-unit x volume breakdowns?
- Are "before" and "after" times both justified?

### 4. Capacity Plausibility (CRITICAL)
- Does the total weekly time claimed as savings fit within the team's actual capacity?
- Total capacity = team size x 40 hours/week
- If claimed savings exceed 40% of capacity, flag as HIGH severity.

### 5. Pricing Consistency (CRITICAL)
- Do ALL documents use the exact same tool names, tiers, and monthly costs?
- Are total monthly costs identical across `setup.md`, `tool-budget.md`, and `ROI.md`?
- Flag ANY pricing discrepancy as HIGH severity.

### 6. Confidence Markers
- Are confidence markers (HIGH/MEDIUM/LOW) present in `inefficiencies.md`?
- If more than 50% of estimates are LOW confidence, flag as HIGH severity.

### 7. Tool Name Consistency
- Are the same tool names used across all documents? (e.g., not "Notion" in one place and "notion.so" in another)

### 8. Factual Errors
- Unrealistic assumptions, missing connections, referenced items that don't exist.

### 9. Terminology Consistency
- Consistent role names, process step names, and tool references throughout.

---

## Reasoning Chain

For EACH finding:
1. **Quote** the specific text you found.
2. **Quote** the conflicting text from the other document.
3. **Explain** why this is a problem.
4. **Classify** severity (see below).

---

## Severity Levels

- **HIGH**: Contradictions that would cause incorrect decisions (wrong numbers, mismatched prices, capacity implausibility)
- **MEDIUM**: Inconsistencies that reduce quality (terminology drift, minor misalignment)
- **LOW**: Minor issues (formatting, style)

For HIGH severity findings, also specify:
- **Affected file(s):** which output file(s) need to be regenerated
- **Root cause:** which step produced the error
- **Recommended fix:** what specifically needs to change

---

## Output Format

Start the report with a summary line in this exact format:

```
HIGH: N | MEDIUM: N | LOW: N
```

Then list findings grouped by severity (HIGH first, then MEDIUM, then LOW).

Format as markdown with clear sections.

---

## CRITICAL: Decision Line

**The LAST line of your output must be EXACTLY one of the following (no extra text, no markdown formatting):**

- `CONTINUE` -- no HIGH-severity issues found, proceed to next step
- `LOOP_BACK:analyze_inefficiencies` -- time estimates are wrong, loop back to step 3
- `LOOP_BACK:evaluate_tool_fit` -- tool selection or pricing is wrong, loop back to step 4
- `LOOP_BACK:design_process` -- process design has fundamental issues, loop back to step 6
- `LOOP_BACK:calculate_roi` -- ROI calculations are wrong, loop back to step 7

**Rules for the decision line:**
- If there are ZERO HIGH-severity findings, output `CONTINUE`.
- If there are HIGH-severity findings, output the `LOOP_BACK:` directive targeting the earliest root-cause step.
- The orchestrator parses this last line to decide whether to continue or loop back. It MUST be on its own line with no surrounding text or formatting.

---

## Output File

Write to: `~/.stackscan/projects/{project}/output/consistency-report.md`
