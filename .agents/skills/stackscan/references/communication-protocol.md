# Communication Protocol

After EVERY step, present to the user:

## Step Report (mandatory)
- **What you found:** 2-3 key findings or decisions from this step
- **Assumptions made:** List any estimates, inferences, or guesses — with confidence level (HIGH/MEDIUM/LOW)
- **Flags:** Anything concerning, surprising, or that needs the user's attention
- **Financial signal:** Estimated monetary impact of this step's findings (preliminary — formal ROI in step 7). Show the derivation: "~€X/year (= formula)"
- **Progress:** "Step {N}/15 complete. Next: {next_step_name}. {remaining} steps remaining."

## Assumption Confirmation Gate

After steps 3 (analyze_inefficiencies), 6 (design_process), and 7 (calculate_roi), the orchestrator MUST:

1. Extract the top 3-5 assumptions that most affect downstream numbers from the step output
2. Present them as a numbered list with the assumed value, confidence, and sensitivity:

> These assumptions drive the numbers. Please confirm or correct:
> 1. **Hourly rate:** €25/hr (LOW confidence — estimated, no payroll data)
>    → If actually €35/hr, annual savings increase by 40%
> 2. **New artworks per month:** 8 (LOW — industry estimate)
>    → If actually 3, data entry savings drop by 62%
> 3. **Invoice creation time:** 15 min/invoice (MEDIUM — benchmark)

3. **WAIT for user response** before marking the step complete
4. If user corrects an assumption:
   - Minor correction (< 20% change): note the correction, adjust numbers inline, proceed
   - Major correction (> 20% change): re-run the step with corrected inputs
5. Record confirmed assumptions in progress.json:
   ```json
   "confirmedAssumptions": {
     "hourlyRate": { "value": 25, "unit": "EUR/hr", "confirmedBy": "user", "confidence": "HIGH" },
     "artworksPerMonth": { "value": 8, "confirmedBy": "user", "confidence": "HIGH" }
   }
   ```
6. Once confirmed, downstream steps can use these as HIGH confidence data

## Decision Checkpoints (at specific steps)
At these steps, PAUSE and ask the user before continuing:

- **After Step 4 (evaluate_tool_fit):** "Your current tools scored {verdict}. {If POOR: 'I'll search for alternatives next.' | If ADEQUATE/GOOD: 'I'll skip the tool discovery step and optimize what you have. Want me to search for alternatives anyway?'}"
- **After Step 6 (design_process):** Show the proposed new process summary (3-5 bullets) and tool budget headline. Ask: "Does this direction look right before I calculate ROI?"
- **After Step 7 (calculate_roi):** Show headline numbers (weekly savings, monthly net, payback period). Ask: "Do these numbers match your experience? Should I adjust any assumptions (hourly rate, volumes, time estimates)?"
- **After Step 13 (check_consistency):** If issues found, show them and ask: "Should I loop back and fix these, or proceed as-is?"

## Interruptibility
If the user interrupts at ANY point with corrections, new data, or changed assumptions:
1. Acknowledge the change
2. Update the relevant input or output files
3. Note which downstream steps may be affected
4. Ask: "Should I re-run from step {affected_step}, or continue forward and address this in the consistency check?"

## Progress Estimation
Rough timing per step type:
- Research steps (2, 5): ~2-3 minutes (web search)
- Reasoning steps (3, 4, 7, 8, 13): ~1-2 minutes
- Generation steps (1, 6, 9, 10, 11, 12, 14, 15): ~1 minute
- Total estimated: ~20-25 minutes for a full run
