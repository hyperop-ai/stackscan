# Execution Model — Teams + Subagent Hybrid

The pipeline hides all file operations from the main conversation. The user sees only clean narration, findings, and decision checkpoints.

## Mode Detection

At the start of Phase 2, determine which execution mode is available:

### Check for Agent Teams
Agent teams are experimental (requires `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`). To detect:
1. Check if the `teammate` tool/capability is available
2. If yes: use **Team Mode**
3. If no: use **Subagent Mode**

Announce to the user which mode is active:
- Team Mode: "Running in team mode — pipeline steps execute as independent teammates."
- Subagent Mode: "Running in subagent mode — pipeline steps execute as background agents."

---

## Team Mode (preferred)

When agent teams are available, the orchestrator acts as the **team lead**:

### Setup
1. Create a team with the task: "StackScan operational investment analysis for {company}"
2. For sequential waves (1, 2, 4, 5, 8, 9, 10): spawn ONE teammate per step
3. For parallel waves (3, 6, 7): spawn ALL teammates in the wave simultaneously
4. Each teammate gets:
   - The step's prompt template content
   - The shared rules (helpers.md)
   - The Data Resolution Protocol
   - Current shared facts
   - All required input file contents
   - Clear output instructions (which file to write, where)

### Per-step flow
1. Spawn teammate with step instructions
2. Teammate works independently (file writes are invisible to the lead)
3. Teammate sends a message back with: findings, assumptions, flags, shared facts, missing data
4. Lead receives message, presents to user per Communication Protocol
5. Lead updates progress.json
6. At decision checkpoints: lead pauses and asks user

### Parallel waves
For waves 3, 6, 7: spawn all teammates at once. Wait for all to send their completion messages. Present combined findings to user. Update progress.json for all completed steps.

### Cleanup
After Phase 2 completes (or if user stops), ask all teammates to shut down, then clean up the team.

---

## Subagent Mode (fallback)

When agent teams are NOT available, use the Agent tool with `run_in_background: true`:

### Per-step flow
1. Build the subagent prompt (same content as teammate prompt above)
2. Dispatch with Agent tool using `run_in_background: true`
   - This runs the subagent asynchronously — its file operations are NOT shown in the main thread
3. Wait for completion notification
4. Read the subagent's result (findings, assumptions, flags, shared facts)
5. Present to user per Communication Protocol
6. Update progress.json

### Parallel waves
For waves 3, 6, 7: dispatch ALL subagents with `run_in_background: true` simultaneously. Wait for all completion notifications. Present combined findings.

### Critical: Background execution
The key to hiding file diffs is `run_in_background: true`. When dispatching:
```
Use the Agent tool with:
  description: "Step N: {step name}"
  prompt: {assembled prompt with all inputs}
  run_in_background: true
```
The subagent writes files in the background. Only its final result message comes back to the main thread.

---

## What the user sees (both modes)

The main conversation thread shows ONLY:

1. Mode announcement ("Running in team/subagent mode")
2. Per-step findings (2-3 bullets)
3. Assumptions and confidence levels
4. Flags and concerns
5. Progress ("Step 7/15 complete. Next: assess risks. ~8 steps remaining.")
6. Decision checkpoint questions
7. Final delivery (investment brief + file list)

The user NEVER sees:
- File write/edit tool calls
- Raw file contents being written
- Prompt assembly details
- Subagent dispatch internals

---

## Subagent/Teammate Prompt Template

When dispatching a step (in either mode), the worker receives:

```
You are executing Step {N}: {display name} of a StackScan operational investment analysis.

## Your Task
{Content of the step's prompt template}

## Shared Rules
{Content of helpers.md}

## Data Resolution Protocol
{Content of data-resolution.md}

## Current Shared Facts
{JSON from progress.json sharedFacts}

## Agent Memory (if available)
{Content from ~/.stackscan/projects/{project}/memory.json, if exists}

## Input Files
{For each required input, include full content}

## Output Instructions
Write your output to: ~/.stackscan/projects/{project}/output/{output_filename}

## When Done
Send a message back (or return) with:
- **Findings:** 2-3 key findings
- **Assumptions:** With confidence (HIGH/MEDIUM/LOW) and source
- **Flags:** Anything concerning
- **Shared facts:** Any new facts to add (toolFitVerdict, roles, etc.)
- **Missing data:** Facts you needed but couldn't find
```

---

## Steps that run in the main thread

These steps should NOT be delegated:
- **Phase 0 (initialization)** — needs to interact with user about resume/reuse
- **Phase 1 (intake)** — inherently conversational
- **Step 13 (consistency check)** — makes routing decisions (LOOP_BACK/CONTINUE) that affect pipeline flow
- **Phase 3 (delivery)** — presents results to user

For step 13: read all the output files yourself (clipped), run the consistency analysis in the main thread, and make the routing decision directly. This avoids a round-trip delay for a decision that affects the entire pipeline.

---

## Effort Levels per Step Type

When dispatching workers, set effort level if the platform supports it:
- **Reasoning steps** (3, 4, 7, 8, 13): Maximum effort
- **Research steps** (2, 5): High effort
- **Generation steps** (1, 6, 9-12, 14, 15): Standard effort

---

## Context Clipping Strategy

When assembling worker prompts, clip input files to manage context:

| Step | Input | Max chars | Rationale |
|------|-------|-----------|-----------|
| 1-6 | company.md | full | Foundation data |
| 1-6 | process.md | full | Foundation data |
| 7 | inefficiencies.md | 6000 | Need all tables |
| 7 | new-process.md | 4000 | Need process outline |
| 7 | tool-budget.md | full | Need exact prices |
| 8-12 | Prior outputs | 4000 each | Key sections only |
| 13 | All outputs | 3000-5000 each | Per step-definitions.md |
| 14 | All outputs | 3000 each | Summary sufficient |
| 15 | All outputs | 2500 each | Per step-definitions.md |

When clipping, preserve: headers, tables, summary sections, and numbers. Cut: detailed prose, footnotes, reasoning chains.
