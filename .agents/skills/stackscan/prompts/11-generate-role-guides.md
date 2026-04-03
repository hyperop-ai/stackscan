# Step 11: Generate Role Guides

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, roles, tool stack)
- `~/.stackscan/projects/{project}/output/diff.md` -- what changed between the old and new process
- `~/.stackscan/projects/{project}/output/new-process.md` -- the optimized process description
- `~/.stackscan/projects/{project}/output/research-findings.md` -- tool-specific research (if available, use for tool tips)

### Shared Facts

Read `~/.stackscan/projects/{project}/progress.json` and extract the `sharedFacts.roles` array. This is the list of roles to generate guides for.

- If `roles` contains entries, generate a guide for **each** listed role.
- If `roles` is empty or missing, identify 2--4 relevant roles from the company profile and new process (e.g., based on job titles, team members, or workflow responsibilities mentioned), then generate a guide for each identified role.

## Task

Generate role-specific quick-start guides for the new process. You must produce **one separate output file per role**.

For each role, generate:

### 1. What Changed for Me

2--3 bullet points summarizing the key changes this role will experience in the new process compared to the old one.

### 2. Quick-Start Guide

The 5 most important things this person needs to know on day 1 of the new process.

### 3. Training Checklist

A checkbox list of skills to learn, ordered from most critical to least. Include tool-specific skills where applicable.

### 4. Step-by-Step Walkthrough

A "How to use [primary tool] for [main task]" walkthrough tailored to this role's responsibilities. Use concrete steps the person can follow immediately.

### 5. Tips and Tricks

3--5 role-specific productivity tips drawn from the new process and research findings.

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

### Step-specific rules

- **One file per role.** Each role gets its own standalone markdown file. Do NOT combine multiple roles into one file.
- **Personalize each guide.** Generic advice that applies to everyone belongs in the new process doc, not here. Each guide should contain information specific to that role's responsibilities.
- **Ground tool tips in research.** If research findings document a tool feature, reference it. Do not invent features or capabilities not supported by the research.
- **Use the role's language.** Write at the level appropriate for the person in that role -- avoid jargon they would not use, but do not oversimplify their domain.
- **Keep it actionable.** Every section should contain things the person can do, not abstract descriptions.

## Output Format

Each file should be a standalone markdown document with the role name as the H1 heading, followed by the five sections above as H2 headings.

```markdown
# Role Guide: {RoleName}

## What Changed for Me
...

## Quick-Start Guide
...

## Training Checklist
...

## Step-by-Step Walkthrough
...

## Tips and Tricks
...
```

## Output Files

Write **one file per role** to: `~/.stackscan/projects/{project}/output/role-guides/{RoleName}.md`

Use the role name as the filename (e.g., `Office Manager.md`, `Sales Rep.md`). Create the `role-guides/` directory if it does not exist.
