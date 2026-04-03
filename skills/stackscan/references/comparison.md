# Comparison Procedure

When the user selects "Compare with another project", follow this procedure.

## 1. Select Projects

The current project is already selected as `projectB` (the newer one). Ask the user which completed project to compare against (`projectA`).

If only two completed projects exist, auto-select the other one as `projectA`.

## 2. Read Project Outputs

For both `projectA` and `projectB`, read the following files from `~/.stackscan/projects/{project}/output/`:

| File                   | Content                        |
|------------------------|--------------------------------|
| `ROI.md`               | Net savings, payback period    |
| `inefficiencies.md`    | Time waste per operation       |
| `tool-fit.md`          | Tool recommendations & scores  |
| `risks.md`             | Risk items and severity        |
| `adoption-summary.md`  | Overall adoption readiness     |

If a file is missing in one project but present in the other, note it as "newly added" or "removed" in the comparison.

## 3. Generate Comparison Report

Produce a structured markdown report with these sections:

### 3a. ROI Delta (lead with this -- primary metric)
- Net return change (dollar amount and percentage)
- Payback period change (months)
- Highlight whether the investment case strengthened or weakened

### 3b. Tool Allocation Changes
- Tools added in `projectB` that were not in `projectA`
- Tools removed (were in `projectA`, absent from `projectB`)
- Tools with changed fit scores or rationale

### 3c. Capital Efficiency Delta
- Per-operation comparison of estimated time reinvested
- Total hours recaptured delta
- Flag operations with the largest return improvement or regression

### 3d. Risk Profile Changes
- New risks introduced in `projectB`
- Risks resolved (present in `projectA`, absent from `projectB`)
- Severity changes for persistent risks

### 3e. Consistency & Adoption Changes
- New or resolved consistency issues
- Adoption readiness score delta
- Changes in role-specific guidance

## 4. Write Report

Write the full comparison report to:

```
~/.stackscan/comparison-{projectA}-vs-{projectB}.md
```

## 5. Present Key Deltas Inline

After writing the report, present a concise summary to the user covering:

- Overall investment case direction (strengthened / weakened / stable)
- Number of tool allocation changes
- Net return delta
- Risk count delta
- Path to the full comparison report
