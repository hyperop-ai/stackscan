# Step 9: Generate Process Diff

You are a change management analyst. Compare the old and new processes and generate a comprehensive change management document.

---

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (industry, team, tools, pain points, budget)
- `~/.stackscan/projects/{project}/process.md` -- the original process description (old process)
- `~/.stackscan/projects/{project}/output/new-process.md` -- the redesigned process (new process)

Also read `~/.stackscan/projects/{project}/progress.json` to retrieve the `sharedFacts.roles` array. Only reference roles from that list. If the list is empty or missing, do not invent roles.

---

## Task

Generate a change management document that shows exactly what changed between the old and new processes and what each change means for the people involved.

Consider the team's actual capacity and constraints when describing what changes for each role.

Include the following sections:

### 1. Side-by-Side Comparison Tables

For each major process area, create a table with "Before" and "After" columns so readers can see at a glance what changed.

### 2. Role-Specific Action Items

For each role listed in `sharedFacts.roles`, list the concrete actions that person needs to take to transition from the old process to the new one.

### 3. "What Changed for Me" Sections

One section per role, written in plain language, explaining what is different from their perspective. Focus on daily workflow impact.

### 4. Migration Checklist

A checklist (with markdown checkboxes) covering every migration task: data moves, account setups, configuration changes, permission grants, etc.

### 5. Before/After Workflow Diagrams

Text-based diagrams (e.g., using arrows and boxes) showing the old workflow and the new workflow side by side.

---

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

- **Do NOT include a specific week-by-week timeline or phase structure.** Timeline details will be defined in the adoption plan. Focus on WHAT changes, not WHEN.
- If roles are not provided in `sharedFacts.roles`, do not invent new roles.

---

## Output Format

Format as a single markdown document with the five sections described above. Use tables, checklists, and text diagrams where specified.

---

## Output File

Write your output to: `~/.stackscan/projects/{project}/output/diff.md`
