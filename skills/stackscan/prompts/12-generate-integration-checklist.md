# Step 12: Generate Integration Checklist

> **Small team note:** If the team size is 3 or fewer, focus this checklist on items NOT already covered in setup.md. Reference setup.md for basic tool configuration and focus here on cross-tool integrations, data migration, and verification testing only. Avoid duplicating setup instructions.

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (current tool stack, existing systems)
- `~/.stackscan/projects/{project}/output/research-findings.md` -- documented integrations, API capabilities, and tool features

### Shared Facts

Read `~/.stackscan/projects/{project}/progress.json` and extract the `sharedFacts.targetTools` array. This is the list of tools to generate integration tasks for.

- If `targetTools` is empty or contains "Not provided", derive the tool list from the company profile and research findings.

## Task

Generate an actionable integration checklist that maps tool requirements to the company's existing systems. For each target tool, document the technical setup steps needed to get it running in the company's environment.

Cover the following areas for each tool:

### 1. Integration Requirements

What integrations does this tool need based on the research findings? Only list integrations that are documented in the research -- do not assume capabilities.

### 2. System Mapping

How does this tool connect to the company's existing systems? Identify which current tools it replaces, complements, or needs to exchange data with.

### 3. API and Authentication

- API endpoints needed (only if documented in research)
- Authentication requirements (OAuth, API keys, etc.)
- Rate limits or access restrictions noted in research

### 4. Data Migration

- What data needs to move from old systems to the new tool?
- What format does the data need to be in?
- Are there import tools or migration utilities documented in research?

### 5. Step-by-Step Integration Tasks

A checkbox list of concrete tasks to complete the integration, ordered sequentially.

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

### Step-specific rules

- **Grounding rule.** Only reference integration capabilities that are documented in the research findings. Do not assume APIs or integrations exist. If research is unavailable for a tool, state "Not verified -- requires manual research" rather than guessing.
- **Checkbox format.** Every actionable task must be a markdown checkbox (`- [ ]`) so the list can be used as a working checklist.
- **Group by tool.** Each target tool gets its own H2 section. Within each section, cover all five areas above.
- **Include verification steps.** After setup tasks, add a "Verification" checkbox for testing that the integration works (e.g., "Send a test record from X to Y and confirm it appears").
- **Flag blockers.** If research findings indicate a tool lacks a needed integration, call it out explicitly with a "BLOCKER" label and suggest a workaround if one exists.

## Output Format

Format as markdown with one H2 section per tool, containing the five areas above. End with a summary section.

```markdown
# Integration Checklist

## {Tool Name 1}

### Integration Requirements
...

### System Mapping
...

### API and Authentication
...

### Data Migration
...

### Setup Tasks
- [ ] ...
- [ ] ...
- [ ] Verify: ...

## {Tool Name 2}
...

## Summary
- Total tools: {N}
- Total tasks: {N}
- Blockers identified: {N}
```

### Automation Configs
For each automation identified in new-process.md, provide implementation details:
- Step-by-step setup for the recommended platform (n8n/Zapier/native)
- Expected trigger frequency and data volume
- Error handling: what happens if the automation fails?
- Testing: how to verify the automation works correctly

## Output File

Write to: `~/.stackscan/projects/{project}/output/integration-checklist.md`
