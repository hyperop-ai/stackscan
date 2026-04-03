# Step 8: Assess Risks

## Context

Read the following files for context:

- `~/.stackscan/projects/{project}/company.md` -- company profile (team size, budget, locale, roles)
- `~/.stackscan/projects/{project}/output/new-process.md` -- redesigned process with tool recommendations

Consider the actual team size, budget, and locale when assessing risks. A risk that is minor for a 50-person company may be critical for a 2-person team.

## Task

Analyze risks, gaps, and adoption hurdles for the new process. For each risk category below, identify specific risks grounded in the company context.

### Risk Categories

1. **Technical risks** -- what could go wrong with the tools and integrations (setup failures, API limitations, data migration issues, tool interoperability gaps).
2. **Organizational risks** -- team adoption resistance, workflow disruption, role confusion, change fatigue. Scale assessment to the actual team size.
3. **Financial risks** -- cost overruns, unexpected pricing changes, hidden fees, ROI shortfall.
4. **Timeline risks** -- implementation delays, training taking longer than expected, dependency bottlenecks.
5. **Regulatory risks** -- GDPR compliance gaps in proposed tools, industry-specific regulation violations, upcoming regulatory changes affecting recommended tools, data residency and cross-border transfer issues. Use WebSearch if available to check for upcoming regulations relevant to the company's country and industry.

### For each risk, provide

- **Risk description**: what specifically could go wrong, grounded in this company's situation.
- **Likelihood**: HIGH / MEDIUM / LOW with justification.
- **Impact**: HIGH / MEDIUM / LOW with justification.
- **Mitigation strategy**: concrete actions specific to this company's size and constraints. Do not suggest enterprise patterns for a 2-person team.
- **Estimated financial exposure:** If this risk materializes, the estimated cost is €X (= explain derivation). For example: "If PrestaShop module fails and manual invoicing continues for 3 months, cost = 3 × €45/mo = €135 in wasted time."
- **Rollback plan**: step-by-step instructions for reverting if the risk materializes.

## Rules

Reference: See `${CLAUDE_SKILL_DIR}/references/helpers.md` for shared quality rules.

The following rules from helpers.md apply to this step:

- **Grounding Rule** -- only reference tool features and integrations that appear in research findings or tool documentation
- **Team Size Scaling Rule** -- scale recommendations to the actual team size

### Step-specific rules

- Do NOT assume integrations exist between tools unless documentation explicitly mentions them. Flag unverified integrations as risks.
- Consider tool learning curves -- cite complexity from research findings where available.
- Address data transfer risks: what data lives in the old tools, how will it move, what could be lost.
- For small teams (3 or fewer), do not suggest pilot groups, change champions, or dedicated project manager roles.
- Every mitigation strategy must be actionable -- no vague advice like "communicate early and often."

## Reasoning Chain

For each risk category:

1. Identify the specific risk based on company context (team size, current tools, budget).
2. Assess likelihood and impact, citing research findings where applicable.
3. Propose concrete mitigation scaled to the team size.
4. Define a rollback plan with step-by-step instructions.

## Output Format

Format as markdown with the following structure:

### Risk Matrix Summary

| Risk | Category | Likelihood | Impact | Priority |
|------|----------|-----------|--------|----------|
| [short name] | [technical/organizational/financial/timeline/regulatory] | [H/M/L] | [H/M/L] | [H/M/L] |

Priority = highest of likelihood and impact.

### Detailed Risk Analysis

For each risk, a full section with description, likelihood, impact, mitigation, and rollback plan.

### Process Gaps

List anything the new process does not cover that the old process handled, or new gaps introduced by the redesign.

### Adoption Hurdles

Specific barriers to team adoption, ordered by severity. Consider:
- Team members who may resist the change and why.
- Tool learning curves with realistic time estimates.
- Workflow disruptions during the transition period.

## Output File

Write to: `~/.stackscan/projects/{project}/output/risks.md`
