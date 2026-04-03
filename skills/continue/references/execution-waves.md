# Pipeline Execution Waves

The 15 steps are organized into waves. Steps within a wave run as parallel subagents. Waves execute sequentially.

| Wave | Steps | Parallel? | Notes |
|------|-------|-----------|-------|
| 1 | 1: create_plan | No | Foundation — extracts teamSize, targetTools |
| 2 | 2: research_tools | No | Needs plan.md |
| 3 | 3: analyze_inefficiencies, 4: evaluate_tool_fit | YES | Both need company.md + research-findings.md |
| 4 | 5: discover_tools | No | Conditional — skip if verdict != POOR |
| 5 | 6: design_process | No | Needs steps 3+4+5, produces 3 files |
| 6 | 7: calculate_roi, 8: assess_risks, 9: generate_diff | YES | All need new-process.md |
| 7 | 10: adoption_plan, 11: role_guides, 12: integration_checklist | YES | All need prior outputs |
| 8 | 13: check_consistency | No | Quality gate, runs in main thread |
| 9 | 14: generate_action_plan | No | Needs all prior outputs |
| 10 | 15: generate_summary | No | Final deliverable |

## Parallel Dispatch

For parallel waves (3, 6, 7), dispatch all subagents simultaneously using multiple Agent tool calls in a single message. Wait for ALL to complete before:
1. Collecting their findings
2. Presenting combined report to user
3. Updating progress.json for all completed steps
4. Proceeding to next wave

## Progress Reporting for Parallel Waves

When presenting parallel wave results, show them grouped:
"Wave 6 complete (3 steps in parallel):
- ROI Analysis: Net monthly return €239, payback 0.8 months
- Risk Assessment: 3 HIGH, 2 MEDIUM risks identified
- Process Diff: 8 major changes, 3 trade-offs
Step 9/15 complete. Next: adoption planning. ~6 steps remaining."

## Estimated Timeline with Parallelism

| Wave | Steps | Est. Time |
|------|-------|-----------|
| 1-2 | Sequential | ~4 min |
| 3 | Parallel (2 steps) | ~2 min |
| 4-5 | Sequential | ~3 min |
| 6 | Parallel (3 steps) | ~2 min |
| 7 | Parallel (3 steps) | ~2 min |
| 8-10 | Sequential | ~4 min |
| **Total** | | **~17 min** (vs ~25 min sequential) |
